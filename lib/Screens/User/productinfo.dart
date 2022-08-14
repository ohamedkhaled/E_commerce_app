import 'package:e_commerce/Provider/cardItem.dart';
import 'package:e_commerce/Screens/User/CardScreen.dart';
import 'package:e_commerce/constans.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/productmodel.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';
  @override
  State<StatefulWidget> createState() {
    return _ProductInfo();
  }
}

class _ProductInfo extends State<ProductInfo> {
  int Quantity = 1;

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute
        .of(context)!
        .settings
        .arguments as Product;

    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child:
            Image(fit: BoxFit.fill, image: AssetImage(product.Location))),
        //image
        Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CardScreen.id);
                      },
                      child: Icon(Icons.shopping_cart)),
                ],
              ),
            )),
        //arroback and icon card
        Positioned(
          bottom: 0,
          child: Column(
              children: <Widget>[
                Opacity(

                  opacity: .6,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .25,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(product.Name, style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),),
                          SizedBox(height: 10,),
                          Text(product.Discription, style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                          SizedBox(height: 10,),
                          Text('\$${product.Price}', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ClipOval(
                                child: Material(
                                  color: Kmaincolor,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        decreasQuantity();
                                      });
                                    },
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(Icons.remove),
                                    ),
                                  ),
                                ),
                              ),
                              Text(Quantity.toString(), style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),),
                              ClipOval(
                                child: Material(
                                  color: Kmaincolor,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        increasQuantity();
                                      });
                                    },
                                    child: SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * .1,
                  child: Builder(
                    builder: (context) =>
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          onPressed: () {
                            AddToCard(context, product);
                          },
                          child: Text(
                            'Add to Card'.toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Kmaincolor,
                        ),
                  ),
                ),
              ]),
        )
        //discrib and raisbutton
      ]),
    );
  }

  increasQuantity() {
    Quantity++;
    print(Quantity);
  }

  decreasQuantity() {
    if (Quantity > 1)
      Quantity--;
  }

  void AddToCard(BuildContext context, Product product) {
    CardItem cardItem = Provider.of<CardItem>(context, listen: false);
    product.Quantity = Quantity;
    bool exist = false;
    var productInCart = cardItem.productCard;
    for (var productInCart in productInCart) {
      if (productInCart == product) {
        exist = true;
      }
    }
    if (exist) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('you \'ve added this product before'),));
    } else {
       cardItem.AddProductToCard(product);
       Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Added to Card'),));
    }
  }
}