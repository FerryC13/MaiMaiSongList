import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/body_video_list_widget.dart';
import '../utilities/keys.dart';
import '../models/video.dart';

List<Video> videoCollection = [];

const double kDefault2 = 10;
const videoListScreenRoute = "/VideoList";

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key, required this.songTitle});

  final String songTitle;

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  Future getVideoList() async {
    // var title = widget.songTitle;
    // print(apiKey);
    const baseUrl =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&type=video&key=$apiKey&q=maimai%20amakage%20';
    debugPrint("loading");
    final url = Uri.parse(baseUrl + widget.songTitle);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var videoJson = json.decode(utf8.decode(response.bodyBytes));
      // print(videoJson);
      debugPrint("Request success!");
      var itemList = videoJson["items"];
      videoCollection = convertJsontoVideo(itemList);
      // print("item list:");
      // print(itemList.length);
      // songCollection = convertJson(videoJson);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getVideoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const BodyVideoListWidget();
          }
        },
      ),
    );
  }
}
