import 'package:flutter/material.dart';
import '../data/model/movie_list/Movies.dart';
import '../repository/movie_repository.dart';
import '../data/model/movie_suggestins/Movie.dart';

class MovieSuggestionsProvider with ChangeNotifier {
  final MovieSuggestionsRepository repository;
  MovieSuggestionsProvider(this.repository);

  bool isLoading = false;
  List<Movies>? suggestions;
  String? errorMessage;

  Future<void> loadSuggestions(int movieId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final movieSuggestions = await repository.fetchSuggestions(movieId);

      if (movieSuggestions != null) {
        suggestions = movieSuggestions
            .map((m) => Movies(
          id: m.id,
          title: m.title,
          mediumCoverImage: m.mediumCoverImage,
          rating: m.rating,
        ))
            .toList();
      } else {
        suggestions = [];
      }
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
