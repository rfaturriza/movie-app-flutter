
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_movie_request_model.codegen.freezed.dart';
part 'search_movie_request_model.codegen.g.dart';

@freezed
class SearchMovieRequestModel with _$SearchMovieRequestModel {
  const factory SearchMovieRequestModel({
    @JsonKey(name: 'query') String? query,
    @JsonKey(name: 'include_adult') bool? includeAdult,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'region') String? region,
    @JsonKey(name: 'year') int? year,
    @JsonKey(name: 'primary_release_year') int? primaryReleaseYear,
  }) = _SearchMovieRequestModel;

  const SearchMovieRequestModel._();

  factory SearchMovieRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SearchMovieRequestModelFromJson(json);
}