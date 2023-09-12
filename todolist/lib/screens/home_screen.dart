import 'package:flutter/material.dart';
import 'package:todolist/widgets/add_todo_widget.dart';
import 'package:todolist/widgets/state_selector_widget.dart';
import 'package:todolist/widgets/todolist_widget%20.dart';

// addTodoWidget에서 todoList
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text(
          "To-Do List",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const StateSelector(),
          const SizedBox(
            height: 40,
          ),
          Flexible(
            child: TodoList(),
          ),
          AddTodo(updateParent: updateScreen),
        ],
      ),
    );
  }
}
