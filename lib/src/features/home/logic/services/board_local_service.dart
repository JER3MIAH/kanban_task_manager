import 'dart:developer';
import 'package:kanban_task_manager/src/core/core.dart';
import 'package:kanban_task_manager/src/features/home/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardLocalService extends LocalStorageService {
  final SharedPreferences prefs;

  BoardLocalService({required this.prefs});

  Future<List<Board>> getBoards() async {
    try {
      List<String>? jsonList = prefs.getStringList('board_list');
      if (jsonList == null) return [];

      return jsonList.map((json) => Board.fromJson(json)).toList();
    } catch (e, stack) {
      log('error getting boards $e at $stack');
      return [];
    }
  }

  Future<void> createBoard(Board board) async {
    try {
      List<String>? existingJsonList = prefs.getStringList('board_list');

      List<Board> existing = existingJsonList != null
          ? existingJsonList.map((json) => Board.fromJson((json))).toList()
          : [];

      if (!existing.any((b) => b.id == board.id)) {
        existing.add(board);
      }

      List<String> updatedJsonList =
          existing.map((preset) => preset.toJson()).toList();
      await prefs.setStringList('board_list', updatedJsonList);
    } catch (e, stack) {
      log('error creating board $e at $stack');
    }
  }

  Future<void> editBoard(Board updatedBoard) async {
    try {
      List<String>? jsonList = prefs.getStringList('board_list');

      if (jsonList != null) {
        List<Board> existing = jsonList.map((json) {
          return Board.fromJson(json);
        }).toList();

        int index = existing.indexWhere((timer) => timer.id == updatedBoard.id);

        if (index != -1) {
          existing[index] = updatedBoard;
        }

        List<String> updatedJsonList =
            existing.map((timer) => timer.toJson()).toList();
        await prefs.setStringList('board_list', updatedJsonList);
      }
    } catch (e, stack) {
      log('error editing board $e at $stack');
    }
  }

  Future<void> removeBoard(String id) async {
    try {
      List<String>? jsonList = prefs.getStringList('board_list');

      if (jsonList != null) {
        List<Board> existing =
            jsonList.map((json) => Board.fromJson(json)).toList();

        existing.removeWhere((board) => board.id == id);

        List<String> updatedjsonList =
            existing.map((board) => board.toJson()).toList();
        await prefs.setStringList('board_list', updatedjsonList);
      }
    } catch (e, stack) {
      log('error removing board $e at $stack');
    }
  }
}
