import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import '../templates/page/page.dart';

class Document{
  String? docTitle;
  String? docPath;
  int? pageNum;
  String? docDate;
  Document(this.docTitle, this.docPath, this.pageNum, this.docDate,);
  static List<Document> docList = [
    Document(
      "NRP Checklist", 
      "assets/NRPQuickEquipmentChecklist.pdf",
      1,
      "13-07-2022"),
    Document(
      "A4 NRP Checklist", 
      "assets/A4 - NRP Checklist 27Oct2022.pdf",
      2,
      "27-10-2022"),
  ];
}

class RenderScreen extends StatefulWidget {

  final Document doc;

  const RenderScreen(this.doc, {Key ? key}) : super(key: key);

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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {_printExistingPdf();},
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
              Icons.print,
              size: 26.0,
            ),)
          )
        ],
        title: Text(widget.doc.docTitle!)
      ),
      body: SfPdfViewer.asset(
        widget.doc.docPath!
       ),
    );
  }
}

class PDFViewer extends StatelessWidget {
  const PDFViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(children: Document.docList.map((doc) => ListTile(
                    onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => RenderScreen(doc))); },
                    title: Text(doc.docTitle!, overflow: TextOverflow.ellipsis),
                    subtitle: Text("${doc.pageNum!} Pages"),
                    trailing: Text(doc.docDate!, style: const TextStyle(color: Colors.grey)),
                    leading: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 32,
                    )
                  )).toList()
                  )
                ]
              ))
            )
          ]);
  }

}

class FormsPages extends StatelessWidget {

  const FormsPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: PDFViewer(),
      headerText: "Forms",
      headerIcon: Icons.checklist_rtl_rounded,
      headerIconBkgColor: Color(0xffdaf7d9),
      headerIconColor: Color(0xff458e43),
    );
  }
}