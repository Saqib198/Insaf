import 'package:flutter/material.dart';
import 'package:footer/footer_view.dart';
import '/Screens/AddDetail.dart';
import '/Screens/HomeScreen.dart';


class SideBar extends StatelessWidget {


  //get Name from Datbase User
  static const String imagesPath = "assets/images/";
  static const String logo = imagesPath + "logo.jpg";
  //
  @override
  Widget build(BuildContext context) {

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          const DrawerHeader(

            decoration: BoxDecoration(
              color: Colors.blue,

            ),
            child:  CircleAvatar(
              backgroundImage:AssetImage(logo),


              ),
            ),


          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          // ListTile(
          //   title: const Text('Customer'),
          //   leading: Icon(Icons.person),
          //   onTap: () {
          //     Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => CustomerDetail()),
          //     );
          //   },
          // ),
          ListTile(
            title: const Text('Vehicles'),
            leading: Icon(Icons.directions_bus_filled),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDetail()),
              );
            },
            ),
          ListTile(
            title: const Text('Token Tax'),
            leading: Icon(Icons.price_change),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: Icon(Icons.logout),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),

        ],

      ),
     //Footer In Drawer






    );


  }
}