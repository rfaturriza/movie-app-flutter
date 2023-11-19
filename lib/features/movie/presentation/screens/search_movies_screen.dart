import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:test_xsis/core/utils/debouncer.dart';
import 'package:test_xsis/core/utils/extension/context_ext.dart';
import 'package:test_xsis/core/utils/extension/string_ext.dart';
import 'package:test_xsis/features/movie/domain/entities/movie.codegen.dart';
import 'package:test_xsis/features/movie/presentation/screens/detail_product_screen.dart';

import '../../../../core/components/search_box.dart';
import '../../../../core/network/dio_config.dart';
import '../../../../injection.dart';
import '../bloc/search_movie/search_movie_bloc.dart';

class SearchMoviesScreen extends StatelessWidget {
  const SearchMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchMovieBloc>(),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late final ScrollController _scrollController;
  final searchNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    searchNode.requestFocus();
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
        final bloc = context.watch<SearchMovieBloc>();
        bloc.add(SearchMovieEvent.searchProduct(
          query: bloc.state.search,
          page: bloc.state.page + 1,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.background,
        title: SearchBox(
          focusNode: searchNode,
          initialValue: emptyString,
          hintText: 'Search movie',
          onChanged: (val) {
            final bloc = BlocProvider.of<SearchMovieBloc>(context);
            bloc.add(SearchMovieEvent.searchProduct(
              query: val,
              page: 1,
            ));
          },
        ),
      ),
      body: BlocBuilder<SearchMovieBloc, SearchMovieState>(
        builder: (context, state) {
          final movies = state.movies;
          final count = () {
            if (state.status == FormzSubmissionStatus.inProgress) {
              return (movies?.length ?? 0) + 1;
            } else {
              return movies?.length ?? 0;
            }
          }();

          return RefreshIndicator(
            onRefresh: () {
              final bloc = BlocProvider.of<SearchMovieBloc>(context)
                ..add(SearchMovieEvent.searchProduct(
                  query: state.search,
                  page: 1,
                ));
              return bloc.stream.firstWhere(
                  (state) => state.status != FormzSubmissionStatus.inProgress);
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
                  movie: movies?[index],
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
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie? movie;
  final VoidCallback onTap;

  const _MovieCard({
    required this.movie,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl =
        NetworkConfig.baseImageUrl + (movie?.posterPath ?? emptyString);
    return Card(
      color: context.theme.colorScheme.background,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 100,
          height: 100,
        ),
        title: Text(
          movie?.title ?? emptyString,
          style: context.textTheme.titleLarge,
        ),
        subtitle: Text(movie?.overview ?? emptyString),
        trailing: Text(movie?.releaseDate ?? emptyString),
        onTap: onTap,
      ),
    );
  }
}
