import 'package:flutter/material.dart';
import '../data/api_service/api_service.dart';
import '../data/model/Movies.dart';

class MoviesProvider extends ChangeNotifier {
  List<Movies> movies = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> getMovies() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      movies = await apiService.getMovies() ?? [];
    } catch (e) {
      errorMessage = "Failed to load movies: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
