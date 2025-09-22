import 'package:moviesapproute/data/model/movie_list/Movies.dart';
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
  Future<List<Movie>?> fetchSuggestions(int movieId) {
    return apiService.getMovieSuggestions(movieId);
  }
}
class BrowseRepository {
  final ApiService apiService;
  BrowseRepository(this.apiService);
  Future<List<Movies>?> fetchMovies({int page = 1, int limit = 20}) async
  {
  return apiService.getMoviesByPage(page: page, limit: limit);
  }
  }


/////ديه عشان الشرح ليا مش اكتر

////REPO عباره عن كوبري بين Providers and Api