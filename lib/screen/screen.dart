import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/constant/theme.dart';
import 'package:task_manager/view/view_controller.dart';

import '../common/search_bar.dart';
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
          title: Text(
            'Task Manager',
            style: kTittle,
          ),
          actions: [
            Row(
              children: [
                Search(
                  width: 200,
                  hintText: 'Search by Title',
                  searchText: (String text) {
                    if (text.isEmpty) {
                      viewController.setIsSearchedEnabled(false);
                    } else {
                      viewController.setIsSearchedEnabled(true);
                      viewController.serchForTittle(text);
                    }
                  },
                ),
                // Container(
                //   width: 200,
                //   height: 40,
                //   child: TextField(
                //     controller: viewController.searchController,
                //     style: TextStyle(color: Colors.white),
                //     keyboardType: TextInputType.text,
                //     decoration: kAddTextFieldDecoration.copyWith(
                //       hintText: 'Search here',
                //       suffixIcon: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.search,
                //             color: Colors.white,
                //           )),
                //       hintStyle: kTittle,
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         borderSide: BorderSide(color: Colors.white),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         borderSide: BorderSide(color: Colors.white),
                //       ),
                //     ),
                //     onChanged: (search) {
                //       // if (viewController.searchController.text ==
                //       //         viewController.tittleController.text ||
                //       //     viewController.searchController.text ==
                //       //         viewController.descriptionController.text ||
                //       //     viewController.searchController.text ==
                //       //         viewController.selectedLvl ||
                //       //     viewController.searchController.text ==
                //       //         viewController.dateTime) {}
                //     },
                //     onSubmitted: (text) {
                //       print('text$text'
                //           '');
                //     },
                //   ),
                // ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Priority') {
                      viewController.sortTasksByPriority();
                    } else if (value == 'Due Date') {
                      viewController.sortTasksByDueDate();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return {'Priority', 'Due Date'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.teal.shade300,
        body: ListView.builder(
          itemCount: viewController.getList().length,
          itemBuilder: (context, index) => ListTile(
            title: Text(
              viewController.getList()[index].title,
              style: kTittle,
            ),
            subtitle: Text(
              '${viewController.getList()[index].description}\nPriority: ${viewController.getList()[index].priorityLevel}\nDue: ${viewController.getList()[index].dueDate.toLocal()}',
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
                          index: index, tasks: viewController.getList()[index]),
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
