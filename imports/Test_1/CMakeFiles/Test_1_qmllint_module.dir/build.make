# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.30

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/zz6/Git/Test_1_BasicProgram_Notes

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/zz6/Git/Test_1_BasicProgram_Notes

# Utility rule file for Test_1_qmllint_module.

# Include any custom commands dependencies for this target.
include imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/compiler_depend.make

# Include the progress variables for this target.
include imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/progress.make

imports/Test_1/CMakeFiles/Test_1_qmllint_module: /usr/lib/qt6/bin/qmllint
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/Constants.qml
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/DirectoryFontLoader.qml
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/EventListModel.qml
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/EventListSimulator.qml
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/CustomMenuBar.qml
imports/Test_1/CMakeFiles/Test_1_qmllint_module: imports/Test_1/.rcc/qmllint/Test_1_module.rsp
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/lib/qt6/bin/qmllint @/home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/.rcc/qmllint/Test_1_module.rsp

Test_1_qmllint_module: imports/Test_1/CMakeFiles/Test_1_qmllint_module
Test_1_qmllint_module: imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/build.make
.PHONY : Test_1_qmllint_module

# Rule to build all files generated by this target.
imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/build: Test_1_qmllint_module
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/build

imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/clean:
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && $(CMAKE_COMMAND) -P CMakeFiles/Test_1_qmllint_module.dir/cmake_clean.cmake
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/clean

imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/depend:
	cd /home/zz6/Git/Test_1_BasicProgram_Notes && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zz6/Git/Test_1_BasicProgram_Notes /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 /home/zz6/Git/Test_1_BasicProgram_Notes /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmllint_module.dir/depend

