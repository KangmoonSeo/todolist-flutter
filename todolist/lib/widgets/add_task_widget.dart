import 'package:flutter/material.dart';
import 'package:todolist/services/todo_serivce.dart';

class AddTaskWidget extends StatelessWidget {
  final Function buildScreen;
  AddTaskWidget({super.key, required this.buildScreen});

  final TextEditingController _textController = TextEditingController();

  void onSubmitted(BuildContext context) {
    var text = _textController.text;
    if (text == "") return;
    _textController.clear();
    TodoService.addTodo(text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Todo Added."),
        duration: Duration(seconds: 5),
      ),
    );
    buildScreen();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: _textController,
                onSubmitted: (text) {
                  onSubmitted(context);
                },
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
                onPressed: () {
                  onSubmitted(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
