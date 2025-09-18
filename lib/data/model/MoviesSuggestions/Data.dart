import '../HomepageApi/Movies.dart';

class Data {
  int? movieCount;
  List<Movies>? movies;

  Data({this.movieCount, this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    if (json['movies'] != null) {
      movies = (json['movies'] as List)
          .map((m) => Movies.fromJson(m))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    if (movies != null) {
      map['movies'] = movies?.map((m) => m.toJson()).toList();
    }
    return map;
  }
}
