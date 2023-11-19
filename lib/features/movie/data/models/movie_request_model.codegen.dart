
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_request_model.codegen.freezed.dart';
part 'movie_request_model.codegen.g.dart';

@freezed
class MovieRequestModel with _$MovieRequestModel {
  const factory MovieRequestModel({
    @JsonKey(name: 'include_adult') bool? includeAdult,
    @JsonKey(name: 'include_video') bool? includeVideo,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'sort_by') String? sortBy,
    @JsonKey(name: 'with_genres') String? withGenres,
  }) = _MovieRequestModel;

  const MovieRequestModel._();

  factory MovieRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MovieRequestModelFromJson(json);
}