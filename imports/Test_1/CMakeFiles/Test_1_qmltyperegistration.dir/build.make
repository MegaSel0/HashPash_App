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

# Utility rule file for Test_1_qmltyperegistration.

# Include any custom commands dependencies for this target.
include imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/compiler_depend.make

# Include the progress variables for this target.
include imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/progress.make

imports/Test_1/CMakeFiles/Test_1_qmltyperegistration: imports/Test_1/test_1_qmltyperegistrations.cpp
imports/Test_1/CMakeFiles/Test_1_qmltyperegistration: qml/Test_1/Test_1.qmltypes

imports/Test_1/test_1_qmltyperegistrations.cpp: imports/Test_1/qmltypes/Test_1_foreign_types.txt
imports/Test_1/test_1_qmltyperegistrations.cpp: imports/Test_1/meta_types/qt6test_1_metatypes.json
imports/Test_1/test_1_qmltyperegistrations.cpp: /usr/lib/qt6/qmltyperegistrar
imports/Test_1/test_1_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qml_relwithdebinfo_metatypes.json
imports/Test_1/test_1_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6core_relwithdebinfo_metatypes.json
imports/Test_1/test_1_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6qmlbuiltins_relwithdebinfo_metatypes.json
imports/Test_1/test_1_qmltyperegistrations.cpp: /usr/lib/qt6/metatypes/qt6network_relwithdebinfo_metatypes.json
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/zz6/Git/Test_1_BasicProgram_Notes/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Automatic QML type registration for target Test_1"
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/lib/qt6/qmltyperegistrar --generate-qmltypes=/home/zz6/Git/Test_1_BasicProgram_Notes/qml/Test_1/Test_1.qmltypes --import-name=Test_1 --major-version=1 --minor-version=0 @/home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/qmltypes/Test_1_foreign_types.txt -o /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/test_1_qmltyperegistrations.cpp /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/qt6test_1_metatypes.json
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E make_directory /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/.qt/qmltypes
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E touch /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/.qt/qmltypes/Test_1.qmltypes

qml/Test_1/Test_1.qmltypes: imports/Test_1/test_1_qmltyperegistrations.cpp
	@$(CMAKE_COMMAND) -E touch_nocreate qml/Test_1/Test_1.qmltypes

imports/Test_1/meta_types/qt6test_1_metatypes.json: imports/Test_1/meta_types/qt6test_1_metatypes.json.gen
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/zz6/Git/Test_1_BasicProgram_Notes/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating meta_types/qt6test_1_metatypes.json"
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E true

imports/Test_1/meta_types/qt6test_1_metatypes.json.gen: /usr/lib/qt6/moc
imports/Test_1/meta_types/qt6test_1_metatypes.json.gen: imports/Test_1/meta_types/Test_1_json_file_list.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/zz6/Git/Test_1_BasicProgram_Notes/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Running moc --collect-json for target Test_1"
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/lib/qt6/moc -o /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/qt6test_1_metatypes.json.gen --collect-json @/home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/Test_1_json_file_list.txt
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E copy_if_different /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/qt6test_1_metatypes.json.gen /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/qt6test_1_metatypes.json

imports/Test_1/meta_types/Test_1_json_file_list.txt: /usr/lib/qt6/cmake_automoc_parser
imports/Test_1/meta_types/Test_1_json_file_list.txt: imports/Test_1/Test_1_autogen/timestamp
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/zz6/Git/Test_1_BasicProgram_Notes/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Running AUTOMOC file extraction for target Test_1"
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/lib/qt6/cmake_automoc_parser --cmake-autogen-cache-file /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/CMakeFiles/Test_1_autogen.dir/ParseCache.txt --cmake-autogen-info-file /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/CMakeFiles/Test_1_autogen.dir/AutogenInfo.json --output-file-path /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/Test_1_json_file_list.txt --timestamp-file-path /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/meta_types/Test_1_json_file_list.txt.timestamp --cmake-autogen-include-dir-path /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/Test_1_autogen/include

imports/Test_1/Test_1_autogen/timestamp: /usr/lib/qt6/moc
imports/Test_1/Test_1_autogen/timestamp: imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/zz6/Git/Test_1_BasicProgram_Notes/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Automatic MOC and UIC for target Test_1"
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E cmake_autogen /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/CMakeFiles/Test_1_autogen.dir/AutogenInfo.json ""
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && /usr/bin/cmake -E touch /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/Test_1_autogen/timestamp

Test_1_qmltyperegistration: imports/Test_1/CMakeFiles/Test_1_qmltyperegistration
Test_1_qmltyperegistration: imports/Test_1/Test_1_autogen/timestamp
Test_1_qmltyperegistration: imports/Test_1/meta_types/Test_1_json_file_list.txt
Test_1_qmltyperegistration: imports/Test_1/meta_types/qt6test_1_metatypes.json
Test_1_qmltyperegistration: imports/Test_1/meta_types/qt6test_1_metatypes.json.gen
Test_1_qmltyperegistration: imports/Test_1/test_1_qmltyperegistrations.cpp
Test_1_qmltyperegistration: qml/Test_1/Test_1.qmltypes
Test_1_qmltyperegistration: imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/build.make
.PHONY : Test_1_qmltyperegistration

# Rule to build all files generated by this target.
imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/build: Test_1_qmltyperegistration
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/build

imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/clean:
	cd /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 && $(CMAKE_COMMAND) -P CMakeFiles/Test_1_qmltyperegistration.dir/cmake_clean.cmake
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/clean

imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/depend:
	cd /home/zz6/Git/Test_1_BasicProgram_Notes && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/zz6/Git/Test_1_BasicProgram_Notes /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 /home/zz6/Git/Test_1_BasicProgram_Notes /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1 /home/zz6/Git/Test_1_BasicProgram_Notes/imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : imports/Test_1/CMakeFiles/Test_1_qmltyperegistration.dir/depend
