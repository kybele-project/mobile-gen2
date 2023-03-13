import 'package:flutter/material.dart';

class KybeleColorfulTile extends StatelessWidget {

  final Color bkgColor;
  final Color labelColor;
  final IconData icon;
  final String header;
  final Widget page;

  const KybeleColorfulTile(
      this.bkgColor,
      this.labelColor,
      this.icon,
      this.header,
      this.page,
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bkgColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          //border: Border.all(color: labelColor, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60, color: labelColor),
            const SizedBox(height: 20),
            Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: labelColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}