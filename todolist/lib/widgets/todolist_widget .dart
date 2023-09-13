// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todolist/services/todo_serivce.dart';
import 'package:todolist/widgets/todo_widget.dart';

Logger log = Logger();

class TodoList extends StatelessWidget {
  TodoList({super.key});
  List<int> todoList = TodoService.getTodoList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.vertical,
      itemCount: todoList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(todoList[index]),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            var todo = TodoService.findTodoById(todoList[index]);
            TodoService.deleteTodo(todo);
            log.i(todoList.length);
          },
          child: TodoWidget(id: todoList[index]),
        );
      },
    );
  }
}
