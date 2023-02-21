import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/Screens/SideBar.dart';
import 'Dashboard.dart';



class Home extends StatelessWidget {
  static const String _title = 'Irfan Trader';

  Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,

        home: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(title: const Text(_title), centerTitle: true,),

          body: Dashboard(),

      ),

    );
  }
}