// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/reusables.dart';

import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/reusables.dart';

import 'package:flutter/material.dart';
import 'package:todotest/app_colors.dart';
import 'package:todotest/reusables.dart';

class EnterTodoTitle extends StatefulWidget {
  final Task? task;

  const EnterTodoTitle({super.key, this.task});

  @override
  State<EnterTodoTitle> createState() => _EnterTodoTitleState();
}

class _EnterTodoTitleState extends State<EnterTodoTitle> {
  TextEditingController titleController = TextEditingController();
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      todos = List.from(widget.task!.todos);
    }
  }

  void addTodo(String title) {
    setState(() {
      todos.add(Todo(
        title: title,
        isDone: false,
      ));
    });
  }

  void toggleTodoStatus(int index) {
    setState(() {
      todos[index].isDone = !todos[index].isDone;
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void saveTask() async {
    if (titleController.text.isNotEmpty && todos.isNotEmpty) {
      Task task = Task(
        id: widget.task?.id ?? '',
        title: titleController.text,
        todos: List.from(todos),
      );

      if (widget.task == null) {
        // Add new task
        await FirebaseFirestore.instance.collection('tasks').add(task.toMap());
      } else {
        // Update existing task
        await FirebaseFirestore.instance
            .collection('tasks')
            .doc(task.id)
            .update(task.toMap());
      }

      Navigator.pop(context, task);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Height(h: 2),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      Width(w: 2),
                      kText(
                        txt: 'Back',
                        size: 16,
                        weight: FontWeight.w500,
                        txtColor: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                Height(h: 1),
                Divider(),
                Height(h: 2),
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
                Height(h: 2),
                AddMainTaskWidget(
                  active: titleController.text.isEmpty ? false : true,
                  onTap: () {
                    if (titleController.text.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return showAddTodoDialog(addTodo);
                        },
                      );
                    }
                  },
                ),
                Height(h: 2),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      todo: todos[index],
                      toggleTodoStatus: () => toggleTodoStatus(index),
                      deleteTodo: () => deleteTodo(index),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: saveTask,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.primaryColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: kText(
                txt: 'Save',
                size: 16,
                txtColor: Colors.white,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////////////////////////********** ***********///////////////////////////
class showAddTodoDialog extends StatelessWidget {
  final Function(String) addTodo;
  final TextEditingController todoController = TextEditingController();

  showAddTodoDialog(this.addTodo);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: Colors.white,
      child: Container(
        width: 90 * size.width / 100,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter todo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Height(h: 1.5),
            TextField(
              controller: todoController,
              decoration: InputDecoration(
                hintText: 'Enter todo',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            Height(h: 1.5),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  if (todoController.text.isNotEmpty) {
                    addTodo(todoController.text);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  width: 40 * size.width / 100,
                  height: 5 * size.height / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: kText(
                      txt: 'Add',
                      size: 14,
                      txtColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String id;
  String title;
  List<Todo> todos;

  Task({required this.id, required this.title, required this.todos});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'todos': todos.map((todo) => todo.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map, String documentId) {
    return Task(
      id: documentId,
      title: map['title'],
      todos: List<Todo>.from(map['todos']?.map((x) => Todo.fromMap(x))),
    );
  }
}

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    required this.isDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'],
      isDone: map['isDone'],
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function toggleTodoStatus;
  final Function deleteTodo;

  const TodoItem({
    required this.todo,
    required this.toggleTodoStatus,
    required this.deleteTodo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CustomCheckbox(
                value: todo.isDone,
                onChanged: (value) {
                  toggleTodoStatus();
                },
              ),
              SizedBox(width: 10),
              Text(
                todo.title,
                style: TextStyle(
                  decoration: todo.isDone ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              deleteTodo();
            },
            child: SvgPicture.asset('assets/trash.svg'),
          ),
        ],
      ),
    );
  }
}

class AddMainTaskWidget extends StatelessWidget {
  final bool active;
  final VoidCallback onTap;

  const AddMainTaskWidget({
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: active ? onTap : null,
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: active ? AppColors.primaryColor : Colors.grey,
          ),
          Width(w: 3),
          Column(
            children: [
              kText(
                txt: 'Add main task',
                txtColor: active ? AppColors.primaryColor : Colors.grey,
              ),
              Container(
                height: 0.2 * size.height / 100,
                width: 28 * size.width / 100,
                color: active ? AppColors.primaryColor : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        decoration: BoxDecoration(
          color: value ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
            color: value ? AppColors.primaryColor : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        width: 5.5 * size.width / 100,
        height: 2.5 * size.height / 100,
        child: value
            ? Icon(
                Icons.check,
                size: 18.0,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
