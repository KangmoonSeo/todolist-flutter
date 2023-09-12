import 'package:todolist/models/todo_model.dart';

class TodoService {
  static final List<TodoModel> _todoRepository = [];
  static int sequence = 1000;

  static void addTodo(String text) {
    TodoModel todoModel = TodoModel(
      text: text,
      isFinished: false,
      isImportant: false,
      id: ++sequence,
      order: sequence,
    );
    _todoRepository.add(todoModel);
  }

  static List<TodoModel> getInstance() {
    return _todoRepository;
  }
}
