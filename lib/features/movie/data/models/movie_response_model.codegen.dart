import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';

import '../../../../shared/domain/entities/pagination.codegen.dart';

part 'movie_response_model.codegen.freezed.dart';

part 'movie_response_model.codegen.g.dart';

@freezed
class MovieResponseModel with _$MovieResponseModel {
  const factory MovieResponseModel({
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'results') List<MovieResultModel>? results,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'total_results') int? totalResults,
  }) = _MovieResponseModel;

  const MovieResponseModel._();

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);

  MoviePagination toEntity() => MoviePagination(
        results: results?.map((e) => e.toEntity()).toList(),
        pagination: Pagination(
          page: page,
          totalPages: totalPages,
          totalResults: totalResults,
        ),
      );
}

@freezed
class MovieResultModel with _$MovieResultModel {
  const factory MovieResultModel({
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'genre_ids') List<int>? genreIds,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'video') bool? video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _MovieResultModel;

  const MovieResultModel._();

  factory MovieResultModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResultModelFromJson(json);

  Movie toEntity() => Movie(
        adult: adult,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: releaseDate,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}
