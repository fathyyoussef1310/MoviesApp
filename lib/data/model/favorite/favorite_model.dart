class FavoriteModel {
  final int movieId;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;

  FavoriteModel({
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate,
    };
  }

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      movieId: json['movieId'],
      title: json['title'],
      posterPath: json['posterPath'],
      voteAverage: (json['voteAverage'] as num).toDouble(),
      releaseDate: json['releaseDate'],
    );
  }
}