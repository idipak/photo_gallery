
const String tablePhoto = 'photos';

class PhotoFields{
  static final List<String> values = [
    id, title, url
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String url = 'url';
  static const String tag = 'tag';
}

class Photo{
  final int? id;
  final String title;
  final String url;
  final String tag;

  const Photo({
    this.id,
    required this.title,
    required this.tag,
    required this.url
  });

  Map<String, Object?> toJson(){
    return {
      PhotoFields.id : id,
      PhotoFields.title : title,
      PhotoFields.url : url,
      PhotoFields.tag : tag,
    };
  }

  static Photo fromJson(Map<String, dynamic> json){
    return Photo(
        id: json[PhotoFields.id] as int,
        title: json[PhotoFields.title] as String,
        tag: json[PhotoFields.tag] as String,
        url: json[PhotoFields.url] as String,
        );
  }

  Photo copy({
    int? id,
    String? title,
    String? tag,
    String? url
  }) => Photo(
      id: id ?? this.id,
      title: title ?? this.title,
      tag: tag ?? this.tag,
      url: url ?? this.url
  );


}