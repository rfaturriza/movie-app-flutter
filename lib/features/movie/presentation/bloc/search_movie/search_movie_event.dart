part of 'search_movie_bloc.dart';

@freezed
class SearchMovieEvent with _$SearchMovieEvent {
  const factory SearchMovieEvent.searchProduct({
    @Default(emptyString) String query,
    int? page,
  }) = _SearchMovieEvent;
}
