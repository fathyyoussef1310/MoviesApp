import 'package:flutter/material.dart';
import '../data/model/MovieDetailsApi/MovieDetailsResponse.dart';
import '../repositiory/movie_repository.dart';

class MovieDetailsProvider with ChangeNotifier {
  final MovieRepository repository;
  MovieDetailsProvider(this.repository);
  bool isLoading = false;
  MovieDetailsResponse? movieDetails;
  String? errorMessage;
  Future<void> loadMovieDetails(int movieId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      movieDetails = await repository.fetchMovieDetails(movieId);
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
