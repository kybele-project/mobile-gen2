import 'package:flutter/material.dart';

class Header extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: Color(0xffeaeaea),
                width: 1,
              )
          )
      ),
      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
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
      padding: EdgeInsets.fromLTRB(30,15,30,15),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: Color(0xffeaeaea),
                width: 1,
              )
          )
      ),
      child: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 20),
                Text(
                    title,
                    style: TextStyle(
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
                }
            ),
          ],
        ),
      ),
    );
  }
}