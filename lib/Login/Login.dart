import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/admin.dart';
import 'package:offi_memoire/wedget/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController? _email;
  TextEditingController? _password;

  late Custom_text_field email;
  late Custom_text_field password;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String? UID;
  String? collectionName;
  List name = [];

  CollectionReference user = FirebaseFirestore.instance.collection("users");
  login() async {
    var formdata = _formkey.currentState;
    formdata?.save();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.inputText,
        password: password.inputText,
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return Admin();
        },
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'user-not-found',
          desc: 'verify the email',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      } else if (e.code == 'wrong-password') {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'wrong-password',
          desc: 'Wrong password provided for that user.',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    }
  }

  formvalidator() {
    var formdata = _formkey.currentState;
    formdata?.save();
        print(email.inputText);
        print(password.inputText);
        print(_email);
        print(_password);
    if (password.inputText.toString().isEmpty || password.inputText.toString().isEmpty) {
      setState(() {
        
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'There empty field',
          desc: 'make sure there is no empty field',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      });
    } else {
      login();
    }
  }


  Future<bool> _onPop() async {
  return (await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('back into begin page'),
          content: new Text('Do you want to back'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), //<-- SEE HERE
              child: new Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil("start_page", (route) => false), // <-- SEE HERE
              child: new Text('Yes'),
            ),
          ],
        ),
      )) ??
      false;
}
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      
      onWillPop: _onPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 250, 218, 171),
            height: height,
            child: Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 250, 218, 171),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(500),
                        ),
                        child: Padding(
                          child: Container(
                            height: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                image: DecorationImage(
                                    image:
                                        AssetImage('images/project_logo.png'))),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Restaurant Admin',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.black87,
                          fontFamily: 'Signatra',
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              email = Custom_text_field(
                                controller: _email,
                                fieldType: TextInputType.emailAddress,
                                iconData: Icons.email,
                                hintText: "Email",
                                labelText: "Email",
                                isObsecure: false,
                              ),
                              // ignore: prefer_const_constructors
                              SizedBox(
                                height: 20,
                              ),
                              password = Custom_text_field(
                                controller: _password,
                                fieldType: TextInputType.text,
                                iconData: Icons.password_outlined,
                                hintText: "Password",
                                labelText: "Password",
                                isObsecure: true,
                              ),
                            ],
                          )),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            formvalidator();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              // ignore: prefer_const_constructors
                              padding: EdgeInsets.symmetric(
                                  horizontal: 55, vertical: 11),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Connect',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
