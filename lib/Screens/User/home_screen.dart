import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Screens/User/login_screen.dart';
import 'package:e_commerce/Screens/User/productinfo.dart';
import 'package:e_commerce/Services/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/productmodel.dart';
import 'CardScreen.dart';

class ScreenHome extends StatefulWidget {
  static String id = 'ScreenHome';

  @override
  State<StatefulWidget> createState() {
    return _SreenHomeState();
  }
}

class _SreenHomeState extends State<ScreenHome> {
  int tabBarIndax = 0;
  int bottomBarIndax =0;
  final auth = Auth();
  final stor =Store();
  late List<Product> tempProducts ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
            length: 4,
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: KUnActiveColor,
                //type: BottomNavigationBarType.fixed,
                fixedColor: Kmaincolor,
                currentIndex: bottomBarIndax  ,
                onTap: (value) async{
                  if(value==2){
                      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
                      sharedprefrence.clear();
                      await auth.logout();
                      Navigator.popAndPushNamed(context, LoginScreen.id);

                  }
                  setState(() {
                    bottomBarIndax=value;
                  });
                },
                items: [
                  BottomNavigationBarItem(label: 'test' , icon: Icon(Icons.person)),
                  BottomNavigationBarItem(label: 'test' , icon: Icon(Icons.person)),
                  BottomNavigationBarItem(label: 'Logout' , icon: Icon(Icons.close)),
                ],
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 20,
                bottom: TabBar(
                  indicatorColor: Kmaincolor ,
                  onTap: (value) {
                    setState(() {
                      tabBarIndax = value;
                    });
                  },
                  tabs: <Widget>[
                    Text('Jackets',
                        style: TextStyle(
                            color: tabBarIndax == 0 ? Colors.black : KUnActiveColor,
                            fontSize: tabBarIndax == 0 ? 16 : null)),
                    Text(
                      'Trouser',
                        style: TextStyle(
                            color: tabBarIndax == 1 ? Colors.black : KUnActiveColor,
                            fontSize: tabBarIndax == 1 ? 16 : null)
                    ),
                    Text('T-Shirts',
                        style: TextStyle(
                            color: tabBarIndax == 2 ? Colors.black : KUnActiveColor,
                            fontSize: tabBarIndax == 2 ? 16 : null)
                    ),
                    Text('Shoes',
                        style: TextStyle(
                            color: tabBarIndax == 3 ? Colors.black : KUnActiveColor,
                            fontSize: tabBarIndax == 3 ? 16 : null)
                    )
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  ProductView('jackets'),
                  ProductView('trousers'),
                  ProductView('t-shirts'),
                  ProductView('shoes'),
                ],
              ) ,
            )
        ),
        Material(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height*.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Discover'.toUpperCase(),style: TextStyle(color: Colors.black ,fontFamily: 'Pacifico')),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, CardScreen.id);
                              },
                                child: Icon( Icons.shopping_cart))
                          ],
                        ),
                      )
                      ),
                    ),

           ]
    );
  }









  Widget ProductView( String CategoryName) {
    return StreamBuilder<QuerySnapshot>(
        stream: stor.loadProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
              for (var doc in snapshot.data!.docs) {
              var data = (doc.data() as dynamic);
              products.add(Product.id(
                  id:doc.id,
                  Name: data![KProductName],
                  Discription: data![KProductDescription],
                  Price: data![KProductPrice],
                  Category: data![KProductCategory],
                  Location: data![KProductLocation]));
            }
              tempProducts=[...products]; //pass by value
              products.clear();
              products=getProductByCategory(CategoryName);

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: .8),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, ProductInfo.id,arguments: products[index]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image(
                              fit:BoxFit.fill,
                              image: AssetImage(products[index].Location)
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
                                  Text(products[index].Name , style: TextStyle(fontWeight:FontWeight.bold),),
                                  Text('\$ ${products[index].Price}' ,style: TextStyle(fontWeight: FontWeight.w600),)
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
              itemCount: products.length,
            ); //ui for admin
          } else {
            return Center(
              child: Text('Loading...!'),
            );
          }
        });
  }

  List<Product>   getProductByCategory(String CategoryName )
  {
    List<Product> products = [];
    for(var  product in tempProducts )
      {
        if(product.Category== CategoryName)
        {
          products.add(product);
        }
      }

  return products ;
  }



}
