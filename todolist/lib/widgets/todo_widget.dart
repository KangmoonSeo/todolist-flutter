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
    return SizedBox(
      width: 80,
      height: 40,
      child: Row(
        children: [
          const Icon(Icons.check_box_outline_blank),
          Text(
            widget.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const Icon(Icons.star_border_outlined),
        ],
      ),
    );
  }
}
