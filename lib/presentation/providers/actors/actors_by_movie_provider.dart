import 'package:film_mania/domain/entities/actor.dart';
import 'package:film_mania/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorByMovieMapNotifier, Map<String, List<Actor>>>(
        (ref) {
  return ActorByMovieMapNotifier(
      getActors: ref.watch(actorRepositoryProvider).getActorsByMovieId);
});

typedef GetActorsByIdCallback = Future<List<Actor>> Function(String movieId);

class ActorByMovieMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsByIdCallback getActors;

  ActorByMovieMapNotifier({required this.getActors}) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
