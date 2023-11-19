import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:test_xsis/features/movie/data/models/movie_request_model.codegen.dart';
import 'package:test_xsis/features/movie/domain/repositories/movie_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/movie.codegen.dart';
import '../entities/video_movie.codegen.dart';

@injectable
class GetVideosUseCase implements UseCase<List<VideoMovie>?, GetVideosParams> {
  final MovieRepository repository;

  GetVideosUseCase(this.repository);

  @override
  Future<Either<Failure, List<VideoMovie>?>> call(GetVideosParams params) async {
    return await repository.getVideos(params.movieId);
  }
}

class GetVideosParams extends Equatable {
  final int movieId;

  const GetVideosParams({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}
