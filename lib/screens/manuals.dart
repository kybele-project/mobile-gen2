import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import '../style/colors.dart';
import '../style/style.dart';
import '../templates/page/page.dart';

class Document2 {
  String? docTitle;
  String? docPath;
  int? pageNum;
  String? docDate;

  Document2(this.docTitle, this.docPath, this.pageNum, this.docDate);

  static List<Document2> docList = [
    Document2("T-Piece Resuscitator Device",
        "assets/T-Piece resuscitator for lamination.pdf", 4, ""),
    Document2("Warmilu Thermal Gel Autoclave Instructions",
        "assets/Warmilu_thermal gel autoclave instructions.pdf", 1, ""),
  ];
}

class RenderScreen extends StatefulWidget {
  final Document2 doc;

  const RenderScreen(this.doc, {Key? key}) : super(key: key);

  @override
  State<RenderScreen> createState() => _RenderScreenState();
}

class _RenderScreenState extends State<RenderScreen> {
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load(widget.doc.docPath!);
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          actions: [
            GestureDetector(
                onTap: () {
                  _printExistingPdf();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Icon(
                    Icons.share_rounded,
                    size: 26.0,
                  ),
                ))
          ],
          title: Text(widget.doc.docTitle!)),
      body: SfPdfViewer.asset(widget.doc.docPath!),
    );
  }
}

class PDFViewer2 extends StatelessWidget {
  const PDFViewer2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Column(
                    children: Document2.docList
                        .map((doc) => ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RenderScreen(doc)));
                            },
                            title: Text(doc.docTitle!,
                                maxLines: 2, overflow: TextOverflow.ellipsis),
                            subtitle:
                                Text("${doc.pageNum!} pages", maxLines: 2),
                            trailing: Text(doc.docDate!,
                                style: const TextStyle(color: Colors.grey)),
                            leading: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.red,
                              size: 32,
                            )))
                        .toList())
              ])))
    ]);
  }
}

class ManualsPages extends StatelessWidget {
  const ManualsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: const PDFViewer2(),
      headerText: "Educational Manuals",
      headerIcon: manualsIcon,
      headerIconBkgColor: manualsBkgColor,
      headerIconColor: manualsIconColor,
    );
  }
}
