import 'package:clean/core/common/widgets/loader.dart';
import 'package:clean/core/theme/app_pallete.dart';
import 'package:clean/core/utils/show_snackbar.dart';
import 'package:clean/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:clean/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:clean/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog App"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, AddNewBlogPage.route());
              },
              icon: const Icon(CupertinoIcons.add_circled),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            switch (state) {
              case BlogInitial():
                break;
              case BlogLoading():
                break;
              case BlogUploadSuccess():
                break;
              case BlogFetchSuccess():
                break;
              case BlogFailure():
                showSnackBar(context, state.error);
                break;
            }
          },
          builder: (context, state) {
            if (state is BlogFetchSuccess) {
              return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, idx) {
                  return BlogCard(
                    blog: state.blogs[idx],
                    color: idx % 3 == 0
                        ? AppPallete.gradient1
                        : idx % 3 == 1
                            ? AppPallete.gradient2
                            : AppPallete.gradient3,
                  );
                },
              );
            }

            return const Loader();
          },
        ));
  }
}
