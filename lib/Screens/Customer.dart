import 'dart:ffi';

import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Models/Customer.dart';


class CustomerDetail extends StatefulWidget {
  CustomerDetail({Key? key}) : super(key: key);
  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  List<Customer> customerList = [];
  var list = [
    'Pending',
    'In Progress',
    'Completed',
  ];

  @override
  void initState() {
    EasyLoading.show(status: 'loading...');
    super.initState();
    dataget();
  }



  Future<void> showAlertDialog(BuildContext context, String? id) async {
    // set up the buttons
    String name = '';
    String engine = '';
    String chasis = '';
    String model = '';
    String maker = '';
    String document = '';
    String work = '';
    double total = 0.0;
    double Remaining = 0.0;
    double Discount = 0.0;

    await Firestore.instance.collection('Customer').document(id!).get().then((value) {
      name = value['CName'];
      engine = value['EngineNo'];
      chasis = value['ChasisNo'];
      model = value['Model'];
      maker = value['Maker'];
      document = value['Documents'];
      work = value['WorkStatus'];
      //total from invoice subcollection


    });

    await Firestore.instance.collection('Customer').document(id).collection('Invoice').get().then((value) {
      value.forEach((element) {
        total = element['total'];
        Remaining = element['balance'];
        Discount = element['discount'];
        print(total);
        print(Remaining);
        //Remaining = double.parse(total) - double.parse(element['Paid']);
      });
    });

    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Update"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      title: Text("Edit Detail"),

      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Customer Name: '),
                  SizedBox(width: 10),
                  Text(name),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Engine No: '),
                  SizedBox(width: 10),
                  Text(engine),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chasis No: '),
                  SizedBox(width: 10),
                  Text(chasis),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Model: '),
                  SizedBox(width: 10),
                  Text(model),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Maker: '),
                  SizedBox(width: 10),
                  Text(maker),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Documents: '),
                  SizedBox(width: 10),
                  Text(document),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Work Status: '),
                  SizedBox(width: 10),
                  //Drop down button for work status
                  Container(
                    width: 150,
                    child:  DropdownButtonFormField<String>(
                      value: work,
                      decoration: InputDecoration(labelText: 'Vehicle Type',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,

                      ),
                      items: ['Pending', 'In Progress', 'Completed']
                          .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          work = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: '),
                  SizedBox(width: 10),
                  Text(total.toString()),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Remaining: '),
                  SizedBox(width: 10),
                  Text(Remaining.toString()),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Received: '),

                  Expanded(
                    flex: 2,
                    child: TextField(

                      decoration: InputDecoration(
                        hintText: 'Enter Amount',

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        EasyLoading.dismiss();
        return alert;
      },
    );
  }


  void dataget() async {
    var data = await Firestore.instance.collection('Customer').get();
    customerList.clear();
    for (var i in data) {
      Customer customer = Customer(
        id: i['id'],
          CName: i['CName'],
          VehicleNo: i['VehicleNo'],
          ContactNo: i['ContactNo'],
          CNIC: i['CNIC'],
          RCity: i['RCity'],
          EngineNo: i['EngineNo'],
          ChasisNo: i['ChasisNo'],
          Model: i['Model'],
          Maker: i['Maker'],
          Documents: i['Documents'],
          WorkStatus: i['WorkStatus']);

      customerList.add(customer);
    }
    setState(() {
      EasyLoading.dismiss();
      customerList = customerList;
    });
  }

  Widget build(BuildContext context) {
    return new Container(
      height: 600,
      child: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Search Bar for Customer List

            Text('Customer Detail', style: TextStyle(fontSize: 20)),
            DataTable(
              columnSpacing: 130.0,
              dataRowHeight: 40.0,
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Customer Name',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Vehicle  Number',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mobile No',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Model',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Edit',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
              ],
              rows: customerList
                  .map<DataRow>((cu) => DataRow(cells: [
                DataCell(Text(
                  cu.CName.toString(),
                  style: TextStyle(fontSize: 16),
                )),
                DataCell(Text(cu.VehicleNo.toString())),
                DataCell(Text(cu.ContactNo.toString())),
                DataCell(Text(cu.Model.toString())),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      EasyLoading.show(status: 'Loading...');
                      print(cu.id);
                      showAlertDialog(context, cu.id);

                    },
                  ),
                ),
              ]))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
