import '../data/api_service/api_service.dart';
import '../data/model/movie_details/MovieDetailsResponce.dart';
import '../data/model/movie_suggestins/Movie.dart';

class MovieRepository {
  final ApiService apiService;
  MovieRepository(this.apiService);

  // Fetch movie details
  Future<MovieDetailsResponse> fetchMovieDetails(int movieId) {
    return apiService.getMovieDetails(movieId);
  }
}

class MovieSuggestionsRepository {
  final ApiService apiService;
  MovieSuggestionsRepository(this.apiService);

  // Fetch movie suggestions
  Future<List<Movie>?> fetchSuggestions(int movieId) {
    return apiService.getMovieSuggestions(movieId);
  }
}/////ديه عشان الشرح ليا مش اكتر

////REPO عباره عن كوبري بين Providers and Api