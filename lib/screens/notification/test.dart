import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';

class Group1547Widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group1547Widget - GROUP
    return Container(
        width: 375,
        height: 810,
        child: Stack(children: <Widget>[
          Positioned(
              top: 0,
              left: 0,
              child: SvgPicture.asset('assets/images/rectangle635.svg',
                  semanticsLabel: 'rectangle635')),
          Positioned(
              top: 437,
              left: 64,
              child: Container(
                  width: 247,
                  height: 95,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 30,
                        child: Text(
                          'No Notifications Yet',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Merriweather',
                              fontSize: 20,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                    Positioned(
                        top: 38,
                        left: 0,
                        child: Text(
                          'The moment you start your journey,updates will start pouring in.Stay tuned for exciting alerts and updates.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(22, 29, 53, 1),
                              // fontFamily: 'Cabin',
                              fontSize: 14,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        )),
                  ]))),
          Positioned(
              top: 583,
              left: 35,
              child: Container(
                  width: 301.5107116699219,
                  height: 53,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 301.5107116699219,
                            height: 53,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(241, 246, 255, 1),
                                    offset: Offset(-3, 7),
                                    blurRadius: 13)
                              ],
                              color: Color.fromRGBO(73, 149, 235, 1),
                            ))),
                    Positioned(
                        top: 18,
                        left: 105.199951171875,
                        child: Text(
                          'Explore GiGs',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1),
                              // fontFamily: 'Hind Siliguri',
                              fontSize: 16,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.0625),
                        )),
                  ]))),
          Positioned(
              top: 29,
              left: 14,
              child: Container(
                  width: 24,
                  height: 24,
                  child: Stack(children: <Widget>[
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 255, 255, 1),
                            ))),
                    Positioned(
                        top: 5,
                        left: 8.5,
                        child: Container(
                            width: 7,
                            height: 14,
                            child: Stack(children: <Widget>[
                              Positioned(
                                  top: 0,
                                  left: 7,
                                  child: Transform.rotate(
                                    angle: -89.99999999999999 * (math.pi / 180),
                                    child: SvgPicture.asset(
                                        'assets/images/stroke1.svg',
                                        semanticsLabel: 'stroke1'),
                                  )),
                            ]))),
                  ]))),
        ]));
  }
}
