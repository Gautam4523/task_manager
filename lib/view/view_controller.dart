import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/task_model.dart';

class ViewController extends GetxController {
  final TextEditingController tittleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final RxList<Task> _tasks = RxList([
    Task(
        title: 'Complete Homework',
        description: 'Finish math and science homework.',
        priorityLevel: 'High',
        dueDate: DateTime.now().add(Duration(days: 1))),
    Task(
        title: 'Grocery Shopping',
        description: 'Buy groceries for the week.',
        priorityLevel: 'Medium',
        dueDate: DateTime.now().add(Duration(days: 3))),
    Task(
        title: 'Gym Workout',
        description: 'Complete a full-body workout.',
        priorityLevel: 'Low',
        dueDate: DateTime.now().add(Duration(days: 2))),
  ]);
  List<Task> get tasks => _tasks;

  setTask(List<Task> value) {
    _tasks.clear();
    _tasks.addAll(value);
  }

  void deleteTasks(int index) {
    tasks.removeAt(index);
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void clearTask() {
    tittleController.clear();
    descriptionController.clear();
    setSelectedLvl('Low');
    setDateTime(DateTime.now());
  }

  int getPriorityValue(String priority) {
    switch (priority) {
      case "High":
        return 3;
      case "Medium":
        return 2;
      case "Low":
        return 1;
      default:
        return 0;
    }
  }

  void sortTasksByPriority() {
    tasks.sort((a, b) => getPriorityValue(b.priorityLevel)
        .compareTo(getPriorityValue(a.priorityLevel)));
  }

  void sortTasksByDueDate() {
    tasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
  }

  final RxList<Task> _searchedList = RxList([]);
  List<Task> get searchedList => _searchedList;

  setSearchedList(List<Task> value) {
    _searchedList.value = value;
  }

  final RxBool _isSearchedEnabled = RxBool(false);
  bool get isSearchedEnabled => _isSearchedEnabled.value;

  setIsSearchedEnabled(bool value) {
    _isSearchedEnabled.value = value;
  }

  List<Task> getList() {
    if (isSearchedEnabled) {
      return searchedList;
    } else {
      return tasks;
    }
  }

  serchForTittle(String text) {
    List<Task> tempList = [];
    for (var task in _tasks) {
      if (task.title.toLowerCase().contains(text.toLowerCase())) {
        tempList.add(task);
      }
    }
    setSearchedList(tempList);
  }

  Rxn _addDateTime = Rxn();
  DateTime get dateTime => _addDateTime.value;
  setDateTime(DateTime value) {
    _addDateTime.value = value;
  }

  // RxString _addTittle = RxString('');
  // String get addTittle => _addTittle.value;
  // setAddTittle(String value) {
  //   _addTittle.value = value;
  // }
  //
  // RxString _addDescription = RxString('');
  // String get addDescription => _addDescription.value;
  // setAddDescription(String value) {
  //   _addDescription.value = value;
  // }

  RxString _selectedLvl = RxString('Low');
  String get selectedLvl => _selectedLvl.value;
  setSelectedLvl(String value) {
    _selectedLvl.value = value;
  }

  List<String> level = ['Low', 'Medium', 'High'];

  List<DropdownMenuItem<String>> getDropdownItem() {
    List<DropdownMenuItem<String>> dropdownItem = [];

    for (String lvl in level) {
      var newItem = DropdownMenuItem(
        value: lvl,
        child: Text(
          lvl,
          style: TextStyle(color: Colors.white),
        ),
      );
      dropdownItem.add(newItem);
    }
    return dropdownItem;
  }
}
