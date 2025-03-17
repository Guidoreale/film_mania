import 'package:film_mania/domain/entities/movie.dart';
import 'package:film_mania/infrastructure/models/moviedb/movie_details.dart';
import 'package:film_mania/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieDB movieDb) => Movie(
        adult: movieDb.adult,
        genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
        originalLanguage: movieDb.originalLanguage,
        originalTitle: movieDb.originalTitle,
        popularity: movieDb.popularity,
        video: movieDb.video,
        voteCount: movieDb.voteCount,
        id: movieDb.id,
        title: movieDb.title,
        overview: movieDb.overview,
        posterPath: (movieDb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDb.posterPath}'
            : 'no-poster',
        backdropPath: movieDb.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDb.backdropPath}'
            : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
        releaseDate: movieDb.releaseDate,
        voteAverage: movieDb.voteAverage,
      );

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
        adult: movieDetails.adult,
        genreIds: movieDetails.genres.map((e) => e.name).toList(),
        originalLanguage: movieDetails.originalLanguage,
        originalTitle: movieDetails.originalTitle,
        popularity: movieDetails.popularity,
        video: movieDetails.video,
        voteCount: movieDetails.voteCount,
        id: movieDetails.id,
        title: movieDetails.title,
        overview: movieDetails.overview,
        posterPath: (movieDetails.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${movieDetails.posterPath}'
            : 'no-poster',
        backdropPath: movieDetails.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${movieDetails.backdropPath}'
            : 'https://m.media-amazon.com/images/I/61s8vyZLSzL._AC_UF894,1000_QL80_.jpg',
        releaseDate: movieDetails.releaseDate,
        voteAverage: movieDetails.voteAverage,
      );
}
