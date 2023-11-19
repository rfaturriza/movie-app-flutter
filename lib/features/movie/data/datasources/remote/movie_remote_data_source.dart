import 'package:dartz/dartz.dart';
import 'package:test_xsis/core/error/failures.dart';
import 'package:test_xsis/features/movie/data/models/detail_movie_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/genre_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/movie_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/search_movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/video_movie_response_model.codegen.dart';

abstract class MovieRemoteDataSource {
  Future<Either<Failure, GenreResponseModel>> getGenres({
    String? language,
  });

  Future<Either<Failure, DetailMovieResponseModel>> getDetailMovie(
    int movieId, {
    String? language,
  });

  Future<Either<Failure, VideoMovieResponseModel>> getVideos(
    int movieId, {
    String? language,
  });

  Future<Either<Failure, MovieResponseModel>> getMovies(
    MovieRequestModel requestModel,
  );

  Future<Either<Failure, MovieResponseModel>> searchMovies(
    SearchMovieRequestModel requestModel,
  );
}
