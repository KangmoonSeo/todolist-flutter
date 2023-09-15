import 'dart:convert';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/storage_service.dart';
import 'package:todolist/services/storage_service_impl.dart';

class TodoService {
  static final List<TodoModel> _todoRepository = [];
  static final List<int> _todoList = [];
  static final StorageService _storageService =
      StorageServiceImpl.getInstance();
  static int _sequence = 1000;

  static void loadSequence(int s) {
    _sequence = s;
  }

  static List<TodoModel> getTodoRepository() {
    return _todoRepository;
  }

  static List<int> getTodoList() {
    return _todoList;
  }

  static List<String> toStringList(List<dynamic> list) {
    List<String> ret = [];
    for (var todo in list) {
      if (todo is int) {
        ret.add(json.encode(todo));
      } else if (todo is TodoModel) {
        ret.add(json.encode(todo.toJson()));
      }
    }
    return ret;
  }

  // todo
  static void addTodo(String text) {
    TodoModel todoModel = TodoModel(
      text: text,
      isCompleted: false,
      isImportant: false,
      id: ++_sequence,
      order: _sequence,
    );
    _todoRepository.add(todoModel);
    _todoList.add(todoModel.id);

    _storageService.store(); // Transactional
  }

  static TodoModel findTodoById(int id) {
    for (var todo in _todoRepository) {
      if (todo.id == id) return todo;
    }
    throw ArgumentError;
  }

  static void updateTodo(TodoModel todo, String text) {
    todo.text = text;

    _storageService.store(); // Transactional
  }

  static void deleteTodo(TodoModel todo) {
    _todoList.remove(todo.id);
    _todoRepository.remove(todo);

    _storageService.store(); // Transactional
  }

  // important
  static void toggleImportant(TodoModel todo) {
    todo.isImportant = !todo.isImportant;

    _storageService.store(); // Transactional
  }

  // completed
  static void toggleCompleted(TodoModel todo) {
    todo.isCompleted = !todo.isCompleted;

    _storageService.store(); // Transactional
  }
}
