import 'package:flutter/material.dart';
import '../screens/song_list_screen.dart';
import '../screens/video_list_screen.dart';

class RouteGenerator {
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("Page not found!"),
        ),
      );
    });
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case songScreenRoute:
        return MaterialPageRoute(builder: (context) => const SongListScreen());
      case videoListScreenRoute:
        return MaterialPageRoute(
          builder: (context) => VideoListScreen(
            songTitle: args.toString(),
          ),
        );
      default:
        return _errorRoute();
    }
  }
}
