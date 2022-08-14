import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/Admin/editproduct.dart';
import 'package:e_commerce/Services/store.dart';
import 'package:flutter/material.dart';

import '../../constans.dart';
import '../../models/productmodel.dart';
import '../../widgets/custom_menu.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';


  @override
  State<StatefulWidget> createState() {
    return _ManageProduct();
  }
}

class _ManageProduct extends State<ManageProduct> {
  final stor = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>( 
            stream: stor.loadProduct(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> product = [];
                for (var doc in snapshot.data!.docs) {
                  var data = (doc.data() as dynamic);
                  product.add(Product.id(
                      id:doc.id,
                      Name: data![KProductName],
                      Discription: data![KProductDescription],
                      Price: data![KProductPrice],
                      Category: data![KProductCategory],
                      Location: data![KProductLocation]));
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: .8),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    child: GestureDetector(
                      onTapUp: (details) async {
                        double dx = details.globalPosition.dx ;//left
                        double dy = details.globalPosition.dy ;//top
                        double dx2= MediaQuery.of(context).size.width - dx ; //right
                        double dy2 =MediaQuery.of(context).size.height -dy ; //bottom

                       await showMenu(context: context,
                            position:RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                            items:[
                              MyPopupMenuItem(
                                Onclick: (){Navigator.pushNamed(context,EditProduct.id,arguments:product[index]) ;},
                                child: Text('Edit'),),
                              MyPopupMenuItem(
                                Onclick:(){
                                  stor.deleteproduct(product[index].id);
                                  Navigator.pop(context);
                                } ,
                                child: Text('Delete'),
                              )
                            ]
                        );

                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                              child: Image(
                                  fit:BoxFit.fill,
                                  image: AssetImage(product[index].Location)
                              )
                          ),
                          Positioned(
                            bottom: 0,
                            child: Opacity(
                              opacity: .6,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(product[index].Name , style: TextStyle(fontWeight:FontWeight.bold),),
                                      Text('\$ ${product[index].Price}' ,style: TextStyle(fontWeight: FontWeight.w600),)
                                    ],
                                  ),
                                ),
                                color: Colors.white ,
                                height: 60 ,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: product.length,
                ); //ui for admin
              } else {
                return Center(
                  child: Text('Loading...!'),
                );
              }
            }));
  }
}