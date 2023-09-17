import 'package:flutter/material.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/todo_serivce.dart';

class TodoWidget extends StatelessWidget {
  final Function buildScreen;
  final int id;
  TodoWidget({super.key, required this.id, required this.buildScreen});

  final TextEditingController _textController = TextEditingController();
  late final TodoModel todo = TodoService.findTodoById(id);

  void tapCheckbox() {
    TodoService.toggleCompleted(todo);
    buildScreen();
  }

  void tapStar() {
    TodoService.toggleImportant(todo);
    buildScreen();
  }

  void updateText(BuildContext context) {
    final String text = _textController.text;
    TodoService.updateTodo(todo, text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Todo edited."),
        duration: Duration(seconds: 3),
      ),
    );
    buildScreen();
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
                _textController.text = todo.text;
                showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        title: const Text("Edit To-Do"),
                        content: TextField(controller: _textController),
                        actions: [
                          IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.edit),
                            onPressed: () => {
                              updateText(context),
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
                  decorationColor: Theme.of(context).highlightColor,
                  decorationThickness: 1.8,
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
