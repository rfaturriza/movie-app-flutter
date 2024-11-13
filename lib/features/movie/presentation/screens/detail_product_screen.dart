import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_xsis/core/components/error_screen.dart';
import 'package:test_xsis/core/components/loading_screen.dart';
import 'package:test_xsis/core/network/dio_config.dart';
import 'package:test_xsis/core/utils/extension/context_ext.dart';
import 'package:test_xsis/core/utils/extension/string_ext.dart';
import 'package:test_xsis/features/movie/domain/entities/video_movie.codegen.dart';
import 'package:test_xsis/features/movie/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../injection.dart';

class DetailMovieScreen extends StatelessWidget {
  final int id;

  const DetailMovieScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DetailMovieBloc>()
        ..add(
          DetailMovieEvent.getMovie(id: id),
        )
        ..add(
          DetailMovieEvent.getVideo(id: id),
        ),
      child: _DetailMovieView(
        id: id,
      ),
    );
  }
}

class _DetailMovieView extends StatelessWidget {
  final int id;

  const _DetailMovieView({required this.id});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: context.theme.colorScheme.background,
      child: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state.status == FormzSubmissionStatus.inProgress) {
            return const LoadingScreen();
          } else if (state.status == FormzSubmissionStatus.failure) {
            return ErrorScreen(
              message: 'Error',
              onRefresh: () {
                context.read<DetailMovieBloc>().add(
                      DetailMovieEvent.getMovie(id: id),
                    );
              },
            );
          } else if (state.status == FormzSubmissionStatus.success) {
            return const _DetailMovie();
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class _DetailMovie extends StatelessWidget {
  const _DetailMovie();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _BackdropImage(),
        SizedBox(height: 8),
        _DetailMovieInfo(),
        SizedBox(height: 8),
        _TrailerMovie(),
      ],
    );
  }
}

class _BackdropImage extends StatelessWidget {
  const _BackdropImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        final backdropUrl = NetworkConfig.baseImageUrl +
            (state.movie?.backdropPath ?? emptyString);
        return Stack(
          children: [
            CachedNetworkImage(
              height: 200,
              width: double.infinity,
              imageUrl: backdropUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const LoadingScreen(),
              errorWidget: (context, url, error) =>
                  const ErrorScreen(message: 'Error'),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DetailMovieInfo extends StatelessWidget {
  const _DetailMovieInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        final movie = state.movie;
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${(movie?.title ?? '')} - (${movie?.popularity})',
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                movie?.releaseDate ?? '',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                movie?.originalLanguage ?? '',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  movie?.voteAverage.toString() ?? '',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.theme.colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                movie?.overview ?? '',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TrailerMovie extends StatelessWidget {
  const _TrailerMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailMovieBloc, DetailMovieState>(
      builder: (context, state) {
        if (state.videos == null || state.videos!.isEmpty) {
          return const SizedBox();
        }

        final id = state.videos
            ?.firstWhere(
              (e) => e.official == true && e.site == 'YouTube',
              orElse: () => const VideoMovie(),
            )
            .key;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: id ?? emptyString,
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: false,
            ),
          ],
        );
      },
    );
  }
}
