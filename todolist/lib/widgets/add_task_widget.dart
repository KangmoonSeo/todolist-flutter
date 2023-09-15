import 'package:flutter/material.dart';
import 'package:todolist/services/todo_serivce.dart';

class AddTask extends StatefulWidget {
  final Function buildScreen;
  const AddTask({super.key, required this.buildScreen});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _textController = TextEditingController();

  void onSubmitted(String text) {
    if (text == "") return;
    _textController.clear();
    setState(() {
      TodoService.addTodo(text);
    });
    widget.buildScreen();
  }

  @override
  Widget build(BuildContext context) {
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
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: _textController,
                onSubmitted: onSubmitted,
                decoration: InputDecoration(
                  focusColor: Theme.of(context).highlightColor.withOpacity(0.3),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  hintStyle: TextStyle(
                    color: Theme.of(context).highlightColor,
                  ),
                  hintText: "Add Task...",
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
