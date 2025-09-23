import 'Torrents.dart';
import 'Cast.dart';

class Movie {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final String backdropPath;

  final String? url;
  final String? imdbCode;
  final String? titleEnglish;
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final int? likeCount;
  final String? descriptionIntro;
  final String? descriptionFull;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? smallCoverImage;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final List<Torrents>? torrents;
  final String? dateUploaded;
  final int? dateUploadedUnix;
  final List<Cast>? cast;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.backdropPath,
    this.url,
    this.imdbCode,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
    this.cast,
  });

  // Constructor من JSON مع دعم لكلا النموذجين
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] ?? json['small_cover_image'] ?? '',
      voteAverage: (json['vote_average'] ?? json['rating'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? json['description_full'] ?? json['description_intro'] ?? '',
      backdropPath: json['backdrop_path'] ?? json['background_image'] ?? json['background_image_original'] ?? '',

      // الخصائص الإضافية من النموذج الأول
      url: json['url'],
      imdbCode: json['imdb_code'],
      titleEnglish: json['title_english'],
      titleLong: json['title_long'],
      slug: json['slug'],
      year: json['year'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      runtime: json['runtime'],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : null,
      likeCount: json['like_count'],
      descriptionIntro: json['description_intro'],
      descriptionFull: json['description_full'],
      ytTrailerCode: json['yt_trailer_code'],
      language: json['language'],
      mpaRating: json['mpa_rating'],
      backgroundImage: json['background_image'],
      backgroundImageOriginal: json['background_image_original'],
      smallCoverImage: json['small_cover_image'],
      mediumCoverImage: json['medium_cover_image'],
      largeCoverImage: json['large_cover_image'],
      dateUploaded: json['date_uploaded'],
      dateUploadedUnix: json['date_uploaded_unix'],

      // قوائم الكاست والتورنتس
      torrents: json['torrents'] != null
          ? (json['torrents'] as List).map((v) => Torrents.fromJson(v)).toList()
          : null,
      cast: json['cast'] != null
          ? (json['cast'] as List).map((v) => Cast.fromJson(v)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    // الخصائص الأساسية المطلوبة
    map['id'] = id;
    map['title'] = title;
    map['poster_path'] = posterPath;
    map['vote_average'] = voteAverage;
    map['release_date'] = releaseDate;
    map['overview'] = overview;
    map['backdrop_path'] = backdropPath;

    // الخصائص الإضافية
    if (url != null) map['url'] = url;
    if (imdbCode != null) map['imdb_code'] = imdbCode;
    if (titleEnglish != null) map['title_english'] = titleEnglish;
    if (titleLong != null) map['title_long'] = titleLong;
    if (slug != null) map['slug'] = slug;
    if (year != null) map['year'] = year;
    if (rating != null) map['rating'] = rating;
    if (runtime != null) map['runtime'] = runtime;
    if (genres != null) map['genres'] = genres;
    if (likeCount != null) map['like_count'] = likeCount;
    if (descriptionIntro != null) map['description_intro'] = descriptionIntro;
    if (descriptionFull != null) map['description_full'] = descriptionFull;
    if (ytTrailerCode != null) map['yt_trailer_code'] = ytTrailerCode;
    if (language != null) map['language'] = language;
    if (mpaRating != null) map['mpa_rating'] = mpaRating;
    if (backgroundImage != null) map['background_image'] = backgroundImage;
    if (backgroundImageOriginal != null) map['background_image_original'] = backgroundImageOriginal;
    if (smallCoverImage != null) map['small_cover_image'] = smallCoverImage;
    if (mediumCoverImage != null) map['medium_cover_image'] = mediumCoverImage;
    if (largeCoverImage != null) map['large_cover_image'] = largeCoverImage;
    if (dateUploaded != null) map['date_uploaded'] = dateUploaded;
    if (dateUploadedUnix != null) map['date_uploaded_unix'] = dateUploadedUnix;

    if (torrents != null) {
      map['torrents'] = torrents!.map((v) => v.toJson()).toList();
    }

    if (cast != null) {
      map['cast'] = cast!.map((v) => v.toJson()).toList();
    }

    return map;
  }

  // دالة مساعدة للتحقق من وجود بيانات الفيلم الأساسية
  bool get hasBasicInfo => title.isNotEmpty && id > 0;

  // دالة مساعدة للحصول على أفضل صورة متاحة
  String get bestAvailableImage {
    return largeCoverImage ??
        mediumCoverImage ??
        smallCoverImage ??
        backdropPath ??
        posterPath ??
        backgroundImageOriginal ??
        backgroundImage ??
        '';
  }

  // دالة مساعدة للحصول على أفضل وصف متاح
  String get bestAvailableDescription {
    return overview.isNotEmpty ? overview :
    descriptionFull ??
        descriptionIntro ??
        '';
  }

  // دالة مساعدة للحصول على تقييم الفيلم
  double get movieRating {
    return voteAverage > 0 ? voteAverage : (rating ?? 0.0);
  }
}