import 'dart:convert';
import 'package:kanban_task_manager/src/features/home/data/models/sub_task.dart';

class Task {
  final String id;
  final String boardId;
  final String title;
  final String description;
  final List<SubTask> subtasks;
  final String status;

  Task({
    required this.id,
    required this.boardId,
    required this.title,
    required this.description,
    required this.subtasks,
    required this.status,
  });

  Task.initial()
      : id = '',
        boardId = '',
        title = '',
        description = '',
        subtasks = [],
        status = '';

  Task copyWith({
    String? id,
    String? boardId,
    String? title,
    String? description,
    List<SubTask>? subtasks,
    String? status,
  }) {
    return Task(
      id: id ?? this.id,
      boardId: boardId ?? this.boardId,
      title: title ?? this.title,
      description: description ?? this.description,
      subtasks: subtasks ?? this.subtasks,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'boardId': boardId,
      'title': title,
      'description': description,
      'subtasks': subtasks.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      boardId: map['boardId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      subtasks: List<SubTask>.from(
        (map['subtasks'] as List<dynamic>).map<SubTask>(
          (x) => SubTask.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(id: $id, boardId: $boardId, title: $title, description: $description, subtasks: $subtasks, status: $status)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
