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

  TodoModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        isCompleted = json['isCompleted'],
        isImportant = json['isImportant'],
        id = json['id'],
        order = json['order'];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCompleted': isCompleted,
      'isImportant': isImportant,
      'id': id,
      'order': order,
    };
  }
}
