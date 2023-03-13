import 'package:flutter/material.dart';

class KybelePDFTile extends StatelessWidget {

  final Color bkgColor = const Color(0xfffafafa); //Color(0xffdddddd);
  final Color labelColor = const Color(0xff444444);
  final IconData icon = Icons.picture_as_pdf_rounded;
  final String header;
  final Widget page;

  const KybelePDFTile(
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
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bkgColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 40, color: Colors.red),//labelColor),
            const SizedBox(width: 20),
            Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: labelColor,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}