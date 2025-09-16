import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../model/MovieDetailsApi/MovieDetailsResponse.dart';

class ApiServiceMoviesDetails {
  static const String baseUrl = "yts.mx";
  static const String movieDetailsEndPoint = "/api/v2/movie_details.json";
  Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    Uri url = Uri.https(
      baseUrl,
      movieDetailsEndPoint,
      {
        "movie_id": movieId.toString(),
      },
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200)
    {
      final jsonData = jsonDecode(response.body);
      return MovieDetailsResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load movie details, status: ${response.statusCode}");
    }
  }
}
