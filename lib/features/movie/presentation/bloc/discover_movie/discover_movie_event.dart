part of 'discover_movie_bloc.dart';

@freezed
class DiscoverMovieEvent with _$DiscoverMovieEvent {
  const factory DiscoverMovieEvent.getMovies({
    int? page,
  }) = _GetMoviesEvent;

  const factory DiscoverMovieEvent.getGenres() = _GetGenresEvent;
}
