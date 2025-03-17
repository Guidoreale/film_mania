import 'package:film_mania/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:film_mania/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//inmutable provider. only reads the value
final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMoviedbDatasource());
});
