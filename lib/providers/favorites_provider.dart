// favorites_provider.dart
import 'package:flutter/foundation.dart';
import 'package:moviesapproute/data/api_service/favorite_service.dart';
import 'package:moviesapproute/data/model/favorite/favorite_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<FavoriteModel> _favorites = [];
  bool _isLoading = false;

  List<FavoriteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();

    try {
      _favorites = await FavoriteService.getFavorites();
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(FavoriteModel movie) async {
    final isCurrentlyFavorite = _favorites.any((fav) => fav.movieId == movie.movieId);

    if (isCurrentlyFavorite) {
      await removeFromFavorites(movie.movieId);
    } else {
      await addToFavorites(movie);
    }
  }

  Future<void> addToFavorites(FavoriteModel movie) async {
    try {
      await FavoriteService.addToFavorites(movie);
      _favorites.add(movie);
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  Future<void> removeFromFavorites(int movieId) async {
    try {
      await FavoriteService.removeFromFavorites(movieId);
      _favorites.removeWhere((fav) => fav.movieId == movieId);
      notifyListeners();
    } catch (error) {
      // Handle error
    }
  }

  bool isFavorite(int movieId) {
    return _favorites.any((fav) => fav.movieId == movieId);
  }
}