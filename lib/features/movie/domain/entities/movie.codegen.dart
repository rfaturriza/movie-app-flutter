import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/shared/domain/entities/pagination.codegen.dart';

part 'movie.codegen.freezed.dart';

@freezed
class MoviePagination with _$MoviePagination {
  const factory MoviePagination({
    List<Movie>? results,
    Pagination? pagination,
  }) = _MoviePagination;

  const MoviePagination._();
}

@freezed
class Movie with _$Movie {
  const factory Movie({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) = _Movie;

  const Movie._();
}
