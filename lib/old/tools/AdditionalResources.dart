import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

class Document{
  String? doc_title;
  String? doc_path;
  int? page_num;
  String? doc_date;
  Document(this.doc_title,this.doc_path,this.page_num, this.doc_date);
  static List<Document> doc_List = [
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
    Document(
      "T-Piece Resuscitator for Lamination", 
      "assets/T-Piece resuscitator for lamination.pdf",
      4,
      ""),
    Document(
      "Warmilu Thermal Gel Autoclave Instructions", 
      "assets/Warmilu_thermal gel autoclave instructions.pdf",
      1,
      ""),
  ];
}

class RenderScreen extends StatefulWidget {
  RenderScreen(this.doc_title, this.doc_path, {Key ? key}) : super(key: key);
  String doc_title;
  String doc_path;
  @override
  State<RenderScreen> createState() => _RenderScreenState();
}
class _RenderScreenState extends State<RenderScreen> {
  void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load(widget.doc_path);
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
          title: Text(widget.doc_title)
      ),
      body: Container(child: SfPdfViewer.asset(
          widget.doc_path
      )
      ),

    );
  }
}