import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pagination.codegen.dart';

part 'pagination_model.codegen.freezed.dart';
part 'pagination_model.codegen.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @JsonKey(name: 'page') int? page,
    @JsonKey(name: 'total_results') int? totalResults,
    @JsonKey(name: 'total_pages') int? totalPages,
  }) = _PaginationModel;

  const PaginationModel._();

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Pagination toEntity() => Pagination(
        page: page,
        totalResults: totalResults,
        totalPages: totalPages,
      );
}