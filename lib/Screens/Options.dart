import 'package:flutter/material.dart';

class Amount extends StatefulWidget {
  const Amount({Key? key}) : super(key: key);

  @override
  State<Amount> createState() => _AmountState();
}

class _AmountState extends State<Amount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

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
              decoration: InputDecoration(

                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
        ],
    );
  }
}
