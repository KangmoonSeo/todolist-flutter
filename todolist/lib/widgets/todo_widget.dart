import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  final String text;
  final int id;
  const TodoWidget({super.key, required this.text, required this.id});

  @override
  State<TodoWidget> createState() => _TodoState();
}

class _TodoState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.red,
      ),
      child: Row(
        children: [
          const Icon(Icons.check_box_outline_blank),
          Text(widget.text),
          const Icon(Icons.star_border_outlined),
        ],
      ),
    );
  }
}
