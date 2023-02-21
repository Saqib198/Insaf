import 'package:flutter/material.dart';


import '../main.dart';
import 'SideBar.dart';

Future<void> main() async {
  runApp(signup());
}

class signup extends StatelessWidget {
  static const String _title = 'IT';
  signup({Key? key}) : super(key: key);
  String value = "S";
  String value1 = "3";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: SideBar(),
        appBar: AppBar(title: const Text(_title)),
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
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'IT',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  0,
                  MediaQuery.of(context).size.width * 0.2,
                  0),
              //(MediaQuery.of(context).size.height),
              child: TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.006,
                  MediaQuery.of(context).size.width * 0.2,
                  0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.006,
                  MediaQuery.of(context).size.width * 0.2,
                  0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.006,
                  MediaQuery.of(context).size.width * 0.2,
                  0),
              child: TextField(
                obscureText: false,
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.006,
                  MediaQuery.of(context).size.width * 0.2,
                  MediaQuery.of(context).size.width * 0.006),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.2,
                    MediaQuery.of(context).size.width * 0.006,
                    MediaQuery.of(context).size.width * 0.2,
                    0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
                    print(userNameController.text);
                    print(phoneController.text);

                    // userDAO
                    //     .findUserByUserName(userNameController.text)
                    //     .then((value) {
                    //   if (value != null) {
                    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //       content: Text('User Already Registered'),
                    //     ));
                    //   } else {
                    //     userDAO.insertUser(User(
                    //       UserName: userNameController.text.toString(),
                    //       name: nameController.text.toString(),
                    //       email: emailController.text.toString(),
                    //       PhoneNumber: phoneController.text.toString(),
                    //       password: passwordController.text.toString(),
                    //     ));

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => login()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Registered Successfully'),
                        ));
                        //Go to Login Screen
                      }

                    // print( userDAO.insertUser(User(UserName: userNameController.text.toString(),
                    //   name: nameController.text.toString(),
                    //   email: emailController.text.toString(),
                    //   PhoneNumber: phoneController.text.toString(),
                    //   password: passwordController.text.toString(),
                    // )));
                    //on main screen

                )),
            Row(
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => login()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
