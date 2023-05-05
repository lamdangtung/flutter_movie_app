import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/main.dart';
import 'package:flutter_movie_app/models/load_status.dart';
import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/pages/movie/movie_viewmodel.dart';
import 'package:flutter_movie_app/repositories/api/app_api.dart';
import 'package:flutter_movie_app/repositories/movie_repository.dart';
import 'package:flutter_movie_app/repositories/movie_repository.dart';
import 'package:get/get.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> implements MovieViewModel {
  late Movie movie;
  LoadStatus loadStatus = LoadStatus.initial;
  late MovieViewModel vm;
  @override
  void initState() {
    super.initState();
    vm = this;
    vm.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    // if (loadStatus == LoadStatus.loading) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // } else
    if (loadStatus == LoadStatus.success || loadStatus == LoadStatus.loading) {
      return Hero(
        tag: "movie",
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CachedNetworkImage(
              fit: BoxFit.fitHeight,
              imageUrl: AppApi.baseImageURL + movie.posterPath,
            ),
          ),
        ),
      );
    } else if (LoadStatus.failed == LoadStatus.failed) {
      return const Center(
        child: Text("Error"),
      );
    } else {
      return const Center(
        child: Text("Movie Page"),
      );
    }
  }

  @override
  Future<void> init() async {
    int movieId = Get.arguments;
    try {
      setState(() {
        loadStatus = LoadStatus.loading;
      });
      final movieRepository = getIt<MovieRepository>();
      movie = await movieRepository.fetchMovieByMovieId(movieId);
      setState(() {
        loadStatus = LoadStatus.success;
      });
    } catch (e) {
      setState(() {
        loadStatus = LoadStatus.failed;
      });
      debugPrint(e.toString());
    }
  }
}
