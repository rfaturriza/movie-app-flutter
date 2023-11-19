import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/domain/entities/video_movie.codegen.dart';

import '../../../domain/entities/detail_movie.codegen.dart';
import '../../../domain/usecase/get_detail_movie_usecase.dart';
import '../../../domain/usecase/get_videos_usecase.dart';

part 'detail_movie_bloc.freezed.dart';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

@injectable
class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetDetailMovieUseCase getMovie;
  final GetVideosUseCase getVideo;

  DetailMovieBloc(
    this.getMovie,
    this.getVideo,
  ) : super(const DetailMovieState()) {
    on<_GetMovieEvent>(_onGetMovie);
    on<_GetVideoEvent>(_onGetVideo);
  }

  void _onGetMovie(
    _GetMovieEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await getMovie(
      GetDetailMovieParams(movieId: event.id),
    );
    result.fold((l) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }, (r) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        movie: r,
      ));
    });
  }

  void _onGetVideo(
    _GetVideoEvent event,
    Emitter<DetailMovieState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final result = await getVideo(
      GetVideosParams(movieId: event.id),
    );
    result.fold((l) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }, (r) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        videos: r,
      ));
    });
  }
}
