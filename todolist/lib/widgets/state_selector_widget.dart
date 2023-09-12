import 'package:flutter/material.dart';

class StateSelector extends StatelessWidget {
  const StateSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "All",
            style: TextStyle(
              color: Theme.of(context).highlightColor,
            ),
          ),
          Text(
            "Completed",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            "Imcompleted",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Text(
            "Important",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
