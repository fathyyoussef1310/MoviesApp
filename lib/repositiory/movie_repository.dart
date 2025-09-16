import 'package:moviesapproute/data/api_service/api_service_moive_details/ap_services.dart';
import '../data/model/MovieDetailsApi/MovieDetailsResponse.dart';
class MovieRepository {
  final ApiServiceMoviesDetails apiService;
  MovieRepository(this.apiService);
  Future<MovieDetailsResponse> fetchMovieDetails(int movieId) {
    return apiService.getMovieDetails(movieId);
  }
} /////ديه عشان الشرح ليا مش اكتر

////REPO عباره عن كوبري بين Providers and Api