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
          Icon(Icons.person_rounded, size: 25),
        ],
      ),
    );
  }
}