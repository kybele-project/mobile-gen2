import 'package:flutter/material.dart';
import 'package:kybele_gen2/nav/header.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';

class Document{
  String? doc_title;
  String? doc_path;
  int? page_num;
  Document(this.doc_title,this.doc_path,this.page_num);
  static List<Document> doc_List = [
    Document(
      "NRP Checklist", 
      "assets/NRPQuickEquipmentChecklist.pdf",
      1),
    Document(
      "A4 NRP Checklist", 
      "assets/A4 - NRP Checklist 27Oct2022.pdf",
      2),
    Document(
      "T-Piece Resuscitator for Lamination", 
      "assets/T-Piece resuscitator for lamination.pdf",
      4),
    Document(
      "Warmilu Thermal Gel Autoclave Instructions", 
      "assets/Warmilu_thermal gel autoclave instructions.pdf",
      1),
  ];
}

class RenderScreen extends StatefulWidget {
  RenderScreen(this.doc, {Key ? key}) : super(key: key);
  Document doc;
  @override
  State<RenderScreen> createState() => _RenderScreenState();
}
class _RenderScreenState extends State<RenderScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.doc.doc_title!)
      ),
      body: Container(child: SfPdfViewer.asset(
      widget.doc.doc_path!
       )
       ),
       
    );
  }
}

void _printExistingPdf() async {
    // import 'package:flutter/services.dart';
    final pdf = await rootBundle.load('assets/NRPQuickEquipmentChecklist.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }

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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 26),
              child:
            Expanded(
              child: SingleChildScrollView(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                   ElevatedButton(onPressed: () => _printExistingPdf(),child:Text("")),
                  Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("Additional Resources", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
                  ),
                  Column(children: Document.doc_List.map((doc) => ListTile(
                    onTap:() { Navigator.push(context, MaterialPageRoute(builder: (context) => RenderScreen(doc))); },
                    title: Text(doc.doc_title!, overflow: TextOverflow.ellipsis),
                    subtitle: Text("${doc.page_num!} Pages"),
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
            )
          ],
        ),
      ),
    );
  }

}