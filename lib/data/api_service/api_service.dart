import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:moviesapproute/data/model/HomepageApi/Movies.dart';
import 'package:moviesapproute/data/model/HomepageApi/MovieResponce.dart';
import 'package:moviesapproute/data/model/MovieDetailsApi/MovieDetailsResponse.dart';
import 'package:moviesapproute/data/model/MoviesSuggestions/MoviesSuggestionsResponse.dart';

class ApiService {
  static const String baseUrl = "yts.mx";
  static const String moviesEndPoint = "/api/v2/list_movies.json";
  static const String movieDetailsEndPoint = "/api/v2/movie_details.json";
  static const String movieSuggestionsEndPoint = "/api/v2/movie_suggestions.json";
  static Future<List<Movies>?> getMovies() async {
    Uri uri = Uri.https(baseUrl, moviesEndPoint);
    http.Response moviesResponse = await http.get(uri);

    if (moviesResponse.statusCode == 200) {
      var json = jsonDecode(moviesResponse.body);
      MoviesResponce response = MoviesResponce.fromJson(json);
      return response.data?.movies;
    } else {
      throw Exception(
          "Failed to load movies, status: ${moviesResponse.statusCode}");
    }
  }

  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    Uri url = Uri.https(baseUrl, movieDetailsEndPoint, {
      "movie_id": movieId.toString(),
    });

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MovieDetailsResponse.fromJson(jsonData);
    } else {
      throw Exception(
          "Failed to load movie details, status: ${response.statusCode}");
    }
  }
  static Future<MoviesSuggestionsResponse> getMoviesSuggetions(int movieId) async {
    Uri url = Uri.https(baseUrl, movieSuggestionsEndPoint, {
      "movie_id": movieId.toString(),
    });

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return MoviesSuggestionsResponse.fromJson(jsonData);
    } else {
      throw Exception(
          "Failed to load movie suggestions, status: ${response.statusCode}");
    }
  }

}
