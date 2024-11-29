import 'dart:convert';

class SubTask {
  final String taskId;
  final String title;
  final bool isDone;

  SubTask({
    required this.taskId,
    required this.title,
    required this.isDone,
  });

  SubTask.initial()
      : taskId = '',
        title = '',
        isDone = false;

  SubTask copyWith({
    String? taskId,
    String? title,
    bool? isDone,
  }) {
    return SubTask(
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }

  factory SubTask.fromMap(Map<String, dynamic> map) {
    return SubTask(
      taskId: map['taskId'] as String,
      title: map['title'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SubTask(taskId: $taskId, title: $title, isDone: $isDone)';

  @override
  bool operator ==(covariant SubTask other) {
    if (identical(this, other)) return true;

    return other.taskId == taskId &&
        other.title == title &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => taskId.hashCode ^ title.hashCode ^ isDone.hashCode;
}
