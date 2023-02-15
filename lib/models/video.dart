import 'package:flutter/material.dart';
import '../utilities/keys.dart';

const baseUrl =
    'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&key=$apiKey&q=';

class Video {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;

  Video({
    required this.id,
    required this.channelTitle,
    required this.thumbnailUrl,
    required this.title,
    required this.description,
  });
}

List<Video> convertJsontoVideo(json) {
  List<Video> stardardizedJson = [];
  debugPrint("converting Json to video");

  print(json.length);

  for (int index = 0; index != json.length; index++) {
    // print("Try");
    // print(index);
    Video addedVideo;
    // print("Adding video.");
    addedVideo = Video(
      id: json[index]["id"]["videoId"],
      channelTitle: json[index]["snippet"]["channelTitle"],
      description: json[index]["snippet"]["description"],
      thumbnailUrl: json[index]["snippet"]["thumbnails"]["high"]["url"],
      title: json[index]["snippet"]["title"],
    );
    // print("Video done");
    // print(index);
    // print(addedVideo.title);
    stardardizedJson.add(addedVideo);
  }
  // debugPrint(stardardizedJson.length.toString());

  return stardardizedJson;
}
