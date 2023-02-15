// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
// import '../screens/song_list_screen.dart';
import '../screens/video_list_screen.dart';
import '../models/video.dart';

class BodyVideoListWidget extends StatefulWidget {
  const BodyVideoListWidget({super.key});

  // TextEditingController controller;

  @override
  State<BodyVideoListWidget> createState() => _BodyVideoListWidgetState();
}

class _BodyVideoListWidgetState extends State<BodyVideoListWidget> {
  bool _showBacktoTopButton = false;
  var _scrollController = ScrollController();
  // bool _isSearching = false;
  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          // debugPrint("Scrolling");
          if (_scrollController.offset >= 400) {
            _showBacktoTopButton = true; // show the back-to-top button
          } else {
            _showBacktoTopButton = false; // hide the back-to-top button
          }
          // print(_showBacktoTopButton);
        });
      });
    super.initState();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // print(songCollection);
    return Stack(
      children: [
        // background container
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(126, 236, 230, 1),
                  Color.fromARGB(255, 248, 243, 100),
                  Color.fromRGBO(146, 96, 188, 1),
                  // Color(0xFFFACCCC),
                ],
                stops: [
                  0.2,
                  0.4,
                  1.0
                ]),
          ),
        ),
        // appBar and ListView
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverPersistentHeader(
            //   delegate: SliverSearchAppBar(),
            //   // Set this param so that it won't go off the screen when scrolling
            //   pinned: true,
            // ),
            defaultList(videoCollection)
          ],
        ),
        Positioned(
          right: -140,
          bottom: 0,
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(kDefault2),
            child: AnimatedOpacity(
              opacity: _showBacktoTopButton ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IconButton(
                icon: Image.asset("assets/images/top.png"),
                onPressed: _scrollToTop,
              ),
            ),
          ),
        ),
      ],
    );
  }

  SliverList defaultList(List<Video> videoList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(3),
          padding: const EdgeInsets.all(12),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(kDefault2),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                // big thumbnail
                Container(
                  margin: const EdgeInsets.symmetric(vertical: kDefault2 * 0.5),
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefault2 * 0.5),
                  alignment: Alignment.centerLeft,
                  child: Image.network(
                    videoList[index].thumbnailUrl,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.25,
                    //   child: Image.network(videoList[index].thumbnailUrl),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefault2 * 0.5),
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              videoList[index].title,
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                                fontSize: 1,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefault2 * 0.5),
                          height: 20.0,
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 1.0, bottom: 1.0),
                              height: 1.0,
                              color: Colors.black12,
                            ),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: kDefault2 * 0.5),
                          child: Text(
                            "ARTIST",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefault2 * 0.5),
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Text(
                            videoList[index].channelTitle,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: kDefault * 0.5),
                //   child: Row(
                //     children: [
                //       levelBox(context, videoList[index].basLvl, basColor),
                //       levelBox(context, videoList[index].advLvl, advColor),
                //       levelBox(context, videoList[index].expLvl, expColor),
                //       levelBox(context, videoList[index].masLvl, masColor),
                //       videoList[index].hasRemaster
                //           ? (Container(
                //               width: MediaQuery.of(context).size.width * 0.15,
                //               decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(kDefault),
                //                   border:
                //                       Border.all(color: masColor, width: 2)),
                //               padding: const EdgeInsets.all(kDefault * 0.70),
                //               margin: const EdgeInsets.all(kDefault * 0.20),
                //               child: Text(
                //                 videoList[index].remaslvl,
                //                 textAlign: TextAlign.center,
                //                 style: const TextStyle(
                //                     color: masColor,
                //                     fontSize: 22,
                //                     fontWeight: FontWeight.w700),
                //               ),
                //             ))
                //           : const SizedBox(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      }, childCount: videoList.length),
    );
  }

  Container levelBox(BuildContext context, String level, Color bgColor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.15,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(kDefault2)),
      padding: const EdgeInsets.all(kDefault2 * 0.70),
      margin: const EdgeInsets.all(kDefault2 * 0.20),
      child: Text(
        level,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
      ),
    );
  }
}
