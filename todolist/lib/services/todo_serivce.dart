import 'package:todolist/models/todo_model.dart';

class TodoService {
  static final List<TodoModel> _todoRepository = [];
  static final List<int> _todoList = [];

  static int sequence = 1000;

  static void addTodo(String text) {
    TodoModel todoModel = TodoModel(
      text: text,
      isCompleted: false,
      isImportant: false,
      id: ++sequence,
      order: sequence,
    );
    _todoRepository.add(todoModel);
    _todoList.add(todoModel.id);
  }

  static List<TodoModel> getTodoRepository() {
    return _todoRepository;
  }

  static List<int> getTodoList() {
    return _todoList;
  }

  static TodoModel findTodoById(int id) {
    for (var todo in _todoRepository) {
      if (todo.id == id) {
        return todo;
      }
    }
    throw Error;
  }

  static void toggleImportant(TodoModel todo) {
    todo.isImportant = !todo.isImportant;
  }

  static void toggleCompleted(TodoModel todo) {
    todo.isCompleted = !todo.isCompleted;
  }

  static void updateTodo(TodoModel todo, String text) {
    todo.text = text;
  }

  static void deleteTodo(TodoModel todo) {
    _todoList.remove(todo.id);
    _todoRepository.remove(todo);
  }
}
