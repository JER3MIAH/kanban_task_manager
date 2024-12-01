import 'dart:convert';
import 'package:flutter/foundation.dart';

class Board {
  final String id;
  final String name;
  final List<String> columns;

  Board({
    required this.id,
    required this.name,
    required this.columns,
  });

  Board.initial()
      : id = '',
        name = '',
        columns = ['Todo', 'Doing', 'Done'];

  Board copyWith({
    String? id,
    String? name,
    List<String>? columns,
  }) {
    return Board(
      id: id ?? this.id,
      name: name ?? this.name,
      columns: columns ?? this.columns,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'columns': columns,
    };
  }

  factory Board.fromMap(Map<String, dynamic> map) {
    return Board(
        id: map['id'] as String,
        name: map['name'] as String,
        columns: List<String>.from(
          (map['columns'] as List<dynamic>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory Board.fromJson(String source) =>
      Board.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Board(id: $id, name: $name, columns: $columns)';

  @override
  bool operator ==(covariant Board other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      listEquals(other.columns, columns);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ columns.hashCode;
}
