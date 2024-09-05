import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/constant/theme.dart';
import 'package:task_manager/view/view_controller.dart';

import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  final ViewController viewController = Get.put(ViewController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          backgroundColor: Colors.blueAccent,
          child: Icon(
            Icons.add,
            color: Colors.tealAccent,
            size: 30,
          ),
          onPressed: () {
            viewController.clearTask();
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(
            child: Text(
              'Task Manager',
              style: kTittle,
            ),
          ),
        ),
        backgroundColor: Colors.teal.shade300,
        body: ListView.builder(
          itemCount: viewController.tasks.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              viewController.tasks[index].title,
              style: kTittle,
            ),
            subtitle: Text(
              '${viewController.tasks[index].description}\nPriority: ${viewController.tasks[index].priorityLevel}\nDue: ${viewController.tasks[index].dueDate.toLocal()}',
              style: kSubTittle,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Edit Icon with Custom Color
                IconButton(
                  icon: Icon(Icons.edit,
                      color: Colors.teal), // Change the color here
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => AddTaskScreen(
                          index: index, tasks: viewController.tasks[index]),
                    );

                    // _showTaskDialog(context,
                    //     index: index, task: task); // Edit Task
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    viewController.deleteTasks(index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
