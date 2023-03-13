import 'package:flutter/material.dart';

class KybeleOutlineButton extends StatelessWidget {

  final String header;

  const KybeleOutlineButton(
      this.header,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2, color: const Color(0xff9F97E3))
      ),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      child: Center(
        child: Text(header,
          style: const TextStyle(
            color: Color(0xff9F97E3),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}