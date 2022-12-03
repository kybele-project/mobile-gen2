import 'package:flutter/material.dart';

// dimensions scalar*10, scalar*8
class GhanaPinwheels extends CustomClipper<Path> {
  double topLeftHori;
  double topLeftVert;
  double scalar;

  GhanaPinwheels(this.topLeftHori, this.topLeftVert, this.scalar);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addPolygon([
      Offset(topLeftHori, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori, topLeftVert + scalar*4),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*5,topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert),
      Offset(topLeftHori + scalar*9,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*1),
      Offset(topLeftHori + scalar*8,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*2),
      Offset(topLeftHori + scalar*7,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*3),
      Offset(topLeftHori + scalar*6,topLeftVert + scalar*4),
    ], true);

    path.addPolygon([
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*5, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*1, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*2, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*3, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*4, topLeftVert + scalar*5),
    ], true);
    path.addPolygon([
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*4),
      Offset(topLeftHori + scalar*10, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*8),
      Offset(topLeftHori + scalar*9, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*7),
      Offset(topLeftHori + scalar*8, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*6),
      Offset(topLeftHori + scalar*7, topLeftVert + scalar*5),
      Offset(topLeftHori + scalar*6, topLeftVert + scalar*5),
    ], true);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


Path addGhanaPinwheel(double topLeftHori, double topLeftVert, scalar) {
  Path path = Path();
  path.addPolygon([
    Offset(topLeftHori, topLeftVert),
    Offset(topLeftHori + scalar*1, topLeftVert),
    Offset(topLeftHori + scalar*1, topLeftVert + scalar*1),
    Offset(topLeftHori + scalar*2, topLeftVert + scalar*1),
    Offset(topLeftHori + scalar*2, topLeftVert + scalar*2),
    Offset(topLeftHori + scalar*3, topLeftVert + scalar*2),
    Offset(topLeftHori + scalar*3, topLeftVert + scalar*3),
    Offset(topLeftHori + scalar*4, topLeftVert + scalar*3),
    Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
    Offset(topLeftHori, topLeftVert + scalar*4),
  ], true);
  path.addPolygon([
    Offset(topLeftHori + scalar*5,topLeftVert + scalar*4),
    Offset(topLeftHori + scalar*5,topLeftVert),
    Offset(topLeftHori + scalar*9,topLeftVert),
    Offset(topLeftHori + scalar*9,topLeftVert + scalar*1),
    Offset(topLeftHori + scalar*8,topLeftVert + scalar*1),
    Offset(topLeftHori + scalar*8,topLeftVert + scalar*2),
    Offset(topLeftHori + scalar*7,topLeftVert + scalar*2),
    Offset(topLeftHori + scalar*7,topLeftVert + scalar*3),
    Offset(topLeftHori + scalar*6,topLeftVert + scalar*3),
    Offset(topLeftHori + scalar*6,topLeftVert + scalar*4),
  ], true);

  path.addPolygon([
    Offset(topLeftHori + scalar*4, topLeftVert + scalar*4),
    Offset(topLeftHori + scalar*5, topLeftVert + scalar*4),
    Offset(topLeftHori + scalar*5, topLeftVert + scalar*8),
    Offset(topLeftHori + scalar*1, topLeftVert + scalar*8),
    Offset(topLeftHori + scalar*1, topLeftVert + scalar*7),
    Offset(topLeftHori + scalar*2, topLeftVert + scalar*7),
    Offset(topLeftHori + scalar*2, topLeftVert + scalar*6),
    Offset(topLeftHori + scalar*3, topLeftVert + scalar*6),
    Offset(topLeftHori + scalar*3, topLeftVert + scalar*5),
    Offset(topLeftHori + scalar*4, topLeftVert + scalar*5),
  ], true);
  path.addPolygon([
    Offset(topLeftHori + scalar*6, topLeftVert + scalar*4),
    Offset(topLeftHori + scalar*10, topLeftVert + scalar*4),
    Offset(topLeftHori + scalar*10, topLeftVert + scalar*8),
    Offset(topLeftHori + scalar*9, topLeftVert + scalar*8),
    Offset(topLeftHori + scalar*9, topLeftVert + scalar*7),
    Offset(topLeftHori + scalar*8, topLeftVert + scalar*7),
    Offset(topLeftHori + scalar*8, topLeftVert + scalar*6),
    Offset(topLeftHori + scalar*7, topLeftVert + scalar*6),
    Offset(topLeftHori + scalar*7, topLeftVert + scalar*5),
    Offset(topLeftHori + scalar*6, topLeftVert + scalar*5),
  ], true);

  return path;
}

class GhanaPinWheel extends CustomClipper<Path> {

  @override
  getClip(Size size) {
    Path patternpath = Path();
    patternpath.addPath(addGhanaPinwheel(0, 0, 10), Offset(0, 0));
    patternpath.addPath(addGhanaPinwheel(10, 0, 10), Offset(0, 0));
    patternpath.addPath(addGhanaPinwheel(20, 0, 10), Offset(0, 0));

    return patternpath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}