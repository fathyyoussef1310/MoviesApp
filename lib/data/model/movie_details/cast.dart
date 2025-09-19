class Cast {
  String? name;
  String? characterName;
  String? imageUrl;
  String? imdbCode;

  Cast({this.name, this.characterName, this.imageUrl, this.imdbCode});

  Cast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    characterName = json['character_name'];
    imageUrl = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'character_name': characterName,
      'url_small_image': imageUrl,
      'imdb_code': imdbCode,
    };
  }
}
