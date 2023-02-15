import 'package:flutter/material.dart';
import '../screens/song_list_screen.dart';
import '../models/song.dart';

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    const minSize = 140.0;

    // when h = max = 280
    // h = 280, p1 = 210, p1Diff = 70
    // when h = min = 140
    // h = 140, p1 = 140, p1Diff = 0
    final p1Diff = ((minSize - size.height) * 0.5).truncate().abs();
    path.lineTo(0.0, size.height - p1Diff);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, minSize);

    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool visible = shrinkOffset < 50 ? true : false;
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.5;
    double topPadding = MediaQuery.of(context).padding.top + 16;

    return Stack(
      children: [
        // Background wave
        SizedBox(
          height: 240,
          child: ClipPath(
            clipper: BackgroundWaveClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 240,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(126, 236, 230, 1),
                      Colors.transparent,
                      // Color(0xFFFACCCC),
                    ],
                    stops: [
                      0.5,
                      1.0
                    ]),
                // color: Color.fromRGBO(126, 236, 230, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefault * 1.5),
                  topRight: Radius.circular(kDefault * 1.5),
                ),
              ),
            ),
          ),
        ),
        //Logo and Text
        Positioned(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(kDefault),
            child: AnimatedOpacity(
              opacity: visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        alignment: Alignment.bottomRight,
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: kDefault, left: kDefault),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: const Text(
                          "maimai DX International Version\nUn-official Song List",
                          style: TextStyle(
                            // fontSize: 20,
                            fontWeight: FontWeight.w500,
                            // fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        //SearchBar
        Positioned(
          top: topPadding + offset,
          left: 16,
          right: 16,
          child: SearchBar(
            controller: textController,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 240;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}

// ignore: must_be_immutable
class SearchBar extends StatefulWidget {
  SearchBar({super.key, required this.controller});

  TextEditingController controller;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: pink,
          focusedBorder: _border(pink),
          border: _border(grey),
          enabledBorder: _border(grey),
          hintText: 'Start song search',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          debugPrint("value change");
          setState(() {
            searchResult.clear();
            for (int i = 0; i < songCollection.length; i++) {
              Song currentSong = songCollection[i];
              if (currentSong.title
                  .toLowerCase()
                  .contains(value.toLowerCase())) {
                searchResult.add(currentSong);
              }
            }
            debugPrint(searchResult.length.toString());
          });
        },
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(12),
      );
}
