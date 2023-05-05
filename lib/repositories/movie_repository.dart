import 'package:flutter/material.dart';
import 'package:flutter_movie_app/main.dart';
import 'package:flutter_movie_app/models/movie.dart';
import 'package:flutter_movie_app/repositories/api/app_api.dart';
import 'package:flutter_movie_app/repositories/api/app_client.dart';

import 'package:http/http.dart' as http;

abstract class MovieRepository {
  Future<List<Movie>> fetchPopularMovies();

  Future<List<Movie>> fetchUpcomingMovies();

  Future<Movie> fetchMovieByMovieId(int movieId);
}

class MovieRepositoryImp implements MovieRepository {
  @override
  Future<List<Movie>> fetchPopularMovies() async {
    try {
      const url = AppApi.baseURl + AppApi.moviePath + AppApi.popularPath;
      final res = await getIt<AppClient>().get(url);
      return List.from(
          (res[AppApi.resultsKey] as List).map((e) => Movie.fromJson(e)));
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Movie>> fetchUpcomingMovies() async {
    try {
      const url = AppApi.baseURl + AppApi.moviePath + AppApi.upcomingPath;
      final res = await getIt<AppClient>().get(url);
      return List.from(
          (res[AppApi.resultsKey] as List).map((e) => Movie.fromJson(e)));
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Movie> fetchMovieByMovieId(int movieId) async {
    try {
      final url = AppApi.baseURl + AppApi.moviePath + "/$movieId";
      final res = await getIt<AppClient>().get(url);
      return Movie.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
