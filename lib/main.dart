import 'package:flutter/material.dart';
import 'package:flutter_movie_app/app.dart';
import 'package:flutter_movie_app/repositories/api/app_client.dart';
import 'package:flutter_movie_app/repositories/movie_repository.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  setupDI();
  runApp(const App());
}

void setupDI() {
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImp());
  getIt.registerSingleton<AppClient>(AppClientHttp());
}
