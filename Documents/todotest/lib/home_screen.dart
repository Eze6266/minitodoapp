// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/enter_todo_title.dart';
import 'package:todotest/reusables.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('tasks').get();

    setState(() {
      tasks = snapshot.docs
          .map(
              (doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  void editTask(Task task, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnterTodoTitle(task: task),
      ),
    );
    if (result != null) {
      setState(() {
        tasks[index] = result;
      });
    }
  }

  void deleteTask(Task task, int index) async {
    await FirebaseFirestore.instance.collection('tasks').doc(task.id).delete();
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            tasks.isEmpty ? SizedBox.shrink() : HomeTopBanner(),
            Height(h: 3),
            tasks.isEmpty
                ? Expanded(
                    child: EmptyListContainer(size: size),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => editTask(tasks[index], index),
                          child: TaskItem(
                            task: tasks[index],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2 * size.width / 100,
              vertical: 2 * size.height / 100,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.grey.shade700,
                  size: 22,
                ),
                Width(w: 1),
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ...task.todos.map((todo) {
            return ListTile(
              leading: CustomCheckbox(
                value: todo.isDone,
                onChanged: (value) {
                  // Implement the toggle logic if needed
                },
              ),
              title: Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            );
          }).toList(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 3 * size.width / 100,
              vertical: 1 * size.height / 100,
            ),
            height: 5 * size.height / 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: kText(
                txt: 'Task',
                txtColor: Colors.white,
                weight: FontWeight.w400,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
