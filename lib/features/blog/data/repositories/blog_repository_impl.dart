import 'dart:io';

import 'package:clean/core/common/constants/constant.dart';
import 'package:clean/core/error/exception.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/core/network/connection_checker.dart';
import 'package:clean/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:clean/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:clean/features/blog/data/models/blog_model.dart';
import 'package:clean/features/blog/domain/entities/blog.dart';
import 'package:clean/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.blogLocalDataSource,
      this.connectionChecker);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topic,
  }) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constant.noInternetConnnectionMessage));
      }

      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        poster_id: posterId,
        title: title,
        content: content,
        image_url: '',
        topic: topic,
        updated_at: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          blog: blogModel, image: image);
      blogModel = blogModel.copyWith(image_url: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }

      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.error));
    }
  }
}
