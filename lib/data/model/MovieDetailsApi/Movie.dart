class Movie {
  String? title;
  int? year;
  String? largeCoverImage;
  double? rating;
  String? descriptionFull;
  List<String>? genres;

  Movie({
    this.title,
    this.year,
    this.largeCoverImage,
    this.rating,
    this.descriptionFull,
    this.genres,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    year = json['year'];
    largeCoverImage = json['large_cover_image'];
    rating = (json['rating'] as num?)?.toDouble();
    descriptionFull = json['description_full'];
    genres = (json['genres'] != null) ? List<String>.from(json['genres']) : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['year'] = year;
    map['large_cover_image'] = largeCoverImage;
    map['rating'] = rating;
    map['description_full'] = descriptionFull;
    map['genres'] = genres;
    return map;
  }
}
