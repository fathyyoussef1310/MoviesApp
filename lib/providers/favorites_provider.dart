import 'package:flutter/foundation.dart';
import '../data/model/HomepageApi/Movies.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Movies> _favorites = [];
  final List<Movies> _history = [];

  List<Movies> get favorites => _favorites;
  List<Movies> get history => _history;

  void toggleFavorite(Movies movie) {
    final index = _favorites.indexWhere((m) => m.id == movie.id);
    if (index >= 0) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  void addToHistory(Movies movie) {
    if (movie.id == null) return;

    final index = _history.indexWhere((m) => m.id == movie.id);
    if (index >= 0) {
      final existing = _history.removeAt(index);
      _history.add(existing);
    } else {
      _history.add(Movies(
        id: movie.id,
        title: movie.title ?? "No Title",
        mediumCoverImage: movie.mediumCoverImage ?? "",
        rating: movie.rating ?? 0.0, likeCount: null,
      ));
    }
    notifyListeners();
  }
}
