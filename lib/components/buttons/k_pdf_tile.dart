import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/media/pdf_page.dart';
import 'package:kybele_gen2/models/models.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';

class KPdfTile extends StatelessWidget {
  final Document document;
  final IconData icon;
  final Color bkgColor;
  final Color iconColor;

  const KPdfTile({
    super.key,
    required this.document,
    required this.icon,
    required this.bkgColor,
    required this.iconColor,
  });

  Future<Uint8List> loadPdfImageBytes(BuildContext context) async {
    // Get default asset bundle to use to access files
    final AssetBundle assetBundle = DefaultAssetBundle.of(context);

    // Access document byte data using default asset bundle
    final ByteData pdfByteData = await assetBundle.load(document.path);

    // Convert byte data into pdfx PdfDocument
    final ByteBuffer pdfByteBuffer = pdfByteData.buffer;
    PdfDocument doc = await PdfDocument.openData(
      pdfByteBuffer.asUint8List(
          pdfByteData.offsetInBytes, pdfByteData.lengthInBytes),
    );

    // Get formatted image bytes from PdfDocument
    final page = await doc.getPage(1);
    final Uint8List pageImageMemBytes =
        (await page.render(width: 850, height: 1100))!.bytes;
    return pageImageMemBytes;
  }

  Widget imageThumbnail(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          color: Colors.white,
          child: FutureBuilder<Uint8List>(
              future: loadPdfImageBytes(context),
              builder: (context, AsyncSnapshot<Uint8List> image) {
                return image.hasData
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(image.data!),
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      );
              }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => KPdfPage(
              document: document,
              icon: icon,
              iconColor: iconColor,
              bkgColor: bkgColor,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: imageThumbnail(context),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    document.title,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                  Text(
                    (document.length == 1)
                        ? "${document.length} page"
                        : "${document.length} pages",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
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
 */