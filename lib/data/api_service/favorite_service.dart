import 'dart:convert';
import 'package:moviesapproute/data/model/favorite/favorite_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _favoritesKey = 'user_favorites';

  static Future<void> addToFavorites(FavoriteModel movie) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    if (!favorites.any((fav) => fav.movieId == movie.movieId)) {
      favorites.add(movie);
      await _saveFavorites(favorites);
    }
  }

  static Future<void> removeFromFavorites(int movieId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((fav) => fav.movieId == movieId);
    await _saveFavorites(favorites);
  }

  static Future<List<FavoriteModel>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

    return favoritesJson.map((json) {
      return FavoriteModel.fromJson(jsonDecode(json));
    }).toList();
  }

  static Future<bool> isFavorite(int movieId) async {
    final favorites = await getFavorites();
    return favorites.any((fav) => fav.movieId == movieId);
  }

  static Future<void> _saveFavorites(List<FavoriteModel> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = favorites.map((fav) => jsonEncode(fav.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }
}