# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.0

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Cubium

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Cubium

# Include any dependencies generated for this target.
include demo/component/CMakeFiles/example_component.dir/depend.make

# Include the progress variables for this target.
include demo/component/CMakeFiles/example_component.dir/progress.make

# Include the compile flags for this target's objects.
include demo/component/CMakeFiles/example_component.dir/flags.make

demo/component/CMakeFiles/example_component.dir/example_component.cpp.o: demo/component/CMakeFiles/example_component.dir/flags.make
demo/component/CMakeFiles/example_component.dir/example_component.cpp.o: demo/component/example_component.cpp
	$(CMAKE_COMMAND) -E cmake_progress_report /Cubium/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building CXX object demo/component/CMakeFiles/example_component.dir/example_component.cpp.o"
	cd /Cubium/demo/component && /usr/bin/c++   $(CXX_DEFINES) $(CXX_FLAGS) -o CMakeFiles/example_component.dir/example_component.cpp.o -c /Cubium/demo/component/example_component.cpp

demo/component/CMakeFiles/example_component.dir/example_component.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/example_component.dir/example_component.cpp.i"
	cd /Cubium/demo/component && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -E /Cubium/demo/component/example_component.cpp > CMakeFiles/example_component.dir/example_component.cpp.i

demo/component/CMakeFiles/example_component.dir/example_component.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/example_component.dir/example_component.cpp.s"
	cd /Cubium/demo/component && /usr/bin/c++  $(CXX_DEFINES) $(CXX_FLAGS) -S /Cubium/demo/component/example_component.cpp -o CMakeFiles/example_component.dir/example_component.cpp.s

demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.requires:
.PHONY : demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.requires

demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.provides: demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.requires
	$(MAKE) -f demo/component/CMakeFiles/example_component.dir/build.make demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.provides.build
.PHONY : demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.provides

demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.provides.build: demo/component/CMakeFiles/example_component.dir/example_component.cpp.o

# Object files for target example_component
example_component_OBJECTS = \
"CMakeFiles/example_component.dir/example_component.cpp.o"

# External object files for target example_component
example_component_EXTERNAL_OBJECTS =

demo/component/example_component: demo/component/CMakeFiles/example_component.dir/example_component.cpp.o
demo/component/example_component: demo/component/CMakeFiles/example_component.dir/build.make
demo/component/example_component: lib/libCubium.a
demo/component/example_component: demo/component/CMakeFiles/example_component.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking CXX executable example_component"
	cd /Cubium/demo/component && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/example_component.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
demo/component/CMakeFiles/example_component.dir/build: demo/component/example_component
.PHONY : demo/component/CMakeFiles/example_component.dir/build

demo/component/CMakeFiles/example_component.dir/requires: demo/component/CMakeFiles/example_component.dir/example_component.cpp.o.requires
.PHONY : demo/component/CMakeFiles/example_component.dir/requires

demo/component/CMakeFiles/example_component.dir/clean:
	cd /Cubium/demo/component && $(CMAKE_COMMAND) -P CMakeFiles/example_component.dir/cmake_clean.cmake
.PHONY : demo/component/CMakeFiles/example_component.dir/clean

demo/component/CMakeFiles/example_component.dir/depend:
	cd /Cubium && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Cubium /Cubium/demo/component /Cubium /Cubium/demo/component /Cubium/demo/component/CMakeFiles/example_component.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : demo/component/CMakeFiles/example_component.dir/depend

