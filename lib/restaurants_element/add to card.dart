import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/restaurants_element/restaurants_list.dart';
import 'package:offi_memoire/wedget/custom_text_field.dart';

class Add_to_card extends StatefulWidget {
  List order;
  String? restaurantName;
  Add_to_card({super.key, required this.order, required this.restaurantName});
  @override
  State<Add_to_card> createState() =>
      _Add_to_cardState(this.order, this.restaurantName);
}

class _Add_to_cardState extends State<Add_to_card> {
  List order;
  String? restaurantName;
  _Add_to_cardState(this.order, this.restaurantName);
  Custom_text_field? Adress;
  Custom_text_field? fullName;
  Custom_text_field? creditCardNum;
  Custom_text_field? phoneNum;

  int Total = 0;
  calcul_total() {
    order.forEach((element) {
      Total += int.parse(element["price"].toString());
    });
  }

  @override
  void initState() {
    calcul_total();
    super.initState();
  }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  validator() {
    var formdata = _formkey.currentState;
    formdata?.save();

    if (
      fullName!.inputText.toString().isEmpty ||
        Adress!.inputText.toString().isEmpty ||
        phoneNum!.inputText.toString().isEmpty ||
        creditCardNum!.inputText.toString().isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'There empty field',
        desc: 'make sure to fill all the fields',
        // btnCancelOnPress: () {},
        btnOkOnPress: () {},
      )..show();
    } else {
      pushOrder();
    }
  }

  pushOrder() async {
    var formdata = _formkey.currentState;
    formdata?.save();

    String id = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      CollectionReference orderref = FirebaseFirestore.instance
          .collection(restaurantName!.toString())
          .doc("order")
          .collection("order");

      await orderref.add({
        "fullName": fullName!.inputText.toString(),
        "address": Adress!.inputText.toString(),
        "creditCardNum": creditCardNum!.inputText.toString(),
        "phoneNum": phoneNum!.inputText.toString(),
        "id": id.toString(),
      }).then((value) =>
          orderref.where("id", isEqualTo: id.toString()).get().then((value) {
            value.docs.forEach((element) {
              id = element.id;
            });
          }));
      // ------ first part

      try {
        order.forEach((element) async {
          await orderref.doc(id.toString()).collection(id).add({
            "name": element["name"],
            "description": element["description"],
            "image": element["image"],
            "price": element["price"],
          });
        });
        // ignore: avoid_single_cascade_in_expression_statements
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Graet ,your order will come soon',
          desc: 'back to the home page',
          // btnCancelOnPress: () {},
          btnOkOnPress: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                RestaurantList()), (Route<dynamic> route) => false);
          },
          dismissOnTouchOutside: false,
        )..show();
      } catch (e) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.warning,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: e.toString(),
          // btnCancelOnPress: () {},
          btnOkOnPress: () {},
        )..show();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _onPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onPop,
      child: Scaffold(
          backgroundColor: Colors.orange[200],
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => validator(),
            backgroundColor: Colors.orange,
            // ignore: prefer_const_constructors
            label: Text(
              "Confirm",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 40,
                color: Colors.black54,
                fontFamily: 'Signatra',
                letterSpacing: 3,
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.orange[500],
            title: const Center(
              child: Text(
                "Add to card",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black54,
                  fontFamily: 'Signatra',
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Container(
              height: height,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Total is $Total DA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black87,
                      fontFamily: 'Signatra',
                      letterSpacing: 1,
                    ),
                  ),
                  Form(
                      key: _formkey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          fullName = Custom_text_field(
                            fieldType: TextInputType.text,
                            iconData: Icons.text_fields,
                            hintText: "Full name",
                            labelText: "Full name",
                            isObsecure: false,
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 20,
                          ),
                          Adress = Custom_text_field(
                            fieldType: TextInputType.text,
                            iconData: Icons.text_fields,
                            hintText: "Address",
                            labelText: "Address",
                            isObsecure: false,
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 20,
                          ),
                          phoneNum = Custom_text_field(
                            fieldType: TextInputType.number,
                            iconData: Icons.phone,
                            hintText: "Phone",
                            labelText: "Phone",
                            isObsecure: false,
                          ),
                          // ignore: prefer_const_constructors
                          SizedBox(
                            height: 20,
                          ),
                          creditCardNum = Custom_text_field(
                            fieldType: TextInputType.number,
                            iconData: Icons.credit_card,
                            hintText: "Credit Card Num",
                            labelText: "Credit Card Num",
                            isObsecure: false,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
