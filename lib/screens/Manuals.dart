import 'package:flutter/material.dart';
import 'package:kybele_gen2/components/timeline.dart';
import 'package:kybele_gen2/screens/APGAR3.dart';
import 'package:kybele_gen2/screens/TargetOxygenSaturation2.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

import '../components/button.dart';
import '../templates/page/page.dart';

class Document2{
  String? doc_title;
  String? doc_path;
  int? page_num;
  String? doc_date;

  Document2(this.doc_title,this.doc_path,this.page_num, this.doc_date);

  static List<Document2> doc_List = [
    Document2(
      "T-Piece Resuscitator for Lamination", 
      "assets/T-Piece resuscitator for lamination.pdf",
      4,
      ""),
    Document2(
      "Warmilu Thermal Gel Autoclave Instructions", 
      "assets/Warmilu_thermal gel autoclave instructions.pdf",
      1,
      ""),
  ];
}

class RenderScreen extends StatefulWidget {
  RenderScreen(this.doc, {Key ? key}) : super(key: key);
  Document2 doc;
  @override
  State<RenderScreen> createState() => _RenderScreenState();
}
class _RenderScreenState extends State<RenderScreen> {
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load(widget.doc.doc_path!);
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {_printExistingPdf();},
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
              Icons.print,
              size: 26.0,
            ),)
          )
        ],
        title: Text(widget.doc.doc_title!)
      ),
      body: Container(child: SfPdfViewer.asset(
        widget.doc.doc_path!
       )
       ),
       
    );
  }
}

class PDFViewer2 extends StatelessWidget {
  const PDFViewer2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child:

              SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(children: Document2.doc_List.map((doc) => ListTile(
                    onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => RenderScreen(doc))); },
                    title: Text(doc.doc_title!, overflow: TextOverflow.ellipsis),
                    subtitle: Text("${doc.page_num!} Pages"),
                    trailing: Text(doc.doc_date!, style: TextStyle(color: Colors.grey)),
                    leading: Icon(
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

class ManualsPages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return KybelePage.fixedWithHeader(
      hasHeaderClose: true,
      hasHeaderIcon: true,
      hasBottomActionButton: false,
      bodyWidget: PDFViewer2(),
      headerText: "Manuals",
      headerIcon: Icons.library_books_rounded,
      headerIconBkgColor: const Color(0xfff6f7d9),
      headerIconColor: const Color(0xff8d8e43),
    );
  }
}