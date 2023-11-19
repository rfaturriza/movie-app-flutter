import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/data/models/search_movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';
import 'package:test_xsis/features/movie/domain/usecase/search_movies_usecase.dart';

import '../../../../../core/utils/extension/string_ext.dart';

part 'search_movie_bloc.freezed.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

@injectable
class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMoviesUseCase searchMoviesUseCase;

  SearchMovieBloc({
    required this.searchMoviesUseCase,
  }) : super(const SearchMovieState()) {
    on<_SearchMovieEvent>(_onSearchMovieFetch);
  }

  void _onSearchMovieFetch(
    _SearchMovieEvent event,
    Emitter<SearchMovieState> emit,
  ) async {
    if (event.page == 1) {
      emit(state.copyWith(
        movies: [],
        hasReachedMax: false,
      ));
    }
    if (state.hasReachedMax) return;
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
      search: event.query,
    ));
    final result = await searchMoviesUseCase(
      SearchMoviesParams(
        requestModel: SearchMovieRequestModel(
          query: event.query,
          page: event.page,
        ),
      ),
    );
    result.fold((l) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }, (r) {
      final pagination = r.pagination;
      final resultMovie = r.results ?? [];
      final currentMovie = state.movies;
      final movies =
          currentMovie != null ? currentMovie + resultMovie : resultMovie;
      if (resultMovie.length < (pagination?.totalResults ?? 0)) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          hasReachedMax: true,
          movies: event.page == null ? movies : resultMovie,
        ));
        return;
      }
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        movies: event.page == null ? movies : resultMovie,
        hasReachedMax: false,
      ));
    });
  }
}
