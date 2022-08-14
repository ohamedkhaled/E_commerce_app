import 'package:e_commerce/Provider/adminhud.dart';
import 'package:e_commerce/Provider/cardItem.dart';
import 'package:e_commerce/Screens/Admin/addproduct.dart';
import 'package:e_commerce/Screens/Admin/adminhome.dart';
import 'package:e_commerce/Screens/Admin/editproduct.dart';
import 'package:e_commerce/Screens/Admin/manageproduct.dart';
import 'package:e_commerce/Screens/Admin/orderdetails.dart';
import 'package:e_commerce/Screens/Admin/orderscreen.dart';
import 'package:e_commerce/Screens/User/CardScreen.dart';
import 'package:e_commerce/Screens/User/productinfo.dart';
import 'package:e_commerce/constans.dart';
import 'package:e_commerce/widgets/custom_logo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Provider/modulHud.dart';
import 'Provider/switch.dart';
import 'Screens/User/login_screen.dart';
import 'Screens/User/sinup_screen.dart';
import 'Screens/User/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool IsUserLogin=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return MaterialApp(
              home: Scaffold(
                backgroundColor: Kmaincolor,
                body: Center( child: CustomLogo() ),
              ),
            );
          } else {
            IsUserLogin=snapshot.data!.getBool(KKeepUserLogin) ?? false ;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => AdminHud()),
                ChangeNotifierProvider(create: (context) => ModelHud()),
                ChangeNotifierProvider(create: (context) => AdminModul()),
                ChangeNotifierProvider(create: (context) => CardItem()),
              ],
                  child: MaterialApp(
                  initialRoute: IsUserLogin ? ScreenHome.id : LoginScreen.id,
                  routes: {
                OrderScreen.id: (context) => OrderScreen(),
                OrderDetails.id: (context) => OrderDetails(),
                LoginScreen.id: (context) => LoginScreen(),
                SinupScreen.id: (context) => SinupScreen(),
                AdminHome.id: (context) => AdminHome(),
                ScreenHome.id: (context) => ScreenHome(),
                ManageProduct.id: (context) => ManageProduct(),
                AddProduct.id: (context) => AddProduct(),
                EditProduct.id: (context) => EditProduct(),
                ProductInfo.id: (context) => ProductInfo(),
                CardScreen.id: (context) => CardScreen(),
              }),
            );
          }
        });
  }
}

