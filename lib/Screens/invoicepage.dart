import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'invoicepage.dart';


late String id;
late Directory dir;
String idd = id.toString();
class InvoicePage extends StatefulWidget {
  String invoicei;
  Directory dir;
  InvoicePage({Key? key, required this.invoicei, required  this.dir}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {

  @override
  Widget build(BuildContext context) {
  dir = widget.dir;
    id= widget.invoicei;
   idd = id.toString();
    return Scaffold(
        bottomNavigationBar: BottomAppBar(

          child: Container(
            height: 70.0,
            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                FloatingActionButton(onPressed: () async {
                  //go to back page
                  Navigator.pop(context);
                },
                  child: Icon(Icons.arrow_back_ios_outlined),
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 20,
                    )),
                    fixedSize: MaterialStateProperty.all(Size(150, 50)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                  ),
                    onPressed: ()
                     async {
                       final dir = await getApplicationDocumentsDirectory();
                       //Print Existing Pdf from Assets
                       final pdf = File('${dir.path}/$idd.pdf');;
                      await Printing.layoutPdf(
                          onLayout: (PdfPageFormat format) async => pdf.readAsBytesSync());


                    }, child: Text("Print Invoice"),


                ),

              ],
            ),
          ),
          // bottomNavigationBar: BottomAppBar(
          //
          //   color: Colors.black,
          //   child: Balance(),
          // ),
        ),
      body: ShowInvoice(),


    );
  }




}


class ShowInvoice extends StatefulWidget {
  const ShowInvoice({Key? key}) : super(key: key);

  @override
  State<ShowInvoice> createState() => _ShowInvoiceState();
}

class _ShowInvoiceState extends State<ShowInvoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfPdfViewer.file(File('${dir.path}/$idd.pdf')),
    );
  }
}

