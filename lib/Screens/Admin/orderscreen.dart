import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/models/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Services/store.dart';
import 'orderdetails.dart';

class OrderScreen extends StatelessWidget{
  static String id = 'OrderScreen';
  Store store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.orderProduct(),
        builder: (context,snapshot) {
           if(!snapshot.hasData){
             return Center(
               child: Text('there is no orders',style: TextStyle(fontWeight: FontWeight.bold),),
             );
           }else{
             List<OrderModul> orders = [];
             for(var doc in snapshot.data!.docs){
               var data = (doc.data() as dynamic);
               orders.add( OrderModul(address: data[KAdress], totalprice: data[KtotalPrice],documentId: doc.id));
                 }
               return ListView.builder(
                   itemBuilder:(context,index)=>
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.pushNamed(context, OrderDetails.id ,arguments: orders[index].documentId);
                           },
                           child: Container(
                             color: Ksecondary,
                             height: MediaQuery.of(context).size.height*.2,
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: <Widget>[
                                 Text('the Address is : ${orders[index].address}',style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.w300),),
                                 SizedBox( height: 5,),
                                 Text('Total price is : \$${orders[index].totalprice.toString()}'),

                               ],
                             ),
                           ),
                         ),
                       ),
                   itemCount: orders.length,
               );


             }
           }
         ,

      ),
    );
  }


}