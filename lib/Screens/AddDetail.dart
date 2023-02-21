import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart' as a;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/Screens/ListOfPurpose.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';



String workstatus='Pending';
class AddDetail extends StatelessWidget {
  static const String _title = 'Insaf Trader';
  AddDetail({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(


        body: Details(),
      ),
    );
  }
}

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);
  @override
  State<Details> createState() => _Details();
}

class _Details extends State<Details> {

  TextEditingController customerNameController = TextEditingController();
  TextEditingController MobileNoController = TextEditingController();
  TextEditingController CnicNoController = TextEditingController();
  TextEditingController VehicleNoController = TextEditingController();
  TextEditingController RegCityController = TextEditingController();
  TextEditingController EngineNoController = TextEditingController();
  TextEditingController ChasisNoController = TextEditingController();
  TextEditingController ModelController = TextEditingController();
  TextEditingController MakeController = TextEditingController();




  String? gender;
  int? _groupValue = 3;

  @override
  Widget build(BuildContext context) {
    //Enter Detail for Customer
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text(
              'Enter Detail for Customer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: customerNameController,
                    decoration: InputDecoration(
                      labelText: 'Customer Name',
                      hintText: 'Enter Customer Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: MobileNoController,
                    decoration: InputDecoration(
                      labelText: 'Contact No',
                      hintText: 'Enter Phone No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp('[0-9-]')),
                    ],
                    controller: CnicNoController,
                    decoration: InputDecoration(
                      labelText: 'CNIC NO ',
                      hintText: 'Enter CNIC NO',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: VehicleNoController,
                    decoration: InputDecoration(
                      labelText: 'Vehicle No',
                      hintText: 'Enter Vehicle No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                  child: TextField(
                    controller: RegCityController,
                    decoration: InputDecoration(
                      labelText: 'Registration City',
                      hintText: 'Enter Vehicle Registration City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: EngineNoController,
                    decoration: InputDecoration(
                      labelText: 'Engine No',
                      hintText: 'Enter Engine No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                  child: TextField(
                    controller: ChasisNoController,
                    decoration: InputDecoration(
                      labelText: 'Chasis No',
                      hintText: 'Enter Chasis No',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextField(
                    controller: ModelController,
                    decoration: InputDecoration(
                      labelText: 'Model ',
                      hintText: 'Enter Model',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 50, 10),
                  child: TextField(
                    controller: MakeController,
                    decoration: InputDecoration(
                      labelText: 'Maker',
                      hintText: 'Enter Maker Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.009, 0, 0, 0),
                child: Text(
                  "Documents Status :",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.002, 0, 0, 0),
                child: ListTile(
                  title: Text('Received'),
                  leading: Radio<int>(
                    groupValue: _groupValue,
                    value: 1,
                    onChanged: (int? value) {
                      setState(() {
                        _groupValue = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.002, 0, 0, 0),
            child: ListTile(
              title: Text('Returned'),
              leading: Radio<int>(
                groupValue: _groupValue,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.002, 0, 0, 0),
            child: ListTile(
              title: Text('Not Received'),
              leading: Radio<int>(
                groupValue: _groupValue,
                value: 3,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
              ),
            ),
          ),
          Container(
              child: MaterialButton(
                child: Text('NEXT', style: TextStyle(color: Colors.white,fontSize: 20),),
            padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
            color: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {

              // List<Customer> customer = await customerDAO.getCustomer();
              // for(int j=0;j<customer.length;j++){
              //   print(customer[j].id);
              //   id=customer[j].id!;
              // }

              // if(customer.length==0 || customer==null){
              //   id=0;
              // }

              // id=id+1;
              var uuid = Uuid();
              String id=uuid.v4();
              print(customerNameController.text);
              print(_groupValue);
              print(id);
              //check all text editing controller is not empty
          if(customerNameController.text.isNotEmpty && MobileNoController.text.isNotEmpty && CnicNoController.text.isNotEmpty && VehicleNoController.text.isNotEmpty && RegCityController.text.isNotEmpty && EngineNoController.text.isNotEmpty && ChasisNoController.text.isNotEmpty && ModelController.text.isNotEmpty && MakeController.text.isNotEmpty && _groupValue != null){
              // customerDAO.insertCustomer(Customer(
              //     id: 1,
              //     CName: customerNameController.text,
              //     ContactNo: MobileNoController.text,
              //     CNIC: CnicNoController.text,
              //       EngineNo: EngineNoController.text,
              //       ChasisNo: ChasisNoController.text,
              //       Documents: _groupValue.toString(),
              //       Maker: MakeController.text,
              //       Model: ModelController.text,
              //       RCity: RegCityController.text,
              //       VehicleNo: VehicleNoController.text,
              //       WorkStatus: workstatus,
              //       ));

              // Firestore.instance.collection('Customer').add({
              //
              //   'id': id,
              //   'CName': customerNameController.text,
              //   'ContactNo': MobileNoController.text,
              //   'CNIC': CnicNoController.text,
              //   'EngineNo': EngineNoController.text,
              //   'ChasisNo': ChasisNoController.text,
              //   'Documents': _groupValue.toString(),
              //   'Maker': MakeController.text,
              //   'Model': ModelController.text,
              //   'RCity': RegCityController.text,
              //   'VehicleNo': VehicleNoController.text,
              //   'WorkStatus': workstatus,
              //
              // });
              //add object to firebase database sub collection of customer Invoice
              Firestore.instance.collection('Customer').document(id).update({
                'id': id,
                'CName': customerNameController.text,
                'ContactNo': MobileNoController.text,
                'CNIC': CnicNoController.text,
                'EngineNo': EngineNoController.text,
                'ChasisNo': ChasisNoController.text,
                'Documents': _groupValue.toString(),
                'Maker': MakeController.text,
                'Model': ModelController.text,
                'RCity': RegCityController.text,
                'VehicleNo': VehicleNoController.text,
                'WorkStatus': workstatus,

              });
              //add object to firebase database sub collection of customer Invoice




                    Navigator.push(
                    context,
                    MaterialPageRoute(

                        builder: (context) => ListOfPurpose(
                           id: id,
                        )),
                  );
                }
          else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('Please Fill All Details'),
    ));
    }
    }

    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //                 builder: (context) => ListOfPurpose(
    //
    //                     )),
    //
    // );

          )

          ),
        ],
      ),



    );
  }
}
