import 'package:flutter/material.dart';
import 'package:todolist/services/todo_serivce.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key, this.updateParent});

  final updateParent;
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _textController = TextEditingController();

  void onSubmitted(String text) {
    _textController.clear();

    setState(() {
      TodoService.addTodo(text);
    });

    print("${TodoService.getInstance().length} : $text");
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(),
                ),
                child: TextField(
                  controller: _textController,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintStyle: TextStyle(
                      color: Theme.of(context).highlightColor,
                    ),
                    hintText: "Add Todo...",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => onSubmitted(_textController.text),
            )
          ],
        ),
      ),
    );
  }
}
