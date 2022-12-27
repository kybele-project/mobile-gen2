import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            PopUpHeader(
              'PDF Viewer',
              Icon(
                Icons.picture_as_pdf_rounded,
                color: Colors.deepOrangeAccent,
                size: 30,
              ),
            ),
            Expanded(
              // child: SingleChildScrollView()
              child: Center(child: Text("PDF Viewer code here"))
            )
          ],
        ),
      ),
    );
  }

}