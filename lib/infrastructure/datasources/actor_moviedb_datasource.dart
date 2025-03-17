import 'package:dio/dio.dart';
import 'package:film_mania/config/constants/environment.dart';
import 'package:film_mania/domain/datasources/actors_datasource.dart';
import 'package:film_mania/domain/entities/actor.dart';
import 'package:film_mania/infrastructure/mappers/actor_mapper.dart';
import 'package:film_mania/infrastructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDBKey,
    'language': 'en-US',
  }));
  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if (response.statusCode != 200) {
      throw Exception('Failed to load actors');
    }

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actorList = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actorList;
  }
}
