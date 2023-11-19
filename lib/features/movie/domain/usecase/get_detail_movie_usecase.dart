import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/detail_movie.codegen.dart';

@injectable
class GetDetailMovieUseCase
    implements UseCase<DetailMovie, GetDetailMovieParams> {
  final MovieRepository repository;

  GetDetailMovieUseCase(this.repository);

  @override
  Future<Either<Failure, DetailMovie>> call(GetDetailMovieParams params) async {
    return await repository.getDetailMovie(params.movieId);
  }
}

class GetDetailMovieParams extends Equatable {
  final int movieId;

  const GetDetailMovieParams({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
