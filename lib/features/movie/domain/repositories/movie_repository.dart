import 'package:dartz/dartz.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/genre.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/search_movie_request_model.codegen.dart';
import '../entities/detail_movie.codegen.dart';
import '../entities/video_movie.codegen.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Genre>>> getGenres();

  Future<Either<Failure, DetailMovie>> getDetailMovie(
    int movieId,
  );

  Future<Either<Failure, MoviePagination>> getMovies(
    MovieRequestModel movieRequestModel,
  );

  Future<Either<Failure, MoviePagination>> searchMovies(
    SearchMovieRequestModel request,
  );

  Future<Either<Failure, List<VideoMovie>>> getVideos(
    int movieId,
  );
}
