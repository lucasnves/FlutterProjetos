class Todo {
  Todo({required this.title, required this.ok});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        ok = json['ok'];

  String title;
  bool ok;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ok': ok,
    };
  }
}
