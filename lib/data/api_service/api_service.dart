import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:moviesapproute/data/model/movie_list/Movies.dart';
import '../model/movie_details/MovieDetailsResponce.dart';
import '../model/movie_list/MovieResponce.dart';
import '../model/movie_suggestins/MovieSuggestionResponce.dart';
import '../model/movie_suggestins/Movie.dart';

class ApiService {
  static const String baseUrl = "yts.mx";
  static const String movieDetailsEndPoint = "/api/v2/movie_details.json";
  static const String moviesEndPoint = "/api/v2/list_movies.json";

  // Get all movies
  static Future<List<Movies>?> getMovies() async {
    Uri uri = Uri.https(baseUrl, moviesEndPoint);
    http.Response moviesResponse = await http.get(uri);

    var json = jsonDecode(moviesResponse.body);
    MoviesResponce response = MoviesResponce.fromJson(json);
    return response.data?.movies;
  }

  // Get movie details
  Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    Uri uri = Uri.https(baseUrl, movieDetailsEndPoint, {
      "movie_id": movieId.toString(),
    });

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return MovieDetailsResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to fetch movie details");
    }
  }

  Future<List<Movie>?> getMovieSuggestions(int movieId) async {
    Uri uri = Uri.https(baseUrl, "/api/v2/movie_suggestions.json", {
      "movie_id": movieId.toString(),
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final data = jsonData['data'];
      if (data == null) return [];

      List<Movie> moviesList = [];
      if (data['movies'] != null) {
        moviesList = (data['movies'] as List)
            .map((e) => Movie.fromJson(e))
            .toList();
      } else if (data['movie'] != null) {
        moviesList = [Movie.fromJson(data['movie'])];
      }

      return moviesList;
    } else {
      throw Exception("Failed to fetch movie suggestions");
    }
  }

  // Search movies
  static Future<List<Movies>?> searchMovies(String query) async {
    Uri uri = Uri.https(baseUrl, moviesEndPoint, {
      "query_term": query,
    });

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      MoviesResponce moviesResponse = MoviesResponce.fromJson(json);
      return moviesResponse.data?.movies ?? [];
    } else {
      throw Exception("Failed to search movies");
    }
  }


}
