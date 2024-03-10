import 'package:flutter/material.dart';
import 'package:weather_app/Activity/home.dart';
import 'package:weather_app/Activity/loading.dart';
import 'package:weather_app/Activity/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() {
  runApp(MaterialApp(
    routes: {
        // await dotenv.load(fileName: ".env");

      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/loading': (context) => const Loading(),
    },
  ));
}
