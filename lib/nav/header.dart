import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xffeaeaea),
            width: 1,
          ))),
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
            child: Image.asset(
              'assets/kybele_logo_no_bg.png',
              height: 30,
            ),
          ),
          // Icon(Icons.person_rounded, size: 25),
        ],
      ),
    );
  }
}

class PopUpHeader extends StatelessWidget {
  final String title;
  final Icon icon;

  const PopUpHeader(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.width * .15,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xffeaeaea),
            width: 1,
          ))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                icon,
                const SizedBox(width: 20),
                Text(title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            IconButton(
                color: Colors.black,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: const Icon(Icons.close_rounded),
                onPressed: () => {
                      Navigator.of(context).pop(),
                    }),
          ],
        ),
    );
  }
}
