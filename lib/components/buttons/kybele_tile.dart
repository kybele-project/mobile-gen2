import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:kybele_gen2/style/style.dart';

class KybeleTile extends StatelessWidget {

  final Color bkgColor;
  final Color labelColor;
  final IconData iconData;
  final String header;
  final Widget page;

  const KybeleTile({
    super.key,
    required this.bkgColor,
    required this.labelColor,
    required this.iconData,
    required this.header,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
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
            Icon(iconData, size: 60, color: labelColor),
            const SizedBox(height: 20),
            Text(
              header,
              style: homeLabelTextStyle.merge(TextStyle(color: labelColor, fontSize: 18)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
