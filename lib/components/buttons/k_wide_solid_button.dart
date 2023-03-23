import 'package:flutter/material.dart';
import 'package:kybele_gen2/style/style.dart';

class KWideSolidButton extends StatelessWidget {
  final String label;

  const KWideSolidButton({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainDarkPurple,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      child: Center(
        child: Text(
          label,
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
