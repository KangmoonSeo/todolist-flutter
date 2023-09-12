// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/todo_serivce.dart';
import 'package:todolist/widgets/todo_widget.dart';

class TodoList extends StatelessWidget {
  TodoList({super.key});
  late List<TodoModel> todoRepository = TodoService.getInstance();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      scrollDirection: Axis.vertical,
      itemCount: todoRepository.length,
      itemBuilder: (context, index) {
        TodoModel todo = todoRepository[index];
        return TodoWidget(
          text: todo.text,
          id: todo.id,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 40,
        );
      },
    );
  }
}
