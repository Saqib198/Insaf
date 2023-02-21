import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';




TextEditingController oldPasswordController = TextEditingController();
TextEditingController newPasswordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,

      child: Column(

        children: [
          const Text("Setting"
              ,style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
          ),
          SizedBox(
            height: 20,

          ),
          Container(
            width: 300,
            child: TextField(
              obscureText: true,
              controller: oldPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Old Password",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,

          ),
          Container(
            width: 300,
            child: TextField(
              obscureText: true,
              controller: newPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "New Password",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,

          ),
          Container(
            width: 300,
            child: TextField(
              obscureText: true,
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,

          ),
          Container(
            width: 300,
            height: 30,
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.password_outlined,
                color: Colors.white,
                size: 24.0,
              ),
              onPressed: () async {
                EasyLoading.show(status: 'loading...');
                if(oldPasswordController.text.isEmpty){
                  EasyLoading.showError("Old Password is Empty");
                  return;
                }
                if(newPasswordController.text.isEmpty){
                  EasyLoading.showError("New Password is Empty");
                  return;
                }
                if(confirmPasswordController.text.isEmpty){
                  EasyLoading.showError("Confirm Password is Empty");
                  return;
                }
                if(newPasswordController.text != confirmPasswordController.text){
                  EasyLoading.showError("Password Not Match");
                  return;
                }
                if(oldPasswordController.text == newPasswordController.text){
                  EasyLoading.showError("Old Password and New Password is Same");
                  return;
                }
                //Compare Old Password and firebase databse store password in Admin Collection
                var admin = await Firestore.instance.collection('Admin').document('Admin').get();
                print(admin['Password']);
                if(admin['Password'] == oldPasswordController.text && newPasswordController.text == confirmPasswordController.text) {
                  await Firestore.instance.collection('Admin')
                      .document('Admin')
                      .update({
                    'Password': newPasswordController.text,
                  });
                  EasyLoading.showSuccess("Password Change Successfully");
                  return;
                }


                {
                  EasyLoading.showError("Old Password is Wrong");
                  return;
                }
              }, label: Text("Change Password"),

            ),
          ),
          SizedBox(
            height: 30,


          ),
          Container(
            width: 300,
            height: 30,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              icon: Icon(
                Icons.logout_sharp,
                color: Colors.white,
                size: 24.0,
              ),

              onPressed: () {
                Navigator.pop(context);
              }, label: Text("Logout"),

            ),
          ),
        ],
      ),
    );


  }
}
