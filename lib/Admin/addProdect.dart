import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offi_memoire/wedget/custom_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Add_Product extends StatefulWidget {
  String? collectionName;
  String? menuName;
  Add_Product({
    super.key,
    required this.collectionName,
    required this.menuName,
  });

  @override
  State<Add_Product> createState() =>
      _Add_ProductState(collectionName, menuName);
}

class _Add_ProductState extends State<Add_Product> {
  String? collectionName;
  String? menuName;
  _Add_ProductState(
    this.collectionName,
    this.menuName,
  );
  File? image;
  final imagePicker = ImagePicker();
  String? imageURL;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late Custom_text_field? title;
  late Custom_text_field? description;
  late Custom_text_field? price;
  TextEditingController? _title;
  TextEditingController? _description;
  TextEditingController? _price;

  Uploadimage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  UploadProduct() async {
    var formdata = _formkey.currentState;
    formdata?.save();
    if (image != null) {
      //create reference
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("${collectionName.toString().toLowerCase()}_image")
          .child("${menuName.toString()}");
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference imageref = reference.child(uniqueName);
      try {
        await imageref.putFile(File(image!.path)); //upload image
        imageURL = await imageref.getDownloadURL();

        adddata();
        Navigator.of(context).pop();
      } catch (e) {
        print(e);
      }
    } else {
      AwesomeDialog(
        context: context, dismissOnTouchOutside: false,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: "no image found ,You should upload image .",
        // btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    }
  }

  adddata() async {
    CollectionReference broaster =
        FirebaseFirestore.instance.collection(collectionName.toString());

    await broaster
        .doc(menuName.toString())
        .collection(menuName.toString())
        .add({
      "name": title!.inputText.toString(),
      "description": description!.inputText.toString(),
      "price": int.parse(price!.inputText
          .toString()), //int.parse(price!.inputText.toString()),
      "image": imageURL,
    });
  }

  Future<bool> _onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
          backgroundColor: Colors.orange[200],
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.orange[500],
            title: const Center(
              child: Text(
                "Admin space",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.orange),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(vertical: 10)),
                      alignment: Alignment.center,
                    ),
                    onPressed: () {
                      Uploadimage();
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Icon(Icons.camera),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "choose from gallery",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              image == null
                  ? Center(
                      child: Text(
                      "No choosen photo",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ))
                  : Image.file(image!),
              SizedBox(
                height: 20,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      title = Custom_text_field(
                        controller: _title,
                        fieldType: TextInputType.text,
                        iconData: Icons.description,
                        hintText: "Title",
                        labelText: "Title",
                        isObsecure: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      description = Custom_text_field(
                        controller: _description,
                        fieldType: TextInputType.text,
                        iconData: Icons.description,
                        hintText: "Description",
                        labelText: "Description",
                        isObsecure: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      price = Custom_text_field(
                        controller: _price,
                        fieldType: TextInputType.number,
                        iconData: Icons.numbers,
                        hintText: "Price",
                        labelText: "Price",
                        isObsecure: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            try {
                              UploadProduct();
                            } catch (e) {
                              print("error :: $e");
                            }
                            ;
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
                            'Add Product',
                            // ignore: prefer_const_constructors
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
