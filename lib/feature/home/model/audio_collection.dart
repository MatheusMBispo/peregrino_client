class AudioCollection {
  AudioCollection({
    this.backgroundImage,
    this.chaptersDuration,
    this.title,
    this.description,
    this.imageUrl,
    this.author,
    this.genre,
    this.year,
    this.isFree,
    this.id,
  });

  AudioCollection.fromJson(Map<String, dynamic> json)
      : backgroundImage = json['backgroundImage'] as String?,
        chaptersDuration = (json['chaptersDuration'] as num?)?.toDouble(),
        title = json['title'] as String?,
        description = json['description'] as String?,
        imageUrl = json['imageUrl'] as String?,
        author = json['author'] as String?,
        genre = json['genre'] as String?,
        year = (json['year'] as num?)?.toInt(),
        isFree = json['isFree'] as bool?,
        id = json['id'] as String?;

  String? backgroundImage;
  double? chaptersDuration;
  String? title;
  String? description;
  String? imageUrl;
  String? author;
  String? genre;
  int? year;
  String? id;
  bool? isFree;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['backgroundImage'] = backgroundImage;
    data['chaptersDuration'] = chaptersDuration;
    data['title'] = title;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['author'] = author;
    data['genre'] = genre;
    data['year'] = year;
    data['id'] = id;
    return data;
  }
}
