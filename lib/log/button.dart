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


class KybeleColorfulButton extends StatelessWidget {

  final Color bkgColor;
  final Color labelColor;
  final IconData icon;
  final String header;
  final Widget page;

  const KybeleColorfulButton(
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

class KybeleButtonGradientLayer extends StatelessWidget {

  const KybeleButtonGradientLayer(
      {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x00ffffff),
              Color(0x88f5f5f5),
            ],
          ),
        ),
      ),
    );
  }
}

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


class KybelePDFTile extends StatelessWidget {

  final Color bkgColor = const Color(0xffdddddd);
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
              Icon(icon, size: 40, color: labelColor),
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


