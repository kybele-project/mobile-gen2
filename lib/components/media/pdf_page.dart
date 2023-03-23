import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kybele_gen2/components/buttons/buttons.dart' show KLargeButton;
import 'package:kybele_gen2/components/scaffold/scaffold.dart' show KScaffold;
import 'package:kybele_gen2/models/models.dart' show Document;
import 'package:kybele_gen2/style/style.dart';

import 'package:path_provider/path_provider.dart' show getTemporaryDirectory;
import 'package:share_plus/share_plus.dart' show Share, XFile;
import 'package:pdfx/pdfx.dart';

class KPdfPage extends StatefulWidget {
  final Document document;
  final IconData icon;
  final Color bkgColor;
  final Color iconColor;

  const KPdfPage({
    super.key,
    required this.document,
    required this.icon,
    required this.bkgColor,
    required this.iconColor,
  });

  @override
  State<KPdfPage> createState() => KPdfPageState();
}

class KPdfPageState extends State<KPdfPage> {
  void shareFile() async {
    // Access document byte data using default asset bundle
    final ByteData pdfByteData = await rootBundle.load(widget.document.path);

    // Convert byte data into pdfx PdfDocument
    final ByteBuffer pdfByteBuffer = pdfByteData.buffer;
    final Uint8List pdfByteList = pdfByteBuffer.asUint8List(
        pdfByteData.offsetInBytes, pdfByteData.lengthInBytes);

    // Write to temporary file
    final tempDir = await getTemporaryDirectory();
    final String filename = (widget.document.path).split('/')[2];
    final File file = await File('${tempDir.path}/$filename').create();
    file.writeAsBytes(pdfByteList);

    // Convert File to XFile
    final XFile xFile = XFile(file.path);

    // Share
    Share.shareXFiles([xFile]);
  }

  Widget body(BuildContext context) {
    final pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.document.path),
    );

    return Expanded(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          PdfViewPinch(
            controller: pdfController,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
            child: KLargeButton(
              actionFunction: shareFile,
              iconData: Icons.share_rounded,
              label: "SHARE",
              color: mainDarkPurple,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KScaffold.fixedWithHeader(
      hasHeaderIcon: true,
      hasHeaderClose: true,
      hasBottomActionButton: false,
      headerText: widget.document.title,
      headerIcon: widget.icon,
      headerIconBkgColor: widget.bkgColor,
      headerIconColor: widget.iconColor,
      bodyWidget: body(context),
    );
  }
}
