import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.codegen.dart';

@injectable
class GetMoviesUseCase implements UseCase<MoviePagination, GetMoviesParams> {
  final MovieRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MoviePagination>> call(GetMoviesParams params) async {
    return await repository.getMovies(params.requestModel);
  }
}

class GetMoviesParams extends Equatable {
  final MovieRequestModel requestModel;

  const GetMoviesParams({required this.requestModel});

  @override
  List<Object?> get props => [requestModel];
}
