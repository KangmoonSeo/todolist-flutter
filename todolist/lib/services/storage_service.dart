import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/todo_serivce.dart';

class StorageService {
  static late final SharedPreferences _prefs;
  static late final List<TodoModel> _todoRepository;
  static late final List<int> _todoList;

  static Future initApp() async {
    _prefs = await SharedPreferences.getInstance();
    _todoRepository = TodoService.getTodoRepository();
    _todoList = TodoService.getTodoList();

    List<String>? list = _prefs.getStringList('todoList');
    list ??= [];
    List<String>? repo = _prefs.getStringList('todoRepository'); // List<String>
    var sequence = _prefs.getInt('sequence');
    if (list.isEmpty) {
      repo = [];
      sequence = 1000;
    }
    TodoService.loadSequence(sequence!);
    for (var intString in list) {
      _todoList.add(int.parse(intString));
    }
    for (var jsonString in repo!) {
      Map<String, dynamic> m = jsonDecode(jsonString);
      _todoRepository.add(TodoModel.fromJson(m));
    }
  }

  static store() {
    _prefs.setStringList("todoList", TodoService.toStringList(_todoList));
    _prefs.setStringList(
        'todoRepository', TodoService.toStringList(_todoRepository));

    if (_todoList.isNotEmpty) {
      int seq = TodoService.getTodoRepository().last.id;
      _prefs.setInt('sequence', seq);
    }
  }
}
