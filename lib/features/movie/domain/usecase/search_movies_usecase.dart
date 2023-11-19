import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/data/models/search_movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.codegen.dart';

@injectable
class SearchMoviesUseCase implements UseCase<MoviePagination, SearchMoviesParams> {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MoviePagination>> call(SearchMoviesParams params) async {
    return await repository.searchMovies(params.requestModel);
  }
}

class SearchMoviesParams extends Equatable {
  final SearchMovieRequestModel requestModel;

  const SearchMoviesParams({required this.requestModel});

  @override
  List<Object?> get props => [requestModel];
}
