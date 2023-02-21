import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/Screens/AddDetail.dart';


import 'Customer.dart';
import 'FileChecking.dart';
import 'Setting.dart';


int CustomerCount = 0;
double Debit=0;
double Credit=0;
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  String get title => "Insaf Trader";

  @override
  State<Dashboard> createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  int index = 0;
  bool isExtended = false;

  final selectedColor = Colors.white;
  final unselectedColor = Colors.white60;
  final labelStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            //labelType: NavigationRailLabelType.all,
            selectedIndex: index,
            extended: isExtended,
            //groupAlignment: 0,
            selectedLabelTextStyle: labelStyle.copyWith(color: selectedColor),
            unselectedLabelTextStyle:
            labelStyle.copyWith(color: unselectedColor),
            selectedIconTheme: IconThemeData(color: selectedColor, size: 30),
            unselectedIconTheme:
            IconThemeData(color: unselectedColor, size: 30),
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            leading: Material(
              clipBehavior: Clip.hardEdge,
              shape: CircleBorder(),
              // child: IconButton(
              //   icon: Icon(Icons.menu),
              //   onPressed: () async {
              //     final DB =await DatabaseAccess();
              //     final database = await DB.instance;
              //     final userDAO = database.userDAO;
              //     List<User> customers = await userDAO.getAllUser();
              //     print(customers);
              //   },
              // ),
              child: Ink.image(
                width: 65,
                height: 65,
                fit: BoxFit.fitHeight,
                image: const AssetImage('assets/images/logo.png'),
                child: InkWell(
                  onTap: () => setState(() => isExtended = !isExtended),
                ),
              ),

            ),

            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home, size: 30),

                label: Text('Home'),
              ),
              NavigationRailDestination(
                  icon: Icon(Icons.person_add_alt_1_outlined, size: 30),
                  selectedIcon: Icon(Icons.person_add_alt_1, size: 30),
                  label: Text('Add Customer')),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline, size: 30),
                selectedIcon: Icon(Icons.person, size: 30),
                label: Text('Customer Details'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.file_copy, size: 30),
                label: Text('File Checking'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings, size: 30),
                label: Text('Settings'),
              ),
            ],
          ),

          Expanded(child: buildPages()),
        ],
      ),
    );
  }
    Widget buildPages() {

      switch (index) {
        case 0:
          return HomePage();
        case 1:
          return AddDetail();
        case 2:

          return CustomerDetail();
        case 3:
          return FileChecking();
        default:
          return Setting();
      }
    }
  }


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  Future<void> _getData() async {
    CustomerCount = 0;
    Debit = 0;
    Credit = 0;
    final data = await Firestore.instance.collection('Customer').get();
    for (var i in data) {
      CustomerCount++;
      final data1 = await Firestore.instance
          .collection('Customer')
          .document(i.id)
          .collection('Invoice')
          .get();
      for (var j in data1) {
        if (j['received'] > 0) {
          if (j['total'] - j['received'] - j['discount'] > 0) {
            Credit = Credit + j['total'] - j['received'] - j['discount'];
          }

          Debit = Debit + j['received'];
          setState(() {
            Debit=Debit;
            Credit=Credit;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
          children: [
            Container(
                child: Row(children: [
      Container(
          child: Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.002),

        height: 150,
        width: MediaQuery.of(context).size.width * 0.23,

        //padding: new EdgeInsets.fromLTRB(0, 10, 0, 10),
//        margin: new EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               ListTile(
                leading: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
                title: Text('Total Customer',
                    style: TextStyle(fontSize: 28.0, color: Colors.white)),
                subtitle: Text('$CustomerCount',
                    style: TextStyle(fontSize: 28.0, color: Colors.white)),
              ),
            ],
          ),
        ),
      )),
      Container(
          child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.23,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.002),

        //padding: new EdgeInsets.fromLTRB(0, 10, 0, 10),
//        margin: new EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               ListTile(
                leading: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
                title: Text('Total Debit: ', style: TextStyle(fontSize: 28.0,color: Colors.white)),
                subtitle: Text('$Debit', style: TextStyle(fontSize: 28.0,color: Colors.white)),
              ),
            ],
          ),
        ),
      )),
      Container(
          child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width * 0.23,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.002),

        //padding: new EdgeInsets.fromLTRB(0, 10, 0, 10),
//        margin: new EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.blue,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
               ListTile(
                leading: Icon(
                  Icons.person,
                  size: 100,
                  color: Colors.white,
                ),
                title: Text('Total Credit: ', style: TextStyle(fontSize: 28.0,color: Colors.white)),
                subtitle: Text('$Credit', style: TextStyle(fontSize: 28.0,color: Colors.white)),
              ),
            ],
          ),
        ),
      )),
    ])
    ),





        ],
    )
    )
    );


  }
}
