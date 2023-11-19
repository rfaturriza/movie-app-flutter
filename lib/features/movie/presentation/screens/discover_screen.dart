import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_xsis/core/components/search_box.dart';
import 'package:test_xsis/core/network/dio_config.dart';
import 'package:test_xsis/core/utils/debouncer.dart';
import 'package:test_xsis/core/utils/extension/context_ext.dart';
import 'package:test_xsis/core/utils/extension/string_ext.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';
import 'package:test_xsis/features/movie/presentation/bloc/discover_movie/discover_movie_bloc.dart';
import 'package:test_xsis/features/movie/presentation/screens/detail_product_screen.dart';
import 'package:test_xsis/features/movie/presentation/screens/search_movies_screen.dart';

import '../../../../injection.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DiscoverMovieBloc>()
        ..add(
          const DiscoverMovieEvent.getMovies(page: 1),
        )
        ..add(
          const DiscoverMovieEvent.getGenres(),
        ),
      child: const MoviesView(),
    );
  }
}

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      Debouncer(milliseconds: 500).run(() {
        final bloc = context.read<DiscoverMovieBloc>();
        bloc.add(DiscoverMovieEvent.getMovies(page: bloc.state.page + 1));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiscoverMovieBloc, DiscoverMovieState>(
      listener: (context, state) {
        if (state.statusMovie == FormzSubmissionStatus.failure) {
          context.showErrorToast(
            'Failed to load movies',
          );
        }
        if (state.statusGenre == FormzSubmissionStatus.failure) {
          context.showErrorToast(
            'Failed to load genres',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.theme.colorScheme.background,
          title: SearchBox(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchMoviesScreen(),
                ),
              );
            },
            readOnly: true,
            initialValue: emptyString,
            hintText: 'Search movie',
            onChanged: (val) {},
          ),
        ),
        body: BlocBuilder<DiscoverMovieBloc, DiscoverMovieState>(
          builder: (context, state) {
            final movies = state.movies;
            final count = () {
              if (state.statusMovie == FormzSubmissionStatus.inProgress) {
                return (movies?.length ?? 0) + 1;
              } else {
                return movies?.length ?? 0;
              }
            }();

            return RefreshIndicator(
              onRefresh: () {
                final bloc = BlocProvider.of<DiscoverMovieBloc>(context)
                  ..add(const DiscoverMovieEvent.getMovies(
                    page: 1,
                  ));
                return bloc.stream.firstWhere((state) =>
                    state.statusMovie != FormzSubmissionStatus.inProgress);
              },
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: count,
                itemBuilder: (context, index) {
                  if (index >= (movies?.length ?? 0)) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: LinearProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                  return _MovieCard(
                    movies: movies?[index],
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DetailMovieScreen(
                            id: movies?[index].id ?? 0,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie? movies;
  final VoidCallback onTap;

  const _MovieCard({
    required this.movies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        NetworkConfig.baseImageUrl + (movies?.posterPath ?? emptyString);
    return Card(
      color: context.theme.colorScheme.background,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imageUrl,
          height: 100,
          width: 100,
        ),
        title: Text(
          movies?.title ?? emptyString,
          style: context.textTheme.titleLarge,
        ),
        subtitle: Text(movies?.overview ?? emptyString),
        trailing: Text(movies?.releaseDate ?? emptyString),
        onTap: onTap,
      ),
    );
  }
}
