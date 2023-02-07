import 'package:flutter/material.dart';

class SongListScreen extends StatefulWidget {
  const SongListScreen({super.key});

  @override
  State<SongListScreen> createState() => _SongListScreenState();
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.75;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height / 2);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) => oldClipper != this;
}

class _SongListScreenState extends State<SongListScreen> {
  final double kDefault = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFF6EFE9),
                Color.fromRGBO(248, 213, 100, 1),
                Color.fromRGBO(146, 96, 188, 1),
                // Color(0xFFFACCCC),
              ],
              stops: [
                0.2,
                0.5,
                1.0
              ]),
        ),
        child: Column(
          children: [
            ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Container(
                padding: EdgeInsets.all(kDefault * 1.2),
                margin: EdgeInsets.symmetric(
                    horizontal: kDefault, vertical: kDefault),
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefault * 1.5),
                    topRight: Radius.circular(kDefault * 1.5),
                  ),
                  // BorderRadius.all(Radius.circular(kDefault * 3.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(kDefault * 0.5, kDefault * 0.5),
                    ),
                  ],
                  // border: const Border(
                  //     bottom: BorderSide(),
                  //     top: BorderSide(),
                  //     left: BorderSide(),
                  //     right: BorderSide()),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: const Text(
                            "Let's find Your maimai Song",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Helvetica"),
                          ),
                        ),
                        Image.asset(
                          "assets/images/mas.png",
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
