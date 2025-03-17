import 'package:film_mania/presentation/providers/movies/movies_providers.dart';
import 'package:film_mania/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final currentPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    if (currentPlayingMovies.isEmpty ||
        popularMovies.isEmpty ||
        upcomingMovies.isEmpty ||
        topRatedMovies.isEmpty) {
      return const ScreenSkeleton();
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          surfaceTintColor: Colors.white,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              SizedBox(height: 20),
              MoviesSlideshow(
                  movies: currentPlayingMovies.isNotEmpty
                      ? currentPlayingMovies.sublist(0, 6)
                      : []),
              SizedBox(height: 20),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerTheme.color,
              ),
              MovieHorizontalListview(
                movies: currentPlayingMovies,
                title: 'Now Playing',
                //put the current date on the subtitle
                subtitle: '${DateTime.now().day}/${DateTime.now().month}',
                loadNextMovies: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerTheme.color,
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Upcoming',
                subtitle: 'This Month',
                loadNextMovies: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerTheme.color,
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Popular',
                subtitle: 'Trending Now',
                // subtitle: 'This Month',
                loadNextMovies: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerTheme.color,
              ),
              MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  subtitle: 'All-Time Favorites',
                  loadNextMovies: () =>
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage()),
            ],
          );
        }, childCount: 1)),
      ],
    );
  }
}
