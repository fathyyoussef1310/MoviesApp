import 'package:flutter/material.dart';
import '../data/api_service/api_service.dart';
import '../data/model/movie_list/Movies.dart';

class MoviesListProvider extends ChangeNotifier {
  List<Movies> movies = [];

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


}
