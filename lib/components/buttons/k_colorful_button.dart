import 'package:flutter/cupertino.dart';

class KColorfulButton extends StatelessWidget {

  final Color bkgColor;
  final Color labelColor;
  final IconData icon;
  final String header;
  final Widget page;

  const KColorfulButton({
    required this.bkgColor,
    required this.labelColor,
    required this.icon,
    required this.header,
    required this.page,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
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
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: labelColor),
            const SizedBox(width: 15),
            Text(
              header,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}