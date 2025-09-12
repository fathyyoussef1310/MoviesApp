import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:moviesapproute/data/model/Movies.dart';

import '../model/MovieResponce.dart';

///https://yts.mx/api/v2/list_movies.json
class apiService {
  static const String baseUrl = "yts.mx";
  static const String moviesEndPoint = "/api/v2/list_movies.json";

  static Future<List<Movies>?> getMovies() async{
    Uri uri = Uri.https(
      baseUrl,
      moviesEndPoint,
    );
    http.Response moviesResponce = await http.get(uri);

    var json = jsonDecode(moviesResponce.body);

    MoviesResponce responce = MoviesResponce.fromJson(json);
    return responce.data?.movies;
  }

}