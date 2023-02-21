import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Options.dart';

class Token extends StatefulWidget {
  const Token({Key? key}) : super(key: key);

  @override
  State<Token> createState() => _TokenState();
}

class _TokenState extends State<Token> {
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 0,

            child:
            Container(

                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                child: Text('From: ',style: TextStyle(fontSize: 18),)

            ),


          ),
          Expanded(
            flex: 0,
            child: Container(
              width: MediaQuery.of(context).size.width*0.25,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextField(
                controller: fromDate,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field

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
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                     //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      fromDate.text =
                          formattedDate; //// set output date to TextField value;

                    });
                  } else {}
                },
              ),
            )
          ),
      Expanded(
        flex: 0,

        child:
        Container(

            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(20, 0, 8, 0),

            child: Text('To: ',style: TextStyle(fontSize: 18),)

        ),
      ),
          Expanded(
            flex: 0,

            child: Container(
              width: MediaQuery.of(context).size.width*0.25,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextField(
                controller: toDate,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field


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
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      toDate.text =
                          formattedDate; //set output date to TextField value.

                      //tokens().tokenamount=amountcontroller as int?;

                    });
                  } else {}
                },
              ),

            ),

          ),
          Expanded(
            flex: 0,
            child: Container(
                padding: EdgeInsets.fromLTRB(10, 0,5, 0),
                child: Text('Enter Amount: ',style: TextStyle(fontSize: 18))),

          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0,0, 0),
              child: TextField(
                controller: amountcontroller,
                decoration: InputDecoration(

                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

        ],

      ),


    );

  }
}

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String? RegValue = 'Local';
  var list = [
    'Local',
    'Imported',
    'Auctioned',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
              ),
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
              // Initial Value
              value: RegValue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items

              items: list.map((String items) {
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
                    RegValue = newValue!;
                  },
                );
              }),
        ),
        Expanded(child: Container(
            width: 100,
            child: Amount()))
      ],
    );
  }
}
