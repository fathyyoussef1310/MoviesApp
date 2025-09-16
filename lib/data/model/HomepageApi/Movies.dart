import 'Torrents.dart';

class Movies {
  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Movies.fromJson(dynamic json) {
    id = json['id'] as int?;
    url = json['url'] as String?;
    imdbCode = json['imdb_code'] as String?;
    title = json['title'] as String?;
    titleEnglish = json['title_english'] as String?;
    titleLong = json['title_long'] as String?;
    slug = json['slug'] as String?;
    year = json['year'] != null ? (json['year'] as num).toInt() : null;
    rating = json['rating'] != null ? (json['rating'] as num).toDouble() : null;
    runtime = json['runtime'] != null ? (json['runtime'] as num).toInt() : null;
    genres = json['genres'] != null ? List<String>.from(json['genres']) : [];
    summary = json['summary'] as String?;
    descriptionFull = json['description_full'] as String?;
    synopsis = json['synopsis'] as String?;
    ytTrailerCode = json['yt_trailer_code'] as String?;
    language = json['language'] as String?;
    mpaRating = json['mpa_rating'] as String?;
    backgroundImage = json['background_image'] as String?;
    backgroundImageOriginal = json['background_image_original'] as String?;
    smallCoverImage = json['small_cover_image'] as String?;
    mediumCoverImage = json['medium_cover_image'] as String?;
    largeCoverImage = json['large_cover_image'] as String?;
    state = json['state'] as String?;
    if (json['torrents'] != null) {
      torrents = [];
      json['torrents'].forEach((v) {
        torrents?.add(Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'] as String?;
    dateUploadedUnix = json['date_uploaded_unix'] != null ? (json['date_uploaded_unix'] as num).toInt() : null;
  }

  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['imdb_code'] = imdbCode;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['slug'] = slug;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['synopsis'] = synopsis;
    map['yt_trailer_code'] = ytTrailerCode;
    map['language'] = language;
    map['mpa_rating'] = mpaRating;
    map['background_image'] = backgroundImage;
    map['background_image_original'] = backgroundImageOriginal;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    if (torrents != null) {
      map['torrents'] = torrents?.map((v) => v.toJson()).toList();
    }
    map['date_uploaded'] = dateUploaded;
    map['date_uploaded_unix'] = dateUploadedUnix;
    return map;
  }
}
