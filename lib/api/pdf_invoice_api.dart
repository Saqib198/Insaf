import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import '/api/pdf_api.dart';
import '/model/customer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../model/invoice.dart';
import '../model/supplier.dart';
import '../utils.dart';


class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    final SVGImage = await rootBundle.loadString('assets/images/saaf.svg');
    pdf.addPage(MultiPage(
      header: (context) {

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

          SvgImage(svg: SVGImage, width: 100, height: 100),
            buildSupplierAddress(invoice.supplier),
            Container(
              height: 50,
              width: 50,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: invoice.info.number,
              ),
            ),

          ]
        );
      },
      build: (context) => [
        buildHeader(invoice),
        SizedBox(height: 1 * PdfPageFormat.cm),

        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: invoice.info.number, pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),

            ],
          ),

          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     buildCustomerAddress(invoice.customer),
          //
          //   ],
          // ),
        ],
      );



  static Widget buildCustomerAddress(Customer customer)
  {
    final titles = <String>[
      'Name:',
      'Contact:',
      'Vehicle No:',
      'Model:',

    ];
    final data = <String>[
      customer.name,
      customer.contactNo,
      customer.vehicleNo,
      customer.model
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }
  // => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("Customer Detail", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
  //         Text("Name:       "+ customer.name),
  //         Text("Conatact:   "+ customer.contactNo),
  //         Text("Vehicle No: "+ customer.vehicleNo),
  //         Text("Model:      " +customer.model),
  //       ],
  //     );

  static Widget buildInvoiceInfo(InvoiceInfo info) {

    final titles = <String>[

      'Invoice Date:',

    ];
    final data = <String>[

      Utils.formatDate(info.date),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,

      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text("Opposite Bank Alfalah, near Madni Masjid,"),
          Text("Tank Ada, Dera Ismail Khan"),
        ],
      );


  static Widget buildTitle(Invoice invoice) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
      Text(
        'INVOICE',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,
      ),

    ],
  );
  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Description',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice;

      return [
        item.description,
        '\RS ${total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice)
        .reduce((item1, item2) => item1 + item2);
    final total = netTotal ;
    final double discount = invoice.Discount;
    final double Received = invoice.Received;
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Discount',
                  value: Utils.formatPrice(discount),
                  unite: true,
                ),
                buildText(
                  title: 'Received',
                  value: Utils.formatPrice(Received),
                  unite: true,
                ),

                Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total-discount-Received),
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Note: ', value: "THIS BILL CAN NOT CHALLENGE IN COURT OF LAW"),

          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Powered By: ', value: invoice.supplier.paymentInfo),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
