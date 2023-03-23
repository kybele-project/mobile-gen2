import 'package:flutter/material.dart';

class KWideButtonGradientLayer extends StatelessWidget {

  const KWideButtonGradientLayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 90,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x00ffffff),
              Color(0x99ffffff),
            ],
          ),
        ),
      ),
    );
  }
}