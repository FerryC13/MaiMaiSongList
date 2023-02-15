import 'package:flutter/material.dart';

const imageBaseUrl = 'https://maimaidx.jp/maimai-mobile/img/Music/';

class Song {
  final String artist;
  final String catAssetDirectory;
  final String imageUrl;
  final String basLvl;
  final String advLvl;
  final String expLvl;
  final String masLvl;
  String remaslvl;
  final String title;
  bool hasRemaster;

  Song({
    required this.artist,
    required this.catAssetDirectory,
    required this.imageUrl,
    required this.basLvl,
    required this.advLvl,
    required this.expLvl,
    required this.masLvl,
    required this.title,
    required this.hasRemaster,
    required this.remaslvl,
  });
}

// include svg for each category
String imageCategory(String category) {
  String categoryImageDirectory;

  switch (category) {
    //Chunithm
    case "オンゲキ＆CHUNITHM":
      {
        categoryImageDirectory = "assets/images/inner_gekichu.png";
      }
      break;
    //maimai
    case "maimai":
      {
        categoryImageDirectory = "assets/images/inner_maimai.png";
      }
      break;
    //popAnime
    case "POPS＆アニメ":
      {
        categoryImageDirectory = "assets/images/inner_pops_anime.png";
      }
      break;
    //GameVariety
    case "ゲーム＆バラエティ":
      {
        categoryImageDirectory = "assets/images/inner_variety.png";
      }
      break;
    //Niconico Vocaloid
    case "niconico＆ボーカロイド":
      {
        categoryImageDirectory = "assets/images/inner_niconico.png";
      }
      break;
    //toho project
    default:
      {
        categoryImageDirectory = "assets/images/inner_toho.png";
      }
      break;
  }

  return categoryImageDirectory;
}

// logic Json
List<Song> convertJson(json) {
  List<Song> stardardizedJson = [];
  debugPrint("converting Json to song");
  // print(json.length);

  for (int index = (json.length - 1); index != 0; index--) {
    Song addedSong;
    // form image url
    String imageURL = imageBaseUrl + json[index]["image_url"];

    // check version to see whether it is pre-dx version or after dx version
    if (int.parse(json[index]["version"]) < 20000) {
      addedSong = Song(
        artist: json[index]["artist"],
        catAssetDirectory: imageCategory(json[index]["catcode"]),
        imageUrl: imageURL,
        basLvl: json[index]["lev_bas"],
        advLvl: json[index]["lev_adv"],
        expLvl: json[index]["lev_exp"],
        masLvl: json[index]["lev_mas"],
        title: json[index]["title"],
        hasRemaster: false,
        remaslvl: "",
      );
      // check whether the song has a remaster
      if (json[index]["lev_remas"] == null) {
        addedSong.hasRemaster = false;
      } else {
        if (json[index]["lev_remas"].isEmpty) {
          addedSong.hasRemaster = false;
        } else {
          addedSong.hasRemaster = true;
          addedSong.remaslvl = json[index]["lev_remas"];
        }
      }
    } else {
      addedSong = Song(
        artist: json[index]["artist"],
        catAssetDirectory: imageCategory(json[index]["catcode"]),
        imageUrl: imageURL,
        basLvl: json[index]["dx_lev_bas"],
        advLvl: json[index]["dx_lev_adv"],
        expLvl: json[index]["dx_lev_exp"],
        masLvl: json[index]["dx_lev_mas"],
        title: json[index]["title"],
        hasRemaster: false,
        remaslvl: "",
      );
      // check whether the song has a remaster
      if (json[index]["dx_lev_remas"] == null) {
        addedSong.hasRemaster = false;
      } else {
        if (json[index]["dx_lev_remas"].isEmpty) {
          addedSong.hasRemaster = false;
        } else {
          addedSong.hasRemaster = true;
          addedSong.remaslvl = json[index]["dx_lev_remas"];
        }
      }
    }
    stardardizedJson.add(addedSong);
    // print(index);
    // print(addedSong.title);
  }
  // debugPrint(stardardizedJson.length.toString());

  return stardardizedJson;
}
