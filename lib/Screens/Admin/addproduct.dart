import 'package:e_commerce/Provider/adminhud.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/Services/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/models/productmodel.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_textfield.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  late String name, price, description, category, imagelocation;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Store _store = Store();
  @override
  Widget build(BuildContext context) {
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
                      _store.addProduct(Product(
                          Name: name,
                          Price: price,
                          Discription: description,
                          Category: category,
                          Location: imagelocation));
                          adminhud.chngIsSuccess(false);
                      Scaffold.of(context).showSnackBar(SnackBar( content: Text('upload Successfully')));

                    }
                   adminhud.chngIsSuccess(false);
                  },
                  child: Text('Add Product', style: TextStyle(color: Colors.white)),
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
