// ignore_for_file: avoid_print, unused_element

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/song.dart';
import '../widgets/body_song_list_widget.dart';

const double kDefault = 10;
const basColor = Color(0xFF6ed43e);
const advColor = Color(0xFFf7b807);
const expColor = Color(0xFFff828d);
const masColor = Color(0xFFa051dc);
List<Song> searchResult = [];
List<Song> songCollection = [];
var textController = TextEditingController();
const songScreenRoute = "/SongList";

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  Future getSongData() async {
    print("loading");
    final url = Uri.parse("https://maimai.sega.jp/data/maimai_songs.json");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var songList = json.decode(utf8.decode(response.bodyBytes));
      debugPrint("Request success!");
      songCollection = convertJson(songList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getSongData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return BodySongListWidget(
              controller: textController,
            );
          }
        },
      ),
    );
  }
}
