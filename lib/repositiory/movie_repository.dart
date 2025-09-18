import 'package:moviesapproute/data/api_service/api_service.dart';
import '../data/model/MovieDetailsApi/MovieDetailsResponse.dart';
class MovieRepository {
  final ApiService apiService;
  MovieRepository(this.apiService);
  Future<MovieDetailsResponse> fetchMovieDetails(int movieId) {
    return ApiService.getMovieDetails(movieId);
  }
} /////ديه عشان الشرح ليا مش اكتر

////REPO عباره عن كوبري بين Providers and Api