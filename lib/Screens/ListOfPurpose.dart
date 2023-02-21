import 'package:csc_picker/csc_picker.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../model/BalanceDetail.dart';
import 'Balance.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

late String invoiceid='';
double total=0;
String Name='';
String Contact='';
String VehicleNo='';
String VehicleModel='';
int chkforempty=0;
//List for checking purpose
List list = new List.filled(11, null, growable: false);
List<BillDetail> billDetailList = [];

//Text editing controller for New Registration
TextEditingController nrType = TextEditingController();
TextEditingController nrAmount = TextEditingController();

//Text editing controller for Token Tax
TextEditingController ttFromcontroller = TextEditingController();
TextEditingController ttTocontroller = TextEditingController();
TextEditingController ttPaymentMethod = TextEditingController();
TextEditingController ttTransactionId = TextEditingController();
TextEditingController ttAmount = TextEditingController();
TextEditingController ttState = TextEditingController();
TextEditingController ttCity = TextEditingController();

//int ttAmount=0;

//Text editing controller for Transfer of Owner
TextEditingController tosPreviousName = TextEditingController();
TextEditingController tosNewName = TextEditingController();
TextEditingController tosNewCNIC = TextEditingController();
TextEditingController tosAmount = TextEditingController();

//Text editing controller for Route Permit
TextEditingController rpFrom = TextEditingController();
TextEditingController rpTO = TextEditingController();
TextEditingController rpAmount = TextEditingController();



//Text editing controller for Number Plate
TextEditingController npAmount = TextEditingController();

//Text editing controller for FIR CHECKING
TextEditingController fircDate = TextEditingController();
TextEditingController fircRemarks = TextEditingController();

//Text editing controller for Insurance
TextEditingController insAmount = TextEditingController();

//Text editing controller for CPLC Verification
TextEditingController cplcExciseRemarks = TextEditingController();

//Text editing controller for counter signature region
TextEditingController csrState = TextEditingController();
TextEditingController csrCity = TextEditingController();
TextEditingController csrAmount = TextEditingController();

//Text editing controller for Duplicate Book/Smart Card Issuance
TextEditingController dbscAmount = TextEditingController();

//Text editing controller for Fitness Certificate
TextEditingController fcAmount = TextEditingController();

var dbscSelected = 'Duplicate Book';
//var for Counter Signature Region
String? CSRcountryValue = "";
String? CSRstateValue = "";
String? CSRcityValue = "";

//Var for Fitness Certificate
String? FCcountryValue = "";
String? FCstateValue = "";
String? FCcityValue = "";

var npStatus = 'First Time';
var cplcSelected = 'Not Clear';
var nrSelected = 'Local';

String cId='';

class ListOfPurpose extends StatefulWidget {
  String id;
  ListOfPurpose({
    Key? key,
     required this.id,
  }) : super(key: key);

  @override
  State<ListOfPurpose> createState() => _ListOfPurposeState();
}

class _ListOfPurposeState extends State<ListOfPurpose> {
  late int _counter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cId=widget.id;
    _counter = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,

        automaticallyImplyLeading: false,
        actions: [

          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.blue,
            ),
            onPressed: () async {
              setState(
                () {
                  _counter++;
                },
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.blue,
            ),
            onPressed: () async {
              setState(
                () {
                  _counter = 0;
                  for (int i = 0; i < list.length; i++) {
                    list[i] = null;
                  }
                },
              );
            },
          )
        ],
      ),
      body: Scaffold(
        body: Column(
          children: [
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _counter,
                itemBuilder: (context, index) {
                  return row(index);
                },
              ),
            ),

            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   height: 100,
            //   child: Balance(),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              FloatingActionButton(onPressed: (){
                Navigator.pop(context);
              }
              ,child: Icon(Icons.arrow_back_ios_sharp)
              ),
              NextButton(),
            ],
          ),
          // child: Row(
          //
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //
          //     //icon buttom for back
          //     FloatingActionButton(
          //       onPressed:(){ Navigator.pop(context);
          //       },
          //       child: new Icon(Icons.navigate_before),
          //     ),
          //     //Floating Button For next
          // FloatingActionButton(
          //         onPressed:(){ Navigator.pop(context);
          //         },
          //
          //         child: new Icon(Icons.navigate_next),
          //       ),
          //
          //   ],
          // ),
        ),
        // bottomNavigationBar: BottomAppBar(
        //
        //   color: Colors.black,
        //   child: Balance(),
        // ),
      ),
      //Balance container in Bottom Navigation Bar
    );
  }
}

row(int index) {
  return Row(
    children: [
      //Text('id: $index'),
      SizedBox(width: 30),
      Expanded(child: AddPurpose(ind: index)),
    ],
  );
}

class AddPurpose extends StatefulWidget {
  int? ind;
  AddPurpose({Key? key, this.ind}) : super(key: key);
  @override
  State<AddPurpose> createState() => _AddPurposeState();
}

class _AddPurposeState extends State<AddPurpose> {
  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String address = "";

  //List for checking dropDownValue

  String? dropdownvalue = 'Select Purpose';

  var items = [
    'Select Purpose',
    'New Registration',
    'Token Tax',
    'Transfer of Ownership of Vehicle',
    'Route Permit',
    'Fitness Certificate',
    'FIR Checking',
    'Insurance',
    'Number Plate Fee',
    'Counter Signature Region',
    'CPLC Verification',
    'Duplicate Book/Smart Card Issuance',
  ];

  //List and var for New Registration

  var nrlist = [
    'Local',
    'Imported',
    'Auctioned',
  ];

  //List and var for Token Tax
  var dbsclist = [
    'Duplicate Book',
    'Smart Card',
  ];
  var dbscSelected = 'Duplicate Book';
  //List and var for Number Plate
  final List<String> npItems = [
    'First Time',
    'Duplicate',
  ];

  //List and var for CPLC Verification
  final List<String> cplcItems = [
    'Not Clear',
    'Clear',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 30, 0),
      child: Column(
        children: [
          DropdownButtonFormField(
              isExpanded: true,
              // Initial Value
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              borderRadius: BorderRadius.circular(18),
              focusColor: Colors.white10,
              autofocus: true,
              // disabledHint: 'Select Purpose',
              focusNode: FocusNode(canRequestFocus: true),
              dropdownColor: Colors.white,
              // Array list of items

              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(
                  () {
                    dropdownvalue = newValue;

                    int i = widget.ind!;
                    print(i);
                    list[i] = dropdownvalue.toString();
                    // list.add=dropdownvalue.toString() as int;
                    //list.add(dropdownvalue.toString());
                    print(list);
                  },
                );
              }),

          //New Registration
          Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: dropdownvalue == 'New Registration'
                  ? Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                  value: nrSelected,

                                  // Down Arrow Icon
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                  borderRadius: BorderRadius.circular(18),
                                  focusColor: Colors.white10,
                                  autofocus: true,
                                  // disabledHint: 'Select Purpose',
                                  focusNode: FocusNode(canRequestFocus: true),
                                  dropdownColor: Colors.white,
                                  // Array list of items

                                  // Array list of items
                                  items: nrlist.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      nrSelected = newValue!;
                                    });
                                  },
                                )),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 15, 0),
                            child: TextField(
                              controller: nrAmount,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              decoration: InputDecoration(
                                //icon: Icon(Icons.attach_money),
                                labelText: 'Enter Amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : null),

          //Token Tax
          Container(
            child: dropdownvalue == 'Token Tax'
                ? (Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                'Paid From: ',
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              //width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(50, 0, 21, 0),
                              child: TextField(
                                controller: ttFromcontroller,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Enter Date", //label text of field
                                  border: OutlineInputBorder(),
                                ),

                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now(),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      ttFromcontroller.text =
                                          formattedDate; //// set output date to TextField value;
                                    });
                                  } else {}
                                },
                              ),
                            )),
                        Expanded(
                          flex: 0,
                          child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(0, 0, 26, 0),
                              child: Text(
                                'Paid To: ',
                                style: TextStyle(fontSize: 18),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            // width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.fromLTRB(24, 0, 38, 0),
                            child: TextField(
                              controller: ttTocontroller,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText: "Enter Date", //label text of field
                                border: OutlineInputBorder(),
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now(),
                                    lastDate: DateTime(2100));
                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy').format(
                                          pickedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    ttTocontroller.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                : null,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
              alignment: Alignment.topLeft,
              child: dropdownvalue == 'Token Tax'
                  ? (Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            child: Text(
                              'Payment Method: ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(3, 0, 11, 0),
                            child: TextField(
                              controller: ttPaymentMethod,
                              decoration: InputDecoration(
                                icon: Icon(Icons.payment),
                                labelText: 'e.g: EasyPaisa,JazzCash,etc',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                            child: Text(
                              "Transaction ID: ",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 9, 0),
                            child: TextField(
                              controller: ttTransactionId,
                              decoration: InputDecoration(
                                icon: Icon(Icons.numbers_sharp),
                                labelText: 'e.g: 123456789',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  : null),
          Container(
              padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
              alignment: Alignment.topLeft,
              child: dropdownvalue == 'Token Tax'
                  ? (Row(
                      children: [
                        Expanded(
                          flex: 0,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              'Enter Amount: ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(29, 10,
                                MediaQuery.of(context).size.width * 0.46, 0),
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              controller: ttAmount,
                              decoration: InputDecoration(
                                icon: Icon(Icons.attach_money),
                                labelText: 'RS',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  : null),
          Container(
            child: dropdownvalue == 'Token Tax'
                ? (CSCPicker(
                    showStates: true,
                    showCities: true,
                defaultCountry: CscCountry.Pakistan,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value;
                        ttState.text = stateValue.toString();
                      });
                    },
                    onCityChanged: (value) {
                      setState(() {
                        cityValue = value;
                        ttCity.text = cityValue.toString();
                        print(ttCity.text);
                      });
                    },
                  )

            )
                : null,
          ),

          //Transfer Of Owner
          Container(
            child: dropdownvalue == 'Transfer of Ownership of Vehicle'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextField(
                            controller: tosPreviousName,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'Previous Owner Name ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextField(
                            controller: tosNewName,
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: 'New Owner Name ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
              alignment: Alignment.topLeft,
              child: dropdownvalue == 'Transfer of Ownership of Vehicle'
                  ? (Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextField(
                              controller: tosNewCNIC,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9-]')),
                              ],
                              decoration: InputDecoration(
                                icon: Icon(Icons.numbers_outlined),
                                labelText: 'Cnic No ',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextField(
                              controller: tosAmount,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9.,]')),
                              ],
                              decoration: InputDecoration(
                                icon: Icon(Icons.attach_money),
                                labelText: 'Enter Amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  : null),

          //Router Permit
          Container(
            child: dropdownvalue == 'Route Permit'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextField(
                            controller: rpFrom,
                            decoration: InputDecoration(
                              icon: Icon(Icons.location_on),
                              labelText: 'From ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextField(
                            controller: rpTO,
                            decoration: InputDecoration(
                              icon: Icon(Icons.double_arrow_sharp),
                              labelText: 'To ',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
          Container(
              padding: EdgeInsets.fromLTRB(0, 7, 30, 0),
              alignment: Alignment.topLeft,
              child: dropdownvalue == 'Route Permit'
                  ? (Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0,
                                MediaQuery.of(context).size.width * 0.46, 0),
                            child: TextField(
                              controller: rpAmount,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9,.]')),
                              ],
                              decoration: InputDecoration(
                                icon: Icon(Icons.attach_money),
                                labelText: 'Enter Amount',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                  : null),

          //Number Plate Fee
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
            alignment: Alignment.topLeft,
            child: dropdownvalue == 'Number Plate Fee'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              value: npStatus,

                              // Down Arrow Icon
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              focusColor: Colors.white10,
                              autofocus: true,
                              // disabledHint: 'Select Purpose',
                              focusNode: FocusNode(canRequestFocus: true),
                              dropdownColor: Colors.white,
                              // Array list of items

                              // Array list of items
                              items: npItems.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  npStatus = newValue!;
                                });
                              },
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0,
                              MediaQuery.of(context).size.width * 0.45, 0),
                          child: TextField(
                            controller: npAmount,
                            keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9.,]')),
                              // for version 2 and greater you can also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          //FIR CHECKING
          Container(
            child: dropdownvalue == 'FIR Checking'
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              //width: MediaQuery.of(context).size.width * 0.25,
                              padding: EdgeInsets.fromLTRB(0, 0, 21, 0),
                              child: TextField(
                                controller: fircDate,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  icon: Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: "Enter Date", //label text of field
                                  border: OutlineInputBorder(),
                                ),

                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now(),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      fircDate.text =
                                          formattedDate; //// set output date to TextField value;
                                    });
                                  } else {}
                                },
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                                child: TextField(
                              controller: fircRemarks,
                              decoration: InputDecoration(
                                icon: Icon(Icons.fact_check_outlined),
                                labelText: 'Enter Remarks ',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 5, // <-- SEE HERE
                              minLines: 1,
                            ))),
                      ],
                    ),
                  )
                : null,
          ),

          //Insurance
          Container(
            child: dropdownvalue == 'Insurance'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0,
                              MediaQuery.of(context).size.width * 0.46, 0),
                          child: TextField(
                            controller: insAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              // for version 2 and greater you can also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              icon: Icon(Icons.attach_money),
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          //CPLC Verification
          Container(
            padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
            alignment: Alignment.topLeft,
            child: dropdownvalue == 'CPLC Verification'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              value: cplcSelected,

                              // Down Arrow Icon
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              focusColor: Colors.white10,
                              autofocus: true,
                              // disabledHint: 'Select Purpose',
                              focusNode: FocusNode(canRequestFocus: true),
                              dropdownColor: Colors.white,
                              // Array list of items

                              // Array list of items
                              items: cplcItems.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  cplcSelected = newValue!;
                                });
                              },
                            )),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, MediaQuery.of(context).size.width * 0, 0),
                          child: TextField(
                            controller: cplcExciseRemarks,
                            decoration: InputDecoration(
                              icon: Icon(Icons.checklist_rounded),
                              labelText: 'Excise Remarks',
                              border: OutlineInputBorder(),
                            ),
                            minLines: 1,
                            maxLines: 6,
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          //Counter Signature Region
          Container(
            child: dropdownvalue == 'Counter Signature Region'
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: CSCPicker(
                      onCountryChanged: (value) {
                        setState(() {
                          CSRcountryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          CSRstateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          CSRcityValue = value;
                        });
                      },
                    ))
                : null,
          ),
          Container(
            child: dropdownvalue == 'Counter Signature Region'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10,
                              MediaQuery.of(context).size.width * 0.49, 0),
                          child: TextField(
                            controller: csrAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              // for version 2 and greater you can also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              // icon: Icon(Icons.attach_money),
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          //Duplicate Book/Smart Card Issuance
          Container(
            child: dropdownvalue == 'Duplicate Book/Smart Card Issuance'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                              ),
                              value: dbscSelected,

                              // Down Arrow Icon
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              focusColor: Colors.white10,
                              autofocus: true,
                              // disabledHint: 'Select Purpose',
                              focusNode: FocusNode(canRequestFocus: true),
                              dropdownColor: Colors.white,
                              // Array list of items

                              // Array list of items
                              items: dbsclist.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (String? newValue) {
                                setState(() {
                                  dbscSelected = newValue!;
                                });
                              },
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextField(
                            controller: dbscAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              // for version 2 and greater you can also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),

          //Fitness Certificate
          Container(
            child: dropdownvalue == 'Fitness Certificate'
                ? Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    child: CSCPicker(
                      onCountryChanged: (value) {
                        setState(() {
                          FCcountryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          FCstateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          FCcityValue = value;
                        });
                      },
                    ))
                : null,
          ),
          Container(
            child: dropdownvalue == 'Fitness Certificate'
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 7,
                              MediaQuery.of(context).size.width * 0.49, 0),
                          child: TextField(
                            controller: fcAmount,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              // for below version 2 use this
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                              // for version 2 and greater you can also use this
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              // icon: Icon(Icons.attach_money),
                              labelText: 'Enter Amount',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {



  @override
  Widget build(BuildContext context) {
    return Container(

        child: FloatingActionButton(
      // padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
      // color: Colors.blue, // padding: EdgeInsets.fromLTRB(10, 8, 10, 10),
      // color: Colors.blue,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(18.0),
      // ),
      onPressed: () async {
        EasyLoading.show(status: 'loading...');
        print(cId);
        var data = await Firestore.instance
            .collection('Customer')
            .document(cId)
            .get();
        //print only name and age
        Name=data['CName'];
        VehicleModel=data['Model'];
        VehicleNo=data['VehicleNo'];
        Contact=data['ContactNo'];





        //get all the data from the listview and store it in the database
        //then navigate to the next page
        bool check = false;
        for (int i = 0; i < list.length; i++) {
          for (int j = i + 1; j < list.length; j++) {
            if (list[j] != null) {
              if (list[i] == list[j]) {
                check = true;
                break;
              }
            }
          }
        }
        if (check == false) {
          for (int i = 0; i < list.length; i++) {
            if (list[i] == 'Token Tax') {
              if (ttFromcontroller.text.isNotEmpty &&
                  ttTocontroller.text.isNotEmpty &&
                  ttPaymentMethod.text.isNotEmpty &&
                  ttTransactionId.text.isNotEmpty &&
                  ttAmount.text.isNotEmpty &&
                  ttState.text.isNotEmpty &&
                  ttCity.text.isNotEmpty) {
                // tokenTaxDAO.insertTokenTax(TokenTax(
                //   fromDate: ttFromcontroller.text,
                //   toDate: ttTocontroller.text,
                //   paymentMethod: ttPaymentMethod.text,
                //   trxId: ttTransactionId.text,
                //   ttAmount: double.parse(ttAmount.text),
                //   ttState: ttState.text,
                //   ttCity: ttCity.text,
                //   cId: cId,
                // ),

                  Firestore.instance.collection('Customer').document(cId).collection('TokenTax').add({
                    'fromDate': ttFromcontroller.text,
                    'toDate': ttTocontroller.text,
                    'paymentMethod': ttPaymentMethod.text,
                    'trxId': ttTransactionId.text,
                    'ttAmount': double.parse(ttAmount.text),
                    'ttState': ttState.text,
                    'ttCity': ttCity.text,
                    'cId': cId,
                  });

              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Transfer of Ownership of Vehicle') {
              if (tosPreviousName.text.isNotEmpty &&
                  tosNewName.text.isNotEmpty &&
                  tosNewCNIC.text.isNotEmpty &&
                  tosAmount.text.isNotEmpty) {

                Firestore.instance.collection('Customer').document(cId).collection('TransferOfOwnership').add({
                  'previousOwner': tosPreviousName.text,
                  'newOwner': tosNewName.text,
                  'newCNIC': tosNewCNIC.text,
                  'tosAmount': double.parse(tosAmount.text),
                  'cId': cId,
                });

                // transferOwnerDAO.insertTransferOwner(
                //   TransferOwner(
                //     cId: cId,
                //     previousOwner: tosPreviousName.text,
                //     newOwner: tosNewName.text,
                //     newCNIC: tosNewCNIC.text,
                //     tosAmount: double.parse(tosAmount.text),
                //   ),
                //);
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'New Registration') {
              if (nrAmount.text.isNotEmpty) {
                //Insert Data in the New Registration Table
                // newRegistrationDAO.insertNewRegistration(NewRegistration(
                //   cId: cId,
                //   nrAmount: double.parse(nrAmount.text),
                //   nrType: nrSelected,
                // ),
// );
                Firestore.instance.collection('Customer').document(cId).collection('NewRegistration').add({
                  'nrAmount': double.parse(nrAmount.text),
                  'nrType': nrSelected,
                  'cId': cId,
                });


                //);
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Duplicate Book/Smart Card Issuance') {
              if (dbscAmount.text.isNotEmpty) {
                //Insert Data in the Duplicate Book Table

                Firestore.instance.collection('Customer').document(cId).collection('DuplicateBook').add({
                  'dbscAmount': double.parse(dbscAmount.text),
                  'dbscStatus': dbscSelected,
                  'cId': cId,
                });

                // duplicateCopyDAO.insertDuplicateCopy(DuplicateCopy(
                //   cId: cId,
                //   dcAmount: double.parse(dbscAmount.text),
                //   dcStatus: dbscSelected,
                // ),
                //
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Fitness Certificate') {
              if (fcAmount.text.isNotEmpty) {
                //Insert Data in the Fitness Certificate Table

                Firestore.instance.collection('Customer').document(cId).collection('FitnessCertificate').add({
                  'fcAmount': double.parse(fcAmount.text),
                  'fcState': FCstateValue,
                  'fcCity': FCcityValue,
                  'cId': cId,
                });

                // FitnessCertificateDAO.insertFitnessCertificate(
                //   FitnessCertificate(
                //     cId: cId,
                //     fcAmount: double.parse(fcAmount.text),
                //     fcState: FCstateValue,
                //     fcCity: FCcityValue,
                //   ),
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Route Permit') {
              if (rpFrom.text.isNotEmpty &&
                  rpTO.text.isNotEmpty &&
                  rpAmount.text.isNotEmpty) {
                //Insert Data in the Route Permit Table

                Firestore.instance.collection('Customer').document(cId).collection('RoutePermit').add({
                  'from': rpFrom.text,
                  'to': rpTO.text,
                  'rpAmount': double.parse(rpAmount.text),
                  'cId': cId,
                });

                // RoutePermitDAO.insertRoutePermit(RoutePermit(
                //   cId: cId,
                //   from: rpFrom.text,
                //   to: rpTO.text,
                //   rpAmount: double.parse(rpAmount.text),
                // ),
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Counter Signature Region') {
              if (csrAmount.text.isNotEmpty) {
                //Insert Data in the Counter Signature Table

                Firestore.instance.collection('Customer').document(cId).collection('CounterSignature').add({
                  'csrAmount': double.parse(csrAmount.text),
                  'csrState': CSRstateValue,
                  'csrCity': CSRcityValue,
                  'cId': cId,
                });

                // CounterSignatureDAO.insertCounterSignature(CounterSignature(
                //   cId: cId,
                //   csrAmount: double.parse(csrAmount.text),
                //   csrState: CSRstateValue,
                //   csrCity: CSRcityValue,
                // ),
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'FIR Checking') {
              if (fircDate.text.isNotEmpty && fircRemarks.text.isNotEmpty) {
                //Insert Data in the FIR Checking Table

                Firestore.instance.collection('Customer').document(cId).collection('FIRChecking').add({
                  'firDate': fircDate.text,
                  'firRemarks': fircRemarks.text,
                  'cId': cId,
                });

                // FIR_CheckingDAO.insertFIR_Checking(FIR_Checking(
                //   cId: cId,
                //   firDate: fircDate.text,
                //   firRemarks: fircRemarks.text,
                // ),
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Insurance') {
              if (insAmount.text.isNotEmpty) {
                //Insert Data in the Insurance Table

                Firestore.instance.collection('Customer').document(cId).collection('Insurance').add({
                  'insAmount': double.parse(insAmount.text),
                  'cId': cId,
                });

                // InsuranceDAO.insertInsurance(Insurance(
                //   cId: cId,
                //   insAmount: double.parse(insAmount.text),
                // ),
                //
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'Number Plate Fee') {
              if (npAmount.text.isNotEmpty && npStatus.isNotEmpty) {
                //Insert Data in the Number Plate Fee Table

                Firestore.instance.collection('Customer').document(cId).collection('NumberPlate').add({
                  'npAmount': double.parse(npAmount.text),
                  'npStatus': npStatus,
                  'cId': cId,
                });

                // NumberPlateDAO.insertNumberPlate(NumberPlate(
                //   cId: cId,
                //   npStatus: npStatus,
                //   npAmount: double.parse(npAmount.text),
                // ),
                //
                // );
              } else {
                chkforempty = 1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }
            if (list[i] == 'CPLC Verification') {
              if (cplcExciseRemarks.text.isNotEmpty) {
                //Insert Data in the CPLC Verification Table

                Firestore.instance.collection('Customer').document(cId).collection('CPLCVerification').add({
                  'cplcExciseRemarks': cplcExciseRemarks.text,
                  'cplcStatus': cplcSelected,
                  'cId': cId,
                });

                // CPLC_VerificationDAO.insertCPLC_Verification(CPLC_Verification(
                //   cId: cId,
                //   cplcExciseRemarks: cplcExciseRemarks.text,
                //   cplcStatus: cplcSelected,
                // ),
                // );
              } else {
                chkforempty=1;
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please Fill All Details')));
              }
            }

            //Print Customer Details from the Database table Customer

          }
        }

        else {
          chkforempty=2;

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('You Select Two Same Purpose')));
        }
        //Calculate total from all
        total = 0;
        for (int i = 0; i < list.length; i++) {
          if (list[i] == 'Transfer of Ownership of Vehicle') {
            if (tosAmount.text.isNotEmpty) {
              total = total + double.parse(tosAmount.text);
            }
          }
          if (list[i] == 'Token Tax') {
            if (ttAmount.text.isNotEmpty) {
              total = total + double.parse(ttAmount.text);
            }
          }
          if (list[i] == 'New Registration') {
            if (nrAmount.text.isNotEmpty) {
              total = total + double.parse(nrAmount.text);
            }
          }
          if (list[i] == 'Duplicate Book/Smart Card Issuance') {
            if (dbscAmount.text.isNotEmpty) {
              total = total + double.parse(dbscAmount.text);
            }
          }
          if (list[i] == 'Fitness Certificate') {
            if (fcAmount.text.isNotEmpty) {
              total = total + double.parse(fcAmount.text);
            }
          }
          if (list[i] == 'Route Permit') {
            if (rpAmount.text.isNotEmpty) {
              total = total + double.parse(rpAmount.text);
            }
          }
          if (list[i] == 'Counter Signature Region') {
            if (csrAmount.text.isNotEmpty) {
              total = total + double.parse(csrAmount.text);
            }
          }
          if (list[i] == 'Insurance') {
            if (insAmount.text.isNotEmpty) {
              total = total + double.parse(insAmount.text);
            }
          }
          if (list[i] == 'Number Plate Fee') {
            if (npAmount.text.isNotEmpty) {
              total = total + double.parse(npAmount.text);
            }
          }

          // List<Customer> customrtLIst = await customerDAO.getCustomer();
          // for (int i = 0; i < customrtLIst.length; i++) {
          //   {
          //     if (customrtLIst[i].id == cId) {
          //       Name = customrtLIst[i].CName.toString();
          //       Contact = customrtLIst[i].ContactNo.toString();
          //       VehicleNo = customrtLIst[i].VehicleNo.toString();
          //       VehicleModel = customrtLIst[i].Model.toString();
          //     }
          //   }
          // }
        }

        billDetailList = [];
        for (int i = 0; i < list.length; i++) {
          if (list[i] == 'Transfer of Ownership of Vehicle') {
            if (tosAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Transfer of Ownership of Vehicle',
                amount: double.parse(tosAmount.text),
              ));
            }
          }
          if (list[i] == 'Token Tax') {
            if (ttAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Token Tax',
                amount: double.parse(ttAmount.text),
              ));
            }
          }
          if (list[i] == 'New Registration') {
            if (nrAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'New Registration',
                amount: double.parse(nrAmount.text),
              ));
            }
          }
          if (list[i] == 'Duplicate Book/Smart Card Issuance') {
            if (dbscAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Duplicate Book/Smart Card Issuance',
                amount: double.parse(dbscAmount.text),
              ));
            }
          }
          if (list[i] == 'Fitness Certificate') {
            if (fcAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Fitness Certificate',
                amount: double.parse(fcAmount.text),
              ));
            }
          }
          if (list[i] == 'Route Permit') {
            if (rpAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Route Permit',
                amount: double.parse(rpAmount.text),
              ));
            }
          }
          if (list[i] == 'Counter Signature Region') {
            if (csrAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Counter Signature Region',
                amount: double.parse(csrAmount.text),
              ));
            }
          }
          if (list[i] == 'Insurance') {
            if (insAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Insurance',
                amount: double.parse(insAmount.text),
              ));
            }
          }
          if (list[i] == 'Number Plate Fee') {
            if (npAmount.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'Number Plate Fee',
                amount: double.parse(npAmount.text),
              ));
            }
          }
          if (list[i] == 'CPLC Verification') {
            if (cplcExciseRemarks.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'CPLC Verification',
                amount: 0,
              ));
            }
          }
          if (list[i] == 'FIR Checking') {
            if (fircRemarks.text.isNotEmpty) {
              billDetailList.add(BillDetail(
                description: 'FIR Checking',
                amount: 0,
              ));
            }
          }
        }

        var uuid = Uuid();
        String invoice =uuid.v4();
        invoiceid=invoice;
        if (chkforempty == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                Balance(id: cId,
                    name: Name,
                    contact: Contact,
                    vehicleno: VehicleNo,
                    model: VehicleModel,
                    total: total,
                    billDetails: billDetailList,
                    iid: invoiceid)),
          );
        }else if(chkforempty==1){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Please Fill All Detail'),
            duration: Duration(seconds: 5),
          ));
        }
        if(check==true){
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('You Select Two Same Items'),
            duration: Duration(seconds: 5),
          ));
        }

      },
      child: Icon(Icons.arrow_forward_ios_sharp,
      ),

    ));
  }
}
