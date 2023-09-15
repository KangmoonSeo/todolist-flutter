import 'package:flutter/material.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/storage_service.dart';
import 'package:todolist/services/todo_serivce.dart';
import 'package:todolist/widgets/add_task_widget.dart';
import 'package:todolist/widgets/todo_widget.dart';

enum SelectType { all, completed, incompleted, important }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // send props to children
  void props() {
    setState(() {});
  }

  @override
  void initState() {
    StorageService.initApp().then((value) => {setState(() {})});
    super.initState();
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
            style: TextStyle(fontSize: 24),
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
        bottomNavigationBar: AddTaskWidget(buildScreen: props),
      ),
    );
  }

  Widget todoListBuilder(type) {
    List<int> list = [];

    for (var todoId in TodoService.getTodoList()) {
      TodoModel todo = TodoService.findTodoById(todoId);
      if (type == SelectType.all && true) list.add(todoId);
      if (type == SelectType.completed && todo.isCompleted) list.add(todoId);
      if (type == SelectType.incompleted && !todo.isCompleted) list.add(todoId);
      if (type == SelectType.important && todo.isImportant) list.add(todoId);
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
                  setState(() {});
                },
                child: TodoWidget(
                  id: list[index],
                  buildScreen: props,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
