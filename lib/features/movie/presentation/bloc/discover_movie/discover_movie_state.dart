part of 'discover_movie_bloc.dart';

@freezed
class DiscoverMovieState with _$DiscoverMovieState {
  const factory DiscoverMovieState({
    List<Movie>? movies,
    List<Genre>? genres,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusMovie,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus statusGenre,
    @Default(1) int page,
    @Default(false) bool hasReachedMax,
  }) = _DiscoverMovieState;
}
