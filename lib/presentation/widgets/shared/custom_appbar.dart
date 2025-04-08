import 'package:film_mania/domain/entities/movie.dart';
import 'package:film_mania/presentation/delegates/search_movie_delegate.dart';
import 'package:film_mania/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
      bottom: false,
      child: Container(
        decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.movie_outlined, color: colors.primary),
                  SizedBox(width: 10),
                  Text('Film Mania', style: titleStyle),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        final movieRepository =
                            ref.read(movieRepositoryProvider);

                        showSearch<Movie?>(
                            context: context,
                            delegate: SearchMovieDelegate(
                              searchMovies: movieRepository.searchMovies,
                            )).then(
                          (movie) {
                            if (movie == null) return;
                            if (context.mounted) {
                              context.push('/movie/${movie.id}');
                            }
                          },
                        );
                      },
                      icon: Icon(Icons.search_outlined))
                ],
              )),
        ),
      ),
    );
  }
}
