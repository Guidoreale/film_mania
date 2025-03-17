import 'package:film_mania/domain/datasources/actors_datasource.dart';
import 'package:film_mania/domain/entities/actor.dart';
import 'package:film_mania/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource actorsDatasource;

  ActorRepositoryImpl(this.actorsDatasource);

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) {
    return actorsDatasource.getActorsByMovieId(movieId);
  }
}
