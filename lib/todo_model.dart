class TodoModel {
  int? id;
  String? title;
  String? description;

  TodoModel({
    this.id,
    this.title,
    this.description,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
