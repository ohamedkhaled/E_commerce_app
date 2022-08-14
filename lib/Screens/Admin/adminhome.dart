import 'package:e_commerce/Screens/Admin/addproduct.dart';
import 'package:e_commerce/Screens/Admin/manageproduct.dart';
import 'package:e_commerce/Screens/Admin/orderscreen.dart';
import 'package:e_commerce/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kmaincolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Text('Add Product'),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProduct.id);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('Edit Product'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, OrderScreen.id);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text('View orders'),
          )
        ],
      ),
    );
  }
}
