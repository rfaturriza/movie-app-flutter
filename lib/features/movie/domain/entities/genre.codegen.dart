import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/genre_response_model.codegen.dart';

part 'genre.codegen.freezed.dart';

@freezed
class Genre with _$Genre {
  const factory Genre({
    int? id,
    String? name,
  }) = _Genre;

  const Genre._();

  GenreModel toModel() => GenreModel(
        id: id,
        name: name,
      );
}
