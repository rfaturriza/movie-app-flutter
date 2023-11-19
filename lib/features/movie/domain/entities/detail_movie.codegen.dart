import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/features/movie/data/models/detail_movie_response_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/genre_response_model.codegen.dart';
import 'package:test_xsis/shared/domain/entities/pagination.codegen.dart';

import 'genre.codegen.dart';

part 'detail_movie.codegen.freezed.dart';

@freezed
class DetailMovie with _$DetailMovie {
  const factory DetailMovie({
    bool? adult,
    String? backdropPath,
    int? budget,
    List<Genre>? genres,
    String? homepage,
    int? id,
    String? imdbId,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    List<ProductionCompany>? productionCompanies,
    List<ProductionCountry>? productionCountries,
    String? releaseDate,
    int? revenue,
    int? runtime,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
    Pagination? pagination,
  }) = _DetailMovie;

  const DetailMovie._();

  DetailMovieResponseModel toModel() => DetailMovieResponseModel(
        adult: adult,
        backdropPath: backdropPath,
        budget: budget,
        genres: genres?.map((e) => e.toModel()).toList(),
        homepage: homepage,
        id: id,
        imdbId: imdbId,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        productionCompanies:
            productionCompanies?.map((e) => e.toModel()).toList(),
        productionCountries:
            productionCountries?.map((e) => e.toModel()).toList(),
        releaseDate: releaseDate,
        revenue: revenue,
        runtime: runtime,
        spokenLanguages: spokenLanguages?.map((e) => e.toModel()).toList(),
        status: status,
        tagline: tagline,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}

@freezed
class ProductionCompany with _$ProductionCompany {
  const factory ProductionCompany({
    int? id,
    String? logoPath,
    String? name,
    String? originCountry,
  }) = _ProductionCompany;

  const ProductionCompany._();

  ProductionCompaniesModel toModel() => ProductionCompaniesModel(
        id: id,
        logoPath: logoPath,
        name: name,
        originCountry: originCountry,
      );
}

@freezed
class ProductionCountry with _$ProductionCountry {
  const factory ProductionCountry({
    String? iso31661,
    String? name,
  }) = _ProductionCountry;

  const ProductionCountry._();

  ProductionCountriesModel toModel() => ProductionCountriesModel(
        iso31661: iso31661,
        name: name,
      );
}

@freezed
class SpokenLanguage with _$SpokenLanguage {
  const factory SpokenLanguage({
    String? englishName,
    String? iso6391,
    String? name,
  }) = _SpokenLanguage;

  const SpokenLanguage._();

  SpokenLanguagesModel toModel() => SpokenLanguagesModel(
        englishName: englishName,
        iso6391: iso6391,
        name: name,
      );
}
