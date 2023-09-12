class TodoModel {
  String text;
  bool isFinished;
  bool isImportant;
  int id;
  int order;

  TodoModel({
    required this.text,
    required this.isFinished,
    required this.isImportant,
    required this.id,
    required this.order,
  });
}
