import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/genre.codegen.dart';

part 'genre_response_model.codegen.freezed.dart';

part 'genre_response_model.codegen.g.dart';

@freezed
class GenreResponseModel with _$GenreResponseModel {
  const factory GenreResponseModel({
    @JsonKey(name: 'genres') List<GenreModel>? genres,
  }) = _GenreResponseModel;

  const GenreResponseModel._();

  factory GenreResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseModelFromJson(json);

  List<Genre> toEntity() => genres?.map((e) => e.toEntity()).toList() ?? [];
}

@freezed
class GenreModel with _$GenreModel {
  const factory GenreModel({
    int? id,
    String? name,
  }) = _GenreModel;

  const GenreModel._();

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Genre toEntity() => Genre(
        id: id,
        name: name,
      );
}
