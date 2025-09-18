import 'package:flutter/foundation.dart';
import '../data/api_service/api_service.dart';
import '../data/model/MovieDetailsApi/Movie.dart';

class MoviesSuggestionsProvider extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  List<Movie> suggestions = [];

  Future<void> loadSuggestions(int movieId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final movies = await ApiService.getMoviesSuggetions(movieId);
      suggestions = movies as List<Movie>;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
