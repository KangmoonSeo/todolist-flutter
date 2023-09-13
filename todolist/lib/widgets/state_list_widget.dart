import 'package:flutter/material.dart';

class StateList extends StatelessWidget {
  const StateList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TodoState(
            text: "All",
            highlight: true,
          ),
          TodoState(
            text: "Completed",
            highlight: false,
          ),
          TodoState(
            text: "Incompleted",
            highlight: false,
          ),
          TodoState(
            text: "Important",
            highlight: false,
          ),
        ],
      ),
    );
  }
}

class TodoState extends StatelessWidget {
  final String text;
  final bool highlight;

  const TodoState({
    super.key,
    required this.highlight,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: highlight
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).highlightColor,
                  ),
                )
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: highlight
                ? Theme.of(context).highlightColor
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
