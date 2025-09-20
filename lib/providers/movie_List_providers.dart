import 'package:flutter/material.dart';
import '../data/api_service/api_service.dart';
import '../data/model/movie_list/Movies.dart';

class MoviesListProvider extends ChangeNotifier {
  List<Movies> movies = [];
  List<Movies> searchResults = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> getMovies() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      movies = await ApiService.getMovies() ?? [];
    } catch (e) {
      errorMessage = "Failed to load movies: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // البحث عن الأفلام
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      searchResults = [];
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      searchResults = await ApiService.searchMovies(query) ?? [];
    } catch (e) {
      errorMessage = "Failed to search movies: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // مسح نتائج البحث
  void clearSearch() {
    searchResults = [];
    notifyListeners();
  }
}
