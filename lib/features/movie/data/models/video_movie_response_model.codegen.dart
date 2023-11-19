import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/features/movie/domain/entities/video_movie.codegen.dart';

part 'video_movie_response_model.codegen.freezed.dart';

part 'video_movie_response_model.codegen.g.dart';

@freezed
class VideoMovieResponseModel with _$VideoMovieResponseModel {
  const factory VideoMovieResponseModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'results') List<ResultsVideoMovieModel>? results,
  }) = _VideoMovieResponseModel;

  const VideoMovieResponseModel._();

  factory VideoMovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VideoMovieResponseModelFromJson(json);

  List<VideoMovie> toEntity() =>
      results?.map((e) => e.toEntity()).toList() ?? [];
}

@freezed
class ResultsVideoMovieModel with _$ResultsVideoMovieModel {
  const factory ResultsVideoMovieModel({
    @JsonKey(name: 'iso_639_1') String? iso6391,
    @JsonKey(name: 'iso_3166_1') String? iso31661,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'key') String? key,
    @JsonKey(name: 'site') String? site,
    @JsonKey(name: 'size') int? size,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'official') bool? official,
    @JsonKey(name: 'published_at') String? publishedAt,
    @JsonKey(name: 'id') String? id,
  }) = _ResultsVideoMovieModel;

  const ResultsVideoMovieModel._();

  factory ResultsVideoMovieModel.fromJson(Map<String, dynamic> json) =>
      _$ResultsVideoMovieModelFromJson(json);

  VideoMovie toEntity() => VideoMovie(
        iso6391: iso6391,
        iso31661: iso31661,
        name: name,
        key: key,
        site: site,
        size: size,
        type: type,
        official: official,
        publishedAt: publishedAt,
        id: id,
      );
}
