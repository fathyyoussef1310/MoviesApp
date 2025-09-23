import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesapproute/data/model/history/history_model.dart';

class HistoryService {
  static const String _historyKey = 'user_history';

  static Future<void> addToHistory(HistoryModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();

    // إزالة الفيلم إذا كان موجوداً مسبقاً وإضافته في البداية
    history.removeWhere((item) => item.movieId == movie.movieId);
    history.insert(0, movie);

    // تحديد الحد الأقصى للتاريخ (50 فيلم)
    if (history.length > 50) {
      history.removeRange(50, history.length);
    }

    await _saveHistory(history);
  }

  static Future<void> removeFromHistory(int movieId) async {
    final history = await getHistory();
    history.removeWhere((item) => item.movieId == movieId);
    await _saveHistory(history);
  }

  static Future<List<HistoryModel>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList(_historyKey) ?? [];

    return historyJson.map((json) {
      return HistoryModel.fromJson(jsonDecode(json));
    }).toList();
  }

  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }

  static Future<void> _saveHistory(List<HistoryModel> history) async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = history.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(_historyKey, historyJson);
  }
}