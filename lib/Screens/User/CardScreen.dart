import 'package:e_commerce/Provider/cardItem.dart';
import 'package:e_commerce/Screens/User/productinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/store.dart';
import '../../constans.dart';
import '../../models/productmodel.dart';
import 'dart:ui';

import '../../widgets/custom_menu.dart';

class CardScreen extends StatelessWidget {
  static String id = 'CardScareen';
  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CardItem>(context).productCard;
    final double ScreenWidth = MediaQuery.of(context).size.width;
    final double ScreenHight = MediaQuery.of(context).size.height;
    final double appbarhight = AppBar().preferredSize.height;
    final double statusbarhight = MediaQuery.of(context).padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 4,
          title: Text('MyCart',
              style: TextStyle(
                fontFamily: 'Hiragino Kaku Gothic ProN',
                color: Colors.black,
              )),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: <Widget>[
            LayoutBuilder(builder: (context, constraints) {
              if (!products.isEmpty) {
                return Container(
                  height:  ScreenHight- ScreenHight * .1-appbarhight-statusbarhight,
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(15),
                          child: GestureDetector(
                            onTapUp:(details){
                              showCustomMenu(details,context,products[index]);
                            } ,
                            child: Container(
                              height: ScreenHight * .1,
                              color: Ksecondary,
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(products[index].Location),
                                    radius: ScreenHight * .1 / 2,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                products[index].Name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                '\$ ${products[index].Price}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            '${products[index].Quantity.toString()}Q',
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: products.length),
                );
              } else {
                return Container(
                  height: ScreenHight- ScreenHight * .1-appbarhight-statusbarhight,
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    'the your cart is Empty'.toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
                );
              }
            }),
            Builder(
              builder:(context)=> ButtonTheme(
                minWidth: ScreenWidth,
                height: ScreenHight * .1,
                child: RaisedButton(
                  onPressed: () {
                    showCustomDialog(context,products);
                  },
                  child: Text(
                    'Order',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  color: Kmaincolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                ),
              ),
            )
          ],
        ));
  }

  void showCustomMenu(TapUpDetails details, BuildContext context,Product product)  async {

    double dx = details.globalPosition.dx ;//left
    double dy = details.globalPosition.dy ;//top
    double dx2= MediaQuery.of(context).size.width - dx ; //right
    double dy2 =MediaQuery.of(context).size.height -dy ; //bottom

    await showMenu(context: context,
    position:RelativeRect.fromLTRB(dx, dy, dx2, dy2),
    items:[
    MyPopupMenuItem(
    Onclick: (){
      Navigator.pop(context);
      Provider.of<CardItem>(context,listen: false).RemoveProductFromCart(product);
      Navigator.pushNamed(context, ProductInfo.id,arguments: product);

    },
    child: Text('Edit'),),
    MyPopupMenuItem(
    Onclick:(){
      Navigator.pop(context);
      Provider.of<CardItem>(context,listen: false).RemoveProductFromCart(product);

    } ,
    child: Text('Delete'),
    )
    ]
    );

  }

  void showCustomDialog(BuildContext context, List<Product> products) async {
    String adress='';

    var Price = getTotelPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        MaterialButton(
            onPressed: (){
              try{
              Store stor = Store();
              stor.storOrder({
                KtotalPrice:Price,
                KAdress: adress
              }, products);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Order SuccessFully'),));
              Navigator.pop(context);
            }catch(ex){
                print(ex.toString());
              }
            }
            ,child: Text('Confirm '),
            )
      ],
      title: Text('Totel Price is \$$Price',style: TextStyle(fontSize: 16 ),),
      content: TextField(
        onChanged:(value){
          adress=value;
        },
        decoration: InputDecoration(hintText:'Enter your address'),
      ) ,

    );
     await showDialog(context: context, builder :(context){
      return alertDialog;
    });
     {

    }
  }

  getTotelPrice(List<Product> products) {
    var price =0;
    for(var product in products)
      {
      price += product.Quantity *int.parse(product.Price) ;
      }
    return price;
  }
}
