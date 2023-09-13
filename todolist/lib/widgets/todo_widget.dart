import 'package:flutter/material.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/todo_serivce.dart';

class TodoWidget extends StatefulWidget {
  final int id;
  const TodoWidget({super.key, required this.id});

  @override
  State<TodoWidget> createState() => _TodoState();
}

class _TodoState extends State<TodoWidget> {
  late TodoModel todo;

  late TextEditingController _textController;

  tapCheckbox() {
    setState(() {
      TodoService.toggleCompleted(todo);
    });
  }

  tapStar() {
    setState(() {
      TodoService.toggleImportant(todo);
    });
  }

  void updateText(text) {
    setState(() {
      TodoService.updateTodo(todo, text);
    });
  }

  @override
  void initState() {
    super.initState();
    todo = TodoService.findTodoById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 60,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: tapCheckbox,
            child: SizedBox(
              width: 60,
              child: Icon(
                  color: Theme.of(context).highlightColor,
                  todo.isCompleted
                      ? Icons.check_box_rounded
                      : Icons.check_box_outline_blank),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: tapCheckbox,
              onLongPress: () {
                _textController = TextEditingController(text: todo.text);
                showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        title: const Text("Edit To-Do"),
                        content: TextField(
                          controller: _textController,
                        ),
                        actions: [
                          IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.add),
                            onPressed: () => {
                              updateText(_textController.text),
                              Navigator.pop(context),
                            },
                          )
                        ],
                      )),
                );
              },
              child: Text(
                todo.text,
                style: TextStyle(
                  decoration: todo.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: tapStar,
            child: SizedBox(
              width: 60,
              child: Icon(
                color: Theme.of(context).highlightColor,
                todo.isImportant
                    ? Icons.star_rounded
                    : Icons.star_border_rounded,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
