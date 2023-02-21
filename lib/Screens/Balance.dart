import 'package:firedart/firedart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/Screens/ListOfPurpose.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../model/BalanceDetail.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';
import '../model/customer.dart' as cu;
import 'invoicepage.dart';

TextEditingController TotalController = TextEditingController();
TextEditingController ReceivedController = TextEditingController();
TextEditingController DiscountController = TextEditingController();

double tot = 0;
double rec = 0;
double dis = 0;
double balance = 0;
double rem=0;

late String CId;
late String CName;
late String Contact;
late String VehicleNo;
late String VehicleModel;
late String iidd;
late int invoiceid;
late final invoiceDAO;




class Balance extends StatefulWidget {
  String id;
  double total;
  String name;
  String contact;
  String vehicleno;
  String model;
  String iid;
  List<BillDetail> billDetails = [];
  Balance({Key? key, required this.id, required this.name,required this.contact,required this.vehicleno,
    required this.model, required this.total, required this.billDetails, required this.iid})
      : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  int Total = 0;


  @override
  Widget build(BuildContext context) {
     EasyLoading.dismiss();
    tot = widget.total;
    CId = widget.id;
    CName = widget.name;
    Contact = widget.contact;
    VehicleNo = widget.vehicleno;
    VehicleModel = widget.model;
    billDetailList = widget.billDetails;
    iidd=widget.iid;
    balance = tot;

    return Scaffold(
        appBar: AppBar(
          title: Text("Balance "),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                FloatingActionButton(onPressed: () {

                  //Go to back
                  Navigator.pop(context);
                },
                    child: Icon(Icons.arrow_back_ios_outlined),
                    backgroundColor: Colors.blue,
                ),
                ElevatedButton(

                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 20,

                      )),
                      fixedSize: MaterialStateProperty.all(Size(200, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                    ),

                  onPressed: ()
                     async {
                      final date = DateTime.now();
                   //   final dueDate = date.add(Duration(days: 7));
                      print(billDetailList.length);
                      final invoice = Invoice(
                        image: Image.asset('assets/images/logo.png'),
                        supplier: Supplier(
                          name: 'Insaf Traders and Motors',
                          address: 'Opposite Bank Alfalah, near Madni Masjid,'
                              ' Tank Ada, Dera Ismail Khan',
                          paymentInfo: 'SAQIB JAVED',
                        ),
                        customer: cu.Customer(
                          name: CName,
                          contactNo: Contact,
                          vehicleNo: VehicleNo,
                          model: VehicleModel,
                        ),
                        info: InvoiceInfo(
                          date: date,
                          number: iidd.toString(),
                        ),
                        items: [
                          for (int i = 0; i <   billDetailList.length; i++)
                            InvoiceItem(
                              description: billDetailList[i].description,
                              unitPrice: billDetailList[i].amount,
                            ),
                        ],
                        Received: rec,
                        Discount: dis,
                      );
                      rem=total-dis-rec;
                      // invoiceDAO.insertInvoice(
                      //   Invoicedetail(cId: cId, dat: date.toString(), total: total, discount: dis, received: rec, balance: rem)
                      // );
                      Firestore.instance.collection('Customer').document(cId).collection('Invoice').add({
                        'id': iidd,
                        'date': date.toString(),
                        'total': tot,
                        'discount': dis,
                        'received': rec,
                        'balance': rem,
                        'cId': CId,
                        'cName': CName,
                        'contact': Contact,
                        'vehicleNo': VehicleNo,
                        'vehicleModel': VehicleModel,
                       // 'billDetails': billDetailList,
                      });
                      final dir = await getApplicationDocumentsDirectory();
                      final pdfFile = await PdfInvoiceApi.generate(invoice);
                      PdfApi.openFile(pdfFile);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoicePage(invoicei: iidd,dir: dir),),
                      );
                    }, child: Text("Generat Invoice")),

              ],
            ),
          ),
          // bottomNavigationBar: BottomAppBar(
          //
          //   color: Colors.black,
          //   child: Balance(),
          // ),
        ),
        body: Row(children: <Widget>[
          Expanded(child: BottomWidget()),
        ]));
  }

  // Future<void> callList() async {
  //   tokenTaxList = await tokenTaxDAO.getAllTokenTax();
  // }
}


class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    TotalController.text = tot.toString();

    //double balance = double.parse(TotalController.text) - double.parse(DiscountController.text) - double.parse(ReceivedController.text) - double.parse(DiscountController.text);

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
                height: 200,
                width: 200,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Total",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("Discount",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("Received",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text("Balance",
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      verticalDirection: VerticalDirection.down,
                      children: [
                        Row(
                          children: [
                            Text(
                              TotalController.text.toString(),
                              style: TextStyle(
                                height: 1.8,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            //TextField for Discount
                            Expanded(
                              child: TextField(
                                controller: DiscountController,
                                keyboardType: TextInputType.numberWithOptions(),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.]')),
                                ],
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Discount',
                                ),
                                style: TextStyle(color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    //balance = double.parse(TotalController.text) - double.parse(DiscountController.text) - double.parse(ReceivedController.text) - double.parse(DiscountController.text);
                                    if (value.isNotEmpty) {
                                      dis = double.parse(value);
                                    } else {
                                      dis = 0;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            //TextField for Discount
                            Expanded(
                              child: TextField(
                                controller: ReceivedController,

                                keyboardType: TextInputType.numberWithOptions(),
                                inputFormatters: <TextInputFormatter>[
                                  // for below version 2 use this
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                  // for version 2 and greater you can also use this
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Received',
                                ),
                                style:
                                    TextStyle(height: 1.8, color: Colors.black),
                                onChanged: (value) {
                                  setState(() {
                                    //balance = double.parse(TotalController.text) - double.parse(DiscountController.text) - double.parse(ReceivedController.text) - double.parse(DiscountController.text);
                                    if (value.isNotEmpty) {
                                      rec = double.parse(value);
                                    } else {
                                      rec = 0;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(((balance - dis - rec).toString()),
                                style: TextStyle(
                                  height: 1.8,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
