part of 'detail_movie_bloc.dart';

@freezed
class DetailMovieState with _$DetailMovieState {
  const factory DetailMovieState({
    DetailMovie? movie,
    List<VideoMovie>? videos,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = _DetailMovieState;
}

