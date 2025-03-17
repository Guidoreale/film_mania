import 'package:film_mania/domain/entities/movie.dart';
import 'package:film_mania/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchAnotherPage = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchAnotherPage: fetchAnotherPage);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchAnotherPage = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchAnotherPage: fetchAnotherPage);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchAnotherPage = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchAnotherPage: fetchAnotherPage);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchAnotherPage = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchAnotherPage: fetchAnotherPage);
});

typedef MovieCallback = Future<List<Movie>> Function({required int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchAnotherPage;

  MoviesNotifier({required this.fetchAnotherPage}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchAnotherPage(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(Duration(milliseconds: 300));
    isLoading = false;
  }
}
