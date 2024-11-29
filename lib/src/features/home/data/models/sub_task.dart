import 'dart:convert';

class SubTask {
  final String id;
  final String taskId;
  final String title;
  final bool isDone;

  SubTask({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isDone,
  });

  SubTask.initial()
      : id = '',
        taskId = '',
        title = '',
        isDone = false;

  SubTask copyWith({
    String? id,
    String? taskId,
    String? title,
    bool? isDone,
  }) {
    return SubTask(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      id: map['id'] as String,
      taskId: map['taskId'] as String,
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubTask(id: $id, taskId: $taskId, title: $title, isDone: $isDone)';
  }

  @override
  bool operator ==(covariant SubTask other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
