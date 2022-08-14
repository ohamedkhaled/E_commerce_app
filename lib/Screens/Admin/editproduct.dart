

import 'package:e_commerce/models/productmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../Provider/adminhud.dart';
import '../../Services/store.dart';
import '../../constans.dart';
import '../../widgets/custom_textfield.dart';

class EditProduct extends StatelessWidget
{
  static String id = 'Editproduct';
  late String name, price, description, category, imagelocation;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  Store _store = Store();
  @override
  Widget build(BuildContext context) {
    Product product =ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      backgroundColor: Kmaincolor,
      body: ModalProgressHUD(
        inAsyncCall:Provider.of<AdminHud>(context).isSuccess,
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField.Hint(
                'Product Name',
                onClick: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 10),
              CustomTextField.Hint('Product Price', onClick: (value) {
                price = value!;
              }),
              SizedBox(height: 10),
              CustomTextField.Hint('Product Discription', onClick: (value) {
                description = value!;
              }),
              SizedBox(height: 10),
              CustomTextField.Hint('Product Category', onClick: (value) {
                category = value!;
              }),
              SizedBox(height: 10),
              CustomTextField.Hint('Product Location', onClick: (value) {
                imagelocation = value!;
              }),
              SizedBox(height: 20),
              Builder(
                builder: (context)=>RaisedButton(
                  onPressed: () {
                    final adminhud = Provider.of<AdminHud>(context,listen: false);
                    adminhud.chngIsSuccess(true);
                    if (globalKey.currentState!.validate()) {
                       globalKey.currentState!.save();
                       _store.updataproduct(( {KProductName :  name,
                       KProductDescription:description ,
                       KProductPrice :price,
                       KProductCategory :category,
                           KProductLocation : imagelocation }), product.id);



                      adminhud.chngIsSuccess(false);
                      Scaffold.of(context).showSnackBar(SnackBar( content: Text('upload Successfully')));
                    }
                    adminhud.chngIsSuccess(false);
                  },
                  child: Text('Edit Product', style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}