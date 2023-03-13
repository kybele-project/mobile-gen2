import 'package:flutter/material.dart';

class KybeleSolidButton extends StatelessWidget {

  final String header;

  const KybeleSolidButton(
      this.header,
      {super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xff564BAF),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      child: Center(
        child: Text(
          header,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}