import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/shared/data/models/pagination_model.codegen.dart';

part 'pagination.codegen.freezed.dart';

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    int? page,
    int? totalResults,
    int? totalPages,
  }) = _Pagination;

  const Pagination._();

  PaginationModel toModel() => PaginationModel(
        page: page,
        totalResults: totalResults,
        totalPages: totalPages,
      );
}
