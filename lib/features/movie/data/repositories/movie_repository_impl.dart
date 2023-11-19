import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/core/error/failures.dart';
import 'package:test_xsis/features/movie/data/datasources/remote/movie_remote_data_source.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/search_movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/detail_movie.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/genre.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/video_movie.codegen.dart';

import '../../domain/repositories/movie_repository.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  const MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetailMovie>> getDetailMovie(int movieId) async {
    final result = await remoteDataSource.getDetailMovie(movieId);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.toEntity(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<Genre>>> getGenres() async {
    final result = await remoteDataSource.getGenres();
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.toEntity(),
      ),
    );
  }

  @override
  Future<Either<Failure, MoviePagination>> getMovies(
      MovieRequestModel movieRequestModel) async {
    final result = await remoteDataSource.getMovies(movieRequestModel);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.toEntity(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<VideoMovie>>> getVideos(int movieId) async {
    final result = await remoteDataSource.getVideos(movieId);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.toEntity(),
      ),
    );
  }

  @override
  Future<Either<Failure, MoviePagination>> searchMovies(
    SearchMovieRequestModel request,
  ) async {
    final result = await remoteDataSource.searchMovies(request);
    return result.fold(
      (error) => left(error),
      (r) => right(
        r.toEntity(),
      ),
    );
  }
}
