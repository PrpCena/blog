// ignore_for_file: non_constant_identifier_names

import 'package:clean/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.poster_id,
    required super.title,
    required super.content,
    required super.image_url,
    required super.topics,
    required super.updated_at,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'poster_id': poster_id,
        'title': title,
        'content': content,
        'imageUrl': image_url,
        'topics': topics,
        'updatedAt': updated_at.toIso8601String(),
      };

  factory BlogModel.fromJson(Map<String, dynamic> map) => BlogModel(
        id: map['id'] as String,
        poster_id: map['poster_id'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
        image_url: map['image_url'] as String,
        topics: List<String>.from(map['topics'] as List<String>),
        updated_at: map['updated_at'] == null
            ? DateTime.now()
            : DateTime.parse(map['updated_at']),
      );

  BlogModel copyWith({
    String? id,
    String? poster_id,
    String? title,
    String? content,
    String? image_url,
    List<String>? topics,
    DateTime? updated_at,
  }) {
    return BlogModel(
      id: id ?? this.id,
      poster_id: poster_id ?? this.poster_id,
      title: title ?? this.title,
      content: content ?? this.content,
      image_url: image_url ?? this.image_url,
      topics: topics ?? this.topics,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}
