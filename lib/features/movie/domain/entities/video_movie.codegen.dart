import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/features/movie/data/models/video_movie_response_model.codegen.dart';

part 'video_movie.codegen.freezed.dart';
@freezed
class VideoMovie with _$VideoMovie {
  const factory VideoMovie({
    String? iso6391,
    String? iso31661,
    String? name,
    String? key,
    String? site,
    int? size,
    String? type,
    bool? official,
    String? publishedAt,
    String? id,
  }) = _VideoMovie;

  const VideoMovie._();

  ResultsVideoMovieModel toModel() => ResultsVideoMovieModel(
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
