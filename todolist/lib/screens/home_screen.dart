import 'package:flutter/material.dart';
import 'package:todolist/services/todo_serivce.dart';
import 'package:todolist/widgets/state_list_widget.dart';
import 'package:todolist/widgets/todolist_widget%20.dart';

// addTodoWidget에서 todoList
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  void onSubmitted(String text) {
    _textController.clear();
    setState(() {
      TodoService.addTodo(text);
    });
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
          const StateList(),
          const SizedBox(
            height: 40,
          ),
          Flexible(
            child: TodoList(),
          ),
          addTodo(context),
        ],
      ),
    );
  }

  Padding addTodo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 100,
        vertical: 20,
      ),
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Flexible(
              child: Container(
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  controller: _textController,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).highlightColor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: TextStyle(
                      color: Theme.of(context).highlightColor,
                    ),
                    hintText: "Add Task...",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).highlightColor,
              ),
              child: IconButton(
                color: Theme.of(context).primaryColor,
                iconSize: 30,
                icon: const Icon(Icons.add),
                onPressed: () => onSubmitted(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
}
