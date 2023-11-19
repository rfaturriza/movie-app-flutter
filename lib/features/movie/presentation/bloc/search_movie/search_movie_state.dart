part of 'search_movie_bloc.dart';

@freezed
class SearchMovieState with _$SearchMovieState {
  const factory SearchMovieState({
    List<Movie>? movies,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
    @Default(emptyString) String search,
    @Default(1) int page,
    @Default(false) bool hasReachedMax,
  }) = _SearchMovieState;
}
