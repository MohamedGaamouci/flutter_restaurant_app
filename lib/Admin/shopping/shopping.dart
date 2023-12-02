import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/shopping/detail.dart';

class Shopping extends StatefulWidget {
  String collectionName;
  Shopping({super.key, required this.collectionName});

  @override
  State<Shopping> createState() =>
      _ShoppingState(collectionName: collectionName);
}

class _ShoppingState extends State<Shopping> {
  String collectionName;
  _ShoppingState({required this.collectionName});
  @override
  void initState() {
    getData();
    super.initState();
  }

  List orders = [];

  String imageNotFound =
      "https://firebasestorage.googleapis.com/v0/b/deleveryapp-eab92.appspot.com/o/fuel-sign-nhe-13784_1000_2.gif?alt=media&token=15ecb827-58f6-4dcd-a320-b485e7917708";

  void getData() async {
    final CollectionReference ordersDB = FirebaseFirestore.instance
        .collection(collectionName)
        .doc('order')
        .collection("order");
    await ordersDB.snapshots().listen((event) {
      event.docs.forEach((element) {
        setState(() {
          orders.add(element.data());
        });
      });
    });
  }

  delete(int index) async {
    final CollectionReference deleteDB = FirebaseFirestore.instance
        .collection(collectionName)
        .doc('order')
        .collection("order");
    var id;

    await deleteDB
        .where("id", isEqualTo: orders[index]["id"].toString())
        .get()
        .then((value) => value.docs.forEach((element) {
              id = element.id;
            }))
        .then((value) {
      deleteDB.doc(id.toString()).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange[200],
        appBar: AppBar(
          backgroundColor: Colors.orange[500],
          title: const Center(
            child: Text(
              "Order space",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black54,
                fontFamily: 'Signatra',
                letterSpacing: 3,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            double width = MediaQuery.of(context).size.width;
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Shopping_Detail(
                          collectionName: collectionName,
                          id: orders[index]["id"].toString());
                    }));
                  },
                  borderRadius: BorderRadius.circular(100),
                  child: Card(
                    shadowColor: Colors.amber[400],
                    color: Color.fromARGB(179, 240, 151, 26),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: width - 60,
                            alignment: Alignment.centerLeft,
                            // ignore: prefer_const_constructors
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "fullName :: ${orders[index]["fullName"]} ",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                            width: width - 60,
                            alignment: Alignment.centerLeft,
                            // ignore: prefer_const_constructors
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "phoneNum :: ${orders[index]["phoneNum"]} ",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                            width: width - 60,
                            alignment: Alignment.centerLeft,
                            // ignore: prefer_const_constructors
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "address :: ${orders[index]["address"]} ",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                            width: width - 60,
                            alignment: Alignment.centerLeft,
                            // ignore: prefer_const_constructors
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "creditCardNum :: ${orders[index]["creditCardNum"]} ",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        Container(
                            width: width - 60,
                            alignment: Alignment.centerLeft,
                            // ignore: prefer_const_constructors
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            // ignore: prefer_const_constructors
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "id :: ${orders[index]["id"]} ",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 35,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                              textAlign: TextAlign.left,
                            )),
                        ElevatedButton.icon(
                            onPressed: () {
                              // ignore: avoid_single_cascade_in_expression_statements
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.infoReverse,
                                animType: AnimType.leftSlide,
                                title: 'Confirm',
                                // desc: ,
                                // btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  setState(() {
                                    delete(index);
                                  orders.removeAt(index);
                                  // ignore: avoid_single_cascade_in_expression_statements
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      title: 'Delete success',
                                      // desc: e.toString(),
                                      // btnCancelOnPress: () {},
                                      // btnOkOnPress: () {},
                                    )..show();
                                  });
                                },
                              )..show();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.amber)),
                            // ignore: prefer_const_constructors
                            icon: Icon(
                              Icons.done,
                            ),
                            // ignore: prefer_const_constructors
                            label: Text(
                              "Done",
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.black87,
                                fontFamily: 'Signatra',
                                letterSpacing: 3,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
