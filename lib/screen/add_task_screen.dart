import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/constant/theme.dart';
import 'package:task_manager/view/view_controller.dart';

import '../model/task_model.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key, this.index, this.tasks});
  final ViewController viewController = Get.put(ViewController());

  final int? index;
  final Task? tasks;
  @override
  Widget build(BuildContext context) {
    DateTime dueDate = DateTime.now();
    if (tasks != null && index != null) {
      viewController.tittleController.text = tasks!.title;
      viewController.descriptionController.text = tasks!.description;
      viewController.setSelectedLvl(tasks!.priorityLevel);
      dueDate = tasks!.dueDate;
      viewController.setDateTime(tasks!.dueDate);
    }

    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        height: 500,
        width: double.infinity,
        decoration: kAddTaskDecoration,
        child: Column(
          children: [
            Text('Add Task', style: kAddTasktittle),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: TextField(
                controller: viewController.tittleController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                decoration:
                    kAddTextFieldDecoration.copyWith(hintText: 'Tittle'),
                onChanged: (tittle) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: TextField(
                controller: viewController.descriptionController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                decoration:
                    kAddTextFieldDecoration.copyWith(hintText: 'Description'),
                onChanged: (description) {},
              ),
            ),
            DropdownButton(
              items: viewController.getDropdownItem(),
              value: viewController.selectedLvl,
              onChanged: (String? value) {
                viewController.setSelectedLvl(value.toString());
              },
              dropdownColor: Colors.teal,
            ),
            InkWell(
              child: Container(
                  height: 40,
                  width: 120,
                  color: Colors.blueAccent,
                  child: Center(
                      child: Text(
                    'Choose Due Date',
                    style: kTittle,
                  ))),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: dueDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  viewController.setDateTime(pickedDate);
                } else {
                  viewController.setDateTime(dueDate);
                }
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: kAdd,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (index != null) {
                      Task tmpTask = Task(
                          title: viewController.tittleController.text,
                          description:
                              viewController.descriptionController.text,
                          priorityLevel: viewController.selectedLvl,
                          dueDate: viewController.dateTime);
                      viewController.tasks[index!] = tmpTask;
                      Navigator.pop(context);
                    } else {
                      viewController.addTask(Task(
                          title: viewController.tittleController.text,
                          description:
                              viewController.descriptionController.text,
                          priorityLevel: viewController.selectedLvl,
                          dueDate: viewController.dateTime ?? DateTime.now()));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Save',
                    style: kAdd,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
