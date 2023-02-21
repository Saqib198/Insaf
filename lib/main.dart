
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'Screens/Dashboard.dart';

import 'package:desktop_window/desktop_window.dart';
import 'package:firedart/firedart.dart';

const apiKey='AIzaSyDd7-gy6Rn4LSOr1CrNzikkWy876RZ9FRc';
const projectId='insaftrader-b0a44';
Future<void> main() async {


  runApp(login());

  Firestore.initialize(projectId);
  await DesktopWindow.setMinWindowSize(Size(1200,650));

  await DesktopWindow.setMaxWindowSize(Size(800,800));

}

class login extends StatelessWidget {
  static const String _title = 'Insaf Traders';

  login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
        builder: EasyLoading.init(),
      home: Scaffold(

        // appBar: AppBar(title: const Text(_title), centerTitle: true,
        //   automaticallyImplyLeading: false,
        // ),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final DB = DatabaseAccess();
  // late final database =  DB.instance;
  // late final userDAO = database.userDAO;
  CollectionReference Customer = Firestore.instance.collection('Customer');
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                width: 200,
                height:200,

                child: Image.asset('assets/images/logo.png')),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'LOG IN',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.2,MediaQuery.of(context).size.width*0.03,MediaQuery.of(context).size.width*0.2,0),
              child: TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.2,MediaQuery.of(context).size.width*0.006,MediaQuery.of(context).size.width*0.2,MediaQuery.of(context).size.width*0.006),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
                height: 50,
                padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.2,MediaQuery.of(context).size.width*0.006,MediaQuery.of(context).size.width*0.2,0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {



                    print(userNameController.text);
                    print(passwordController.text);
                    if(userNameController.text.isNotEmpty && passwordController.text.isNotEmpty)
                    {
                      EasyLoading.show(status: 'loading...');
                      Firestore.instance.collection('Admin').where('Admin',isEqualTo: userNameController.text.toString()).where('Password',isEqualTo: passwordController.text.toString()).get().then((value) {
                        print(value);
                        if(value.length>0)
                        {
                          EasyLoading.dismiss();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Dashboard()),
                          );
                          userNameController.clear();
                          passwordController.clear();
                        }
                        else
                        {
                          EasyLoading.dismiss();
                          EasyLoading.showError('Invalid User Name or Password');
                        }
                      });
                    }
                    else
                    {
                      EasyLoading.showError('Please Fill All Detail');
                    }
                  //   userDAO.findUserByNameAndPassword(userNameController.text.toString(), passwordController.text.toString()).then((value) {
                  //     print(value);
                  //     if(value != null){
                  //       EasyLoading.show(status: 'loading...');
                  //       //send name to next screen and navigate to next screen
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                  //     }else{
                  //       print('user not found');
                  //       //Show error message to user
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //         content: Text('User not found'),
                  //       ));
                  //
                  //   }
                  //   });


                   },

                )
            ),
            //Signup
            // Container(
            //   child:TextButton(
            //     child: Text("Signup"),
            //     onPressed: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => signup()),
            //       );
            //     },
            //   )
            // )

          ],
        ));
  }
}