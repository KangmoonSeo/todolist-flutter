import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/todo_serivce.dart';

class StorageService {
  static late final SharedPreferences _prefs;
  static late final List<TodoModel> _todoRepository;
  static late final List<int> _todoList;
  static final Logger _log = Logger();

  static Future initApp() async {
    _prefs = await SharedPreferences.getInstance();
    _todoRepository = TodoService.getTodoRepository();
    _todoList = TodoService.getTodoList();

    // get data from localStorage
    List<String>? list = _prefs.getStringList('todoList');
    list ??= [];
    List<String>? repo = _prefs.getStringList('todoRepository');
    var sequence = _prefs.getInt('sequence');
    if (list.isEmpty) {
      repo = [];
      sequence = 1000;
    }
    _log.i("[storage load] list:${list.length}, repo:${repo?.length}");

    // sync data at memory
    TodoService.loadSequence(sequence!);
    for (var intString in list) {
      _todoList.add(int.parse(intString));
    }
    for (var jsonString in repo!) {
      Map<String, dynamic> m = jsonDecode(jsonString);
      _todoRepository.add(TodoModel.fromJson(m));
    }
    _log.i("[memory sync] list:$_todoList, repo:${_todoRepository.length}");
  }

  // store memory data in localStorage
  static void store() {
    _prefs.setStringList("todoList", TodoService.toStringList(_todoList));
    _prefs.setStringList(
        'todoRepository', TodoService.toStringList(_todoRepository));

    if (_todoList.isNotEmpty) {
      int seq = TodoService.getTodoRepository().last.id;
      _prefs.setInt('sequence', seq);
    }
  }
}