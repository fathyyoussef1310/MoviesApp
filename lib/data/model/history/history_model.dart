class HistoryModel {
  final int movieId;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final DateTime watchedAt;

  HistoryModel({
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.watchedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'title': title,
      'posterPath': posterPath,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate,
      'watchedAt': watchedAt.toIso8601String(),
    };
  }

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      movieId: json['movieId'],
      title: json['title'],
      posterPath: json['posterPath'],
      voteAverage: (json['voteAverage'] as num).toDouble(),
      releaseDate: json['releaseDate'],
      watchedAt: DateTime.parse(json['watchedAt']),
    );
  }
}