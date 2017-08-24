#include "../demo_addresses.hpp"
#include "medianFilterStream.h"
#include "messages/op_codes.h"
#include <chrono>
#include <component.hpp>
#include <iostream>
#include <local_communicator.hpp>
#include <local_component_routing_table.hpp>
#include <messages/local/local_hello.h>
#include <messages/spa/spa_data.h>
#include <messages/spa/subscription_reply.h>
#include <messages/spa/subscription_request.h>
#include <mutex>
#include <socket/clientSocket.hpp>
#include <thread>
#include <unistd.h>

//#define MEDIAN_VERBOSE
#define LIVE_GRAPHS_MEDIAN

class MedianFilterComponent;

void messageCallback(std::shared_ptr<Component> comp, cubiumClientSocket_t* sock);

class MedianFilterComponent : public Component
{
public:
  MedianFilterComponent(std::shared_ptr<SpaCommunicator> com = nullptr) : Component(com), lightStream(32), tempStream(32)
  {
  }

  virtual void handleSpaData(SpaMessage* message)
  {

    auto op = message->spaHeader.opcode;
#ifdef MEDIAN_VERBOSE
    std::cout << "Received SpaMessage with opcode: " << (int)op << '\n';
#endif

    if (op == op_SPA_SUBSCRIPTION_REQUEST)
    {
      SubscriptionReply reply(message->spaHeader.source, la_medianFilter);
      communicator->send((SpaMessage*)&reply);
      if (addSubscriber(message->spaHeader.source, 0))
      {
#ifdef MEDIAN_VERBOSE
        std::cout << "Added " << message->spaHeader.source << " as a subscriber" << std::endl;
#endif
      }
      publish();
    }

    else if (op == op_SPA_DATA)
    {
      auto dataMessage = (SpaData*)message;
#ifdef MEDIAN_VERBOSE
      std::cout << "Received data with payload: " << (int)dataMessage->payload << " from " << message->spaHeader.source << std::endl;
#endif
      float payload = dataMessage->payload;

      {
        std::lock_guard<std::mutex> lock(streamMutex);
        if (message->spaHeader.source == la_temp)
        {
          tempStream.in(payload);
          std::cout << "2:" << payload << std::endl;
          std::cout << "1:" << tempStream.out() << std::endl;
#ifdef MEDIAN_VERBOSE
          std::cout << "Temp in : " << payload << std::endl;
          std::cout << tempStream.print() << std::endl;
#endif
       }
        else if (message->spaHeader.source == la_light)
        {
          lightStream.in(payload);
          std::cout << "3:" << payload << std::endl;
          std::cout << "0:" << lightStream.out() << std::endl;
#ifdef MEDIAN_VERBOSE
          std::cout << "Light in : " << payload << std::endl;
          std::cout << lightStream.print() << std::endl;
#endif
       }
      }
    }
  }

  virtual void sendSpaData(LogicalAddress address)
  {
    auto payload = 0;
    float light;
    float temp;

    {
      std::lock_guard<std::mutex> lock(streamMutex);
      light = lightStream.out();
      temp = tempStream.out();
    }

#ifdef MEDIAN_VERBOSE
    std::cout << "Lightstream: " << lightStream.print() << std::endl;
    std::cout << "Tempstream: " << tempStream.print() << std::endl;
    std::cout << "Filtered light/temp: " << light << " / " << temp << std::endl;
#endif

    if (light >= 32 && temp >= -100)
    {
      payload = 1;
    }

#ifdef MEDIAN_VERBOSE
    std::cout << "Sending SpaData: " << payload << std::endl;
#endif

    SpaData dataMessage(address, la_medianFilter, payload);
    communicator->send((SpaMessage*)&dataMessage);
    if(payload == 1)
    {
      sleep(7);
    }
  }

  virtual void appInit()
  {
#ifdef MEDIAN_VERBOSE
    std::cout << "Median filter initializing!" << '\n';
#endif

    LocalHello hello(0, 0, la_LSM, la_medianFilter, 0, 0, 0, 0);

    communicator->getLocalCommunicator()->clientConnect((SpaMessage*)&hello, sizeof(hello), [=](cubiumClientSocket_t* s) { messageCallback(shared_from_this(), s); });

    SubscriptionRequest request1(la_light, la_medianFilter, la_LSM);
    communicator->getLocalCommunicator()->initSubDialogue((SpaMessage*)&request1, sizeof(request1), [=](cubiumClientSocket_t* s) { messageCallback(shared_from_this(), s); });

    SubscriptionRequest request2(la_temp, la_medianFilter, la_LSM);
    communicator->getLocalCommunicator()->initSubDialogue((SpaMessage*)&request2, sizeof(request2), [=](cubiumClientSocket_t* s) { messageCallback(shared_from_this(), s); });

    communicator->getLocalCommunicator()->clientListen(
        [=](cubiumClientSocket_t* s) { messageCallback(shared_from_this(), s); });
  }

private:
  MedianFilterStream lightStream;
  MedianFilterStream tempStream;
  std::mutex streamMutex;
};

void messageCallback(std::shared_ptr<Component> comp, cubiumClientSocket_t* sock)
{
  SpaMessage* message = (SpaMessage*)sock->buf;
  comp->handleSpaData(message);
  return;
}

int main()
{
  cubiumClientSocket_t sock = clientSocket_openSocket(3500);
  auto routingTable = std::make_shared<RoutingTable<cubiumServerSocket_t>>();

  std::vector<std::shared_ptr<PhysicalCommunicator>> comms = {
      std::make_shared<LocalCommunicator>(&sock, routingTable, la_medianFilter)};
  std::shared_ptr<SpaCommunicator> spaCom = std::make_shared<SpaCommunicator>(la_medianFilter, comms);

  auto comp = std::make_shared<MedianFilterComponent>(spaCom);
  comp->appInit();

  return 0;
}