import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/storage_service.dart';
import 'package:todolist/services/todo_serivce.dart';
import 'package:todolist/widgets/todo_widget.dart';

enum SelectType { all, completed, incompleted, important }

// addTodoWidget에서 todoList
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final Logger log = Logger();

  // sends function for children
  void change() {
    setState(() {});
  }

  void onSubmitted(String text) {
    if (text == "") return;
    _textController.clear();
    setState(() {
      TodoService.addTodo(text);
    });
  }

  @override
  void initState() {
    setState(() {
      StorageService.initApp();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title: const Text(
            "To-Do List",
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).highlightColor,
            unselectedLabelColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).highlightColor,
            labelPadding: const EdgeInsets.all(2),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Completed'),
              Tab(text: 'Incompleted'),
              Tab(text: 'Important'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            todoListBuilder(SelectType.all),
            todoListBuilder(SelectType.completed),
            todoListBuilder(SelectType.incompleted),
            todoListBuilder(SelectType.important),
          ],
        ),
        bottomNavigationBar: addTaskWidget(context),
      ),
    );
  }

  Widget todoListBuilder(type) {
    var list = [];

    for (var todoId in TodoService.getTodoList()) {
      TodoModel todo = TodoService.findTodoById(todoId);
      switch (type) {
        case SelectType.all:
          list.add(todoId);
          break;
        case SelectType.completed:
          if (todo.isCompleted) list.add(todoId);
          break;
        case SelectType.incompleted:
          if (!todo.isCompleted) list.add(todoId);
          break;
        case SelectType.important:
          if (todo.isImportant) list.add(todoId);
          break;
      }
    }

    return Column(
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            scrollDirection: Axis.vertical,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(list[index]),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  TodoService.deleteTodo(TodoService.findTodoById(list[index]));
                  change();
                },
                child: TodoWidget(
                  id: list[index],
                  changeParent: change,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Padding addTaskWidget(BuildContext context) {
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
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
                controller: _textController,
                onSubmitted: onSubmitted,
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
                onPressed: () => onSubmitted(_textController.text),
              ),
            )
          ],
        ),
      ),
    );
  }
}
