import 'package:dio/dio.dart';
import 'package:film_mania/config/constants/environment.dart';
import 'package:film_mania/domain/datasources/movies_datasource.dart';
import 'package:film_mania/domain/entities/movie.dart';
import 'package:film_mania/infrastructure/mappers/movie_mapper.dart';
import 'package:film_mania/infrastructure/models/moviedb/movie_details.dart';
import 'package:film_mania/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDBKey,
    'language': 'en-US',
  }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    return MovieDbResponse.fromJson(json)
        .results
        .where((movieDb) =>
            movieDb.posterPath !=
            'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg')
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get('/movie/top_rated', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response =
        await dio.get('/movie/upcoming', queryParameters: {'page': page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieDetail(String movieId) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) {
      throw Exception('Failed to load movie detail');
    }

    return MovieMapper.movieDetailsToEntity(
        MovieDetails.fromJson(response.data));
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});
    return _jsonToMovies(response.data);
  }
}
