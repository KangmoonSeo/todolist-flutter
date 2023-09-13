class TodoModel {
  String text;
  bool isCompleted;
  bool isImportant;
  int id;
  int order;

  TodoModel({
    required this.text,
    required this.isCompleted,
    required this.isImportant,
    required this.id,
    required this.order,
  });
}
