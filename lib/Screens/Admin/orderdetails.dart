import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/User/productinfo.dart';
import 'package:e_commerce/Services/store.dart';
import 'package:e_commerce/constans.dart';
import 'package:flutter/material.dart';

import '../../models/productmodel.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store stor = Store();
  @override
  Widget build(BuildContext context) {
    String documentId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: stor.orderDetailsProduct(documentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data!.docs) {
              var data = (doc.data() as dynamic);
              products.add(Product.Quantity(
                  Name: data[KProductName],
                  Quantity: data[KProductQuantity],
                  Category: data[KProductCategory],
                  Location: data[KProductLocation],
                  Discription: 'error',
                  Price: data[KProductPrice]));
            }
            return Column(
              children:<Widget> [
                Expanded(
                  child: ListView.builder(
                    itemBuilder:(context,index)=>
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Ksecondary,
                              height: MediaQuery.of(context).size.height*.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('the name product : ${products[index].Name}',style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.w300),),
                                  SizedBox( height: 5,),
                                  Text('price of product : \$${products[index].Price.toString()}'),
                                  SizedBox(height: 5),
                                  Text('Quantity of product : ${products[index].Quantity.toString()}'),
                                  SizedBox(height: 5),
                                  Text('Category of product : ${products[index].Category}'),
                                  SizedBox(height: 5)

                                ],
                              ),
                            ),
                          ),
                    itemCount: products.length,
                        ),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(onPressed: (){},
                    child: Text("Confirm"),
                      color: Kmaincolor,
                    ),
                    RaisedButton(onPressed: (){},
                    child: Text('Delete'),
                      color:Kmaincolor
                    )
                  ],
                )
              ],
            );

          }else{
            return Center(
              child: Text('loading...'),
            );
          }
        },
      ),
    );
  }
}
