import 'package:film_mania/infrastructure/datasources/moviedb_datasource.dart';
import 'package:film_mania/infrastructure/repositories/movie_repository_impl.dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//inmutable provider. only reads the value
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
