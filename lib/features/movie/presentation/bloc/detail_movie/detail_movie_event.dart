part of 'detail_movie_bloc.dart';

@freezed
class DetailMovieEvent with _$DetailMovieEvent {
  const factory DetailMovieEvent.getMovie({
    required int id,
  }) = _GetMovieEvent;

  const factory DetailMovieEvent.getVideo({
    required int id,
  }) = _GetVideoEvent;
}
