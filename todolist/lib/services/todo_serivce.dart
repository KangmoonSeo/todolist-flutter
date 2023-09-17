import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:todolist/models/todo_model.dart';
import 'package:todolist/services/storage_service.dart';
import 'package:todolist/services/storage_service_impl.dart';

class TodoService {
  static final List<TodoModel> _todoRepository = [];
  static final List<int> _todoList = [];
  static final StorageService _storageService =
      StorageServiceImpl.getInstance();
  static int _sequence = 1000;
  static Logger log = Logger();

  static void setSequence(int s) {
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

  /* data */
  static String getBackupData() {
    final Map<String, String> m = {
      "todoList": json.encode(_todoList).toString(),
      "todoRepository": json.encode(_todoRepository).toString(),
      "sequence": _sequence.toString(),
    };

    log.i("[Backup] Code is Delivered to User. ");
    return json.encode(m).toString();
  }

  static bool setDataByBackupCode(String code) {
    late final Map<String, dynamic> m;
    String? listString;
    String? repoString;
    String? sequenceString;
    try {
      m = json.decode(code);
      listString ??= m['todoList'];
      repoString ??= m['todoRepository'];
      sequenceString ??= m['sequence'];

      if (listString == null || repoString == null || sequenceString == null) {
        throw FormatException;
      }
    } on FormatException {
      if (code.length > 20) code = code.substring(0, 20);
      log.w("[Restore] Invalid Code Format Detected : $code ... ");
      return false;
    } on Exception {
      if (code.length > 20) code = code.substring(0, 20);
      log.w("[Restore] Unexpected Exception Detected : $code ... ");
      return false;
    }

    listString = listString.substring(1, listString.length - 1);
    repoString = repoString.substring(1, repoString.length - 1);

    List<String> listParse = listString.split(',');
    List<String> repoParse =
        repoString.split(RegExp(r',(?![","])')); // , AND NOT ","

    _todoList.clear();
    if (listParse[0] != "") {
      for (var idString in listParse) {
        _todoList.add(int.parse(idString));
      }
    }
    _todoRepository.clear();
    if (repoParse[0] != "") {
      for (var todoString in repoParse) {
        TodoModel todo = TodoModel.fromJson(json.decode(todoString));
        _todoRepository.add(todo);
      }
    }
    setSequence(1000);
    if (sequenceString != "") setSequence(int.parse(sequenceString));

    log.i("[Restore] Restore Completed : $code ... ");
    _storageService.store(); // Transactional
    return true;
  }

  static void clearData() {
    _todoRepository.clear();
    _todoList.clear();
    _sequence = 1000;

    _storageService.store(); // Transactional
  }

  /* todo */
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

  static void undoTodo(TodoModel todoModel) {
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

  /* important */
  static void toggleImportant(TodoModel todo) {
    todo.isImportant = !todo.isImportant;

    _storageService.store(); // Transactional
  }

  /* completed */
  static void toggleCompleted(TodoModel todo) {
    todo.isCompleted = !todo.isCompleted;

    _storageService.store(); // Transactional
  }
}
