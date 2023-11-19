import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';
import 'package:test_xsis/features/movie/domain/usecase/get_genres_usecase.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/genre.codegen.dart';
import '../../../domain/usecase/get_movies_usecase.dart';

part 'discover_movie_bloc.freezed.dart';

part 'discover_movie_event.dart';

part 'discover_movie_state.dart';

@injectable
class DiscoverMovieBloc extends Bloc<DiscoverMovieEvent, DiscoverMovieState> {
  final GetGenresUseCase getGenres;
  final GetMoviesUseCase getMovies;

  DiscoverMovieBloc({
    required this.getGenres,
    required this.getMovies,
  }) : super(const DiscoverMovieState()) {
    on<_GetMoviesEvent>(_onGetMoviesFetch);
    on<_GetGenresEvent>(_onGetGenresFetch);
  }

  void _onGetMoviesFetch(
    _GetMoviesEvent event,
    Emitter<DiscoverMovieState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(
        movies: [],
        hasReachedMax: false,
      ));
    }
    if (state.hasReachedMax) return;
    emit(state.copyWith(statusMovie: FormzSubmissionStatus.inProgress));
    final result = await getMovies(
      GetMoviesParams(
        requestModel: MovieRequestModel(
          page: event.page,
        ),
      ),
    );
    result.fold((l) {
      emit(state.copyWith(
        statusMovie: FormzSubmissionStatus.failure,
      ));
    }, (r) {
      final pagination = r.pagination;
      final resultProduct = r.results ?? [];
      final currentProduct = state.movies;
      final movies = currentProduct != null
          ? currentProduct + resultProduct
          : resultProduct;
      if (resultProduct.length == (pagination?.totalResults ?? 0)) {
        emit(state.copyWith(
          statusMovie: FormzSubmissionStatus.success,
          hasReachedMax: true,
          page: pagination?.page ?? 1,
          movies: movies,
        ));
        return;
      }
      emit(state.copyWith(
        statusMovie: FormzSubmissionStatus.success,
        movies: movies,
        page: pagination?.page ?? 1,
        hasReachedMax: false,
      ));
    });
  }

  void _onGetGenresFetch(
    _GetGenresEvent event,
    Emitter<DiscoverMovieState> emit,
  ) async {
    emit(state.copyWith(statusGenre: FormzSubmissionStatus.inProgress));
    final result = await getGenres(NoParams());
    result.fold((l) {
      emit(state.copyWith(
        statusGenre: FormzSubmissionStatus.failure,
      ));
    }, (r) {
      emit(state.copyWith(
        statusGenre: FormzSubmissionStatus.success,
        genres: r,
      ));
    });
  }
}
