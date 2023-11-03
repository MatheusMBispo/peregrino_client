class Audio {
  Audio({
    required this.groups,
    this.backgroundImage,
    this.chaptersDuration,
    this.title,
    this.description,
    this.imageUrl,
    this.author,
    this.genre,
    this.year,
    this.id,
    this.audioUrl,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    final audioCollection = json['audioCollection'] as Map<String, dynamic>?;
    final groups = audioCollection?['groups'] as List<dynamic>?;
    return Audio(
      groups: groups
              ?.map(
                (data) => AudioGroup.fromJson(data as Map<String, dynamic>),
              )
              .toList() ??
          [],
      backgroundImage: audioCollection?['backgroundImage'] as String?,
      chaptersDuration: (json['chaptersDuration'] as num?)?.toDouble(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      audioUrl: json['audioUrl'] as String?,
      imageUrl: audioCollection?['imageUrl'] as String?,
      author: json['author'] as String?,
      genre: json['genre'] as String?,
      year: (json['year'] as num?)?.toInt(),
      id: json['id'] as String?,
    );
  }

  List<AudioGroup> groups;
  String? backgroundImage;
  double? chaptersDuration;
  String? title;
  String? description;
  String? audioUrl;
  String? imageUrl;
  String? author;
  String? genre;
  int? year;
  String? id;
}

class AudioGroup {
  AudioGroup({
    required this.id,
    required this.title,
    required this.audioIds,
  });

  factory AudioGroup.fromJson(Map<String, dynamic> json) {
    return AudioGroup(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      audioIds: (json['audios'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  String? id;
  String? title;
  List<String>? audioIds;
}
