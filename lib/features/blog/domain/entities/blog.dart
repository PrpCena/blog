// ignore_for_file: non_constant_identifier_names

class Blog {
  final String id;
  final String poster_id;
  final String title;
  final String content;
  final String image_url;
  final List<String> topic;
  final DateTime updated_at;

  Blog({
    required this.id,
    required this.poster_id,
    required this.title,
    required this.content,
    required this.image_url,
    required this.topic,
    required this.updated_at,
  });
}
