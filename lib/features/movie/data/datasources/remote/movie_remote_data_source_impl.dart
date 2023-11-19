import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/core/error/failures.dart';
import 'package:test_xsis/features/movie/data/models/detail_movie_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/genre_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/movie_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/search_movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/video_movie_response_model.codegen.dart';

import 'movie_remote_data_source.dart';

@LazySingleton(as: MovieRemoteDataSource)
class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const _endpointGenre = 'genre/movie/list';
  static const _endpointMovie = 'movie';
  static const _endpointDiscover = 'discover/movie';
  static const _endpointSearch = 'search/movie';
  final Dio _dio;

  const MovieRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, DetailMovieResponseModel>> getDetailMovie(
    int movieId, {
    String? language,
  }) async {
    try {
      final queryParameters = {
        'language': language ?? 'en-US',
      };
      final result = await _dio.get(
        '$_endpointMovie/$movieId',
        queryParameters: queryParameters,
      );
      return Right(DetailMovieResponseModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, GenreResponseModel>> getGenres({
    String? language,
  }) async {
    try {
      final queryParameters = {
        'language': language,
      };
      final result = await _dio.get(
        _endpointGenre,
        queryParameters: queryParameters,
      );
      return Right(GenreResponseModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MovieResponseModel>> getMovies(
    MovieRequestModel requestModel,
  ) async {
    try {
      final queryParameters = requestModel
          .copyWith(
            language: 'en-US',
            includeAdult: true,
            sortBy: 'popularity.desc',
            includeVideo: true,
          )
          .toJson();
      final result = await _dio.get(
        _endpointDiscover,
        queryParameters: queryParameters,
      );
      return Right(MovieResponseModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, VideoMovieResponseModel>> getVideos(
    int movieId, {
    String? language,
  }) async {
    try {
      final queryParameters = {
        'language': language ?? 'en-US',
      };
      final result = await _dio.get(
        '$_endpointMovie/$movieId/videos',
        queryParameters: queryParameters,
      );
      return Right(VideoMovieResponseModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, MovieResponseModel>> searchMovies(
    SearchMovieRequestModel requestModel,
  ) async {
    try {
      final queryParameters = requestModel
          .copyWith(
            language: 'en-US',
            includeAdult: true,
          )
          .toJson();
      final result = await _dio.get(
        _endpointSearch,
        queryParameters: queryParameters,
      );
      return Right(MovieResponseModel.fromJson(result.data));
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
