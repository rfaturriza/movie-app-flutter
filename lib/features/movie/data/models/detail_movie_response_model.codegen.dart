import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_xsis/features/movie/data/models/genre_response_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/detail_movie.codegen.dart';

part 'detail_movie_response_model.codegen.freezed.dart';

part 'detail_movie_response_model.codegen.g.dart';

@freezed
class DetailMovieResponseModel with _$DetailMovieResponseModel {
  const factory DetailMovieResponseModel({
    bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    int? budget,
    List<GenreModel>? genres,
    String? homepage,
    int? id,
    @JsonKey(name: 'imdb_id') String? imdbId,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    String? overview,
    double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'production_companies')
    List<ProductionCompaniesModel>? productionCompanies,
    @JsonKey(name: 'production_countries')
    List<ProductionCountriesModel>? productionCountries,
    @JsonKey(name: 'release_date') String? releaseDate,
    int? revenue,
    int? runtime,
    @JsonKey(name: 'spoken_languages')
    List<SpokenLanguagesModel>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') int? voteCount,
  }) = _DetailMovieResponseModel;

  const DetailMovieResponseModel._();

  factory DetailMovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DetailMovieResponseModelFromJson(json);

  DetailMovie toEntity() => DetailMovie(
        adult: adult,
        backdropPath: backdropPath,
        budget: budget,
        genres: genres?.map((e) => e.toEntity()).toList(),
        homepage: homepage,
        id: id,
        imdbId: imdbId,
        originalLanguage: originalLanguage,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        productionCompanies:
            productionCompanies?.map((e) => e.toEntity()).toList(),
        productionCountries:
            productionCountries?.map((e) => e.toEntity()).toList(),
        releaseDate: releaseDate,
        revenue: revenue,
        runtime: runtime,
        spokenLanguages: spokenLanguages?.map((e) => e.toEntity()).toList(),
        status: status,
        tagline: tagline,
        title: title,
        video: video,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );
}

@freezed
class ProductionCompaniesModel with _$ProductionCompaniesModel {
  const factory ProductionCompaniesModel({
    int? id,
    @JsonKey(name: 'logo_path') String? logoPath,
    String? name,
    @JsonKey(name: 'origin_country') String? originCountry,
  }) = _ProductionCompaniesModel;

  const ProductionCompaniesModel._();

  factory ProductionCompaniesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesModelFromJson(json);

  ProductionCompany toEntity() => ProductionCompany(
        id: id,
        logoPath: logoPath,
        name: name,
        originCountry: originCountry,
      );
}

@freezed
class ProductionCountriesModel with _$ProductionCountriesModel {
  const factory ProductionCountriesModel({
    @JsonKey(name: 'iso_3166_1') String? iso31661,
    String? name,
  }) = _ProductionCountriesModel;

  const ProductionCountriesModel._();

  factory ProductionCountriesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountriesModelFromJson(json);

  ProductionCountry toEntity() => ProductionCountry(
        iso31661: iso31661,
        name: name,
      );
}

@freezed
class SpokenLanguagesModel with _$SpokenLanguagesModel {
  const factory SpokenLanguagesModel({
    @JsonKey(name: 'english_name') String? englishName,
    @JsonKey(name: 'iso_639_1') String? iso6391,
    String? name,
  }) = _SpokenLanguagesModel;

  const SpokenLanguagesModel._();

  factory SpokenLanguagesModel.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesModelFromJson(json);

  SpokenLanguage toEntity() => SpokenLanguage(
        englishName: englishName,
        iso6391: iso6391,
        name: name,
      );
}
