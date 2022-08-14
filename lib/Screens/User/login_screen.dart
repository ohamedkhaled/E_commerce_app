import 'package:e_commerce/Provider/switch.dart';
import 'package:e_commerce/Screens/Admin/adminhome.dart';
import 'package:e_commerce/Screens/User/home_screen.dart';
import 'package:e_commerce/Screens/User/sinup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:e_commerce/Screens/Admin/adminhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/constans.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../Provider/modulHud.dart';
import '../../widgets/custom_logo.dart';
import '../../widgets/custom_textfield.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreen createState() => _LoginScreen();

}

  class _LoginScreen extends State<LoginScreen> {
    final auth = Auth();
    static String id = 'LoginScreen';
    late String email, pass;
    final adminpass = 'ad123456';
    bool?  KeepInLogin= false;
    LoginScreen loginScreen =LoginScreen();

    @override
    Widget build(BuildContext context) {
      double height = MediaQuery
          .of(context)
          .size
          .height;
      return Scaffold(
          backgroundColor: Kmaincolor,
          body: ModalProgressHUD(
              inAsyncCall: Provider
                  .of<ModelHud>(context)
                  .isloading,
              child: Form(
                key: loginScreen.globalKey,
                child: ListView(
                    children: <Widget>[
                      CustomLogo(),
                      SizedBox(height: height * 0.1),
                      CustomTextField((value) {
                        email = value!;
                      }, 'Enter your Email', Icons.email),
                      SizedBox(height: height * 0.02),
                      CustomTextField((value) {
                        pass = value!;
                      }, 'Enter your Password', Icons.password),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: <Widget>[
                            Checkbox(
                              focusColor: Colors.black,
                              checkColor:Ksecondary,
                              activeColor: Kmaincolor,
                              value: KeepInLogin,
                              onChanged: (bool? value) {

                                setState(() {
                                  KeepInLogin= value ;
                                });
                              },

                            ),
                            Text('Remmeber My',style: TextStyle(fontWeight: FontWeight.w800,fontStyle: FontStyle.italic ),)
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120),
                        child: Builder(
                          builder: (context) =>
                              FlatButton(
                                  onPressed: () async
                                  {
                                    if(KeepInLogin==true){
                                      KeepUserLogin();
                                    }
                                    _Validate(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  color: Colors.black,
                                  child: Text('Login',
                                    style: TextStyle(
                                        color: Colors.white
                                    ),
                                  )
                              ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Don\'t have an account ? ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),

                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, SinupScreen.id);
                              },
                              child: Text('SinUp',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                ),
                              )
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<AdminModul>(
                                        context, listen: false).chndisAdmin(
                                        true);
                                  },
                                  child: Text('I am an admen',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Provider
                                            .of<AdminModul>(context)
                                            .isAdmin ? Kmaincolor : Colors.white
                                    ),

                                  ),
                                )
                            ),
                            Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Provider.of<AdminModul>(
                                        context, listen: false).chndisAdmin(
                                        false);
                                  },
                                  child: Text('I am a user',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Provider
                                            .of<AdminModul>(context)
                                            .isAdmin ? Colors.white : Kmaincolor
                                    ),
                                  ),
                                )
                            )
                          ],

                        ),
                      )

                    ]
                ),
              )
          )
      );
    }


    Future<void> _Validate(BuildContext context) async {
      final modelhud = Provider.of<ModelHud>(context, listen: false);
      modelhud.chngIsloading(true);
      if (loginScreen.globalKey.currentState!.validate()) {
        loginScreen.globalKey.currentState!.save();
        if (Provider
            .of<AdminModul>(context, listen: false)
            .isAdmin) {
          if (pass == adminpass) {
            try {
              await auth.Signin(email.trim(), pass.trim());
              modelhud.chngIsloading(false);
              Navigator.pushNamed(context, AdminHome.id);
            } on FirebaseAuthException catch (e) {
              modelhud.chngIsloading(false);
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text(e.message.toString())));
            }
          } else {
            modelhud.chngIsloading(false);
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('password is wrong!.')));
          }
        } else {
          try {
            await auth.Signin(email.trim(), pass.trim());
            modelhud.chngIsloading(false);
            Navigator.pushNamed(context, ScreenHome.id);
          } on FirebaseAuthException catch (e) {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text(e.message.toString())));
            modelhud.chngIsloading(false);
          }
        } //user
      }


      modelhud.chngIsloading(false);
    }

  void KeepUserLogin() async {

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool(KKeepUserLogin, KeepInLogin!);
  }

  }



