import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/domain/entities/genre.codegen.dart';
import 'package:test_xsis/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

@injectable
class GetGenresUseCase implements UseCase<List<Genre>?, NoParams> {
  final MovieRepository repository;

  GetGenresUseCase(this.repository);

  @override
  Future<Either<Failure, List<Genre>?>> call(NoParams noParams) async {
    return await repository.getGenres();
  }
}


