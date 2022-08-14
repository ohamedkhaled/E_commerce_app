import 'package:e_commerce/Screens/User/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Provider/modulHud.dart';
import '../../constans.dart';
import '../../widgets/custom_logo.dart';
import '../../widgets/custom_textfield.dart';
import 'login_screen.dart';
import 'package:e_commerce/Services/auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class SinupScreen extends StatelessWidget {
 final GlobalKey<FormState> _globalKey =GlobalKey<FormState>();
 final auth= Auth();
 late String email,pass ;
static String id ='SignupScreen';
  @override
Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    return Scaffold(
     backgroundColor: Kmaincolor,
     body:ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isloading,
        child:Form(
          key: _globalKey,
          child:ListView(
              children: <Widget>[
          CustomLogo(),
          SizedBox( height: height*0.1 ),
          CustomTextField((value){  } ,'Enter your Name', Icons.perm_identity ),
          SizedBox( height: height*0.02 ),
          CustomTextField((value){ email=value! ;} , 'Enter your  Email', Icons.email),
          SizedBox( height: height*0.02 ),
          CustomTextField((value){ pass=value! ;}, 'Enter your Password', Icons.password),
          SizedBox( height: height*0.1 ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child:   Builder(
              builder:(context) => FlatButton(
                onPressed:() async
                {
                  final modulhud = Provider.of<ModelHud>(context,listen: false);
                  modulhud.chngIsloading(true);
                  if(_globalKey.currentState!.validate()){
                    _globalKey.currentState!.save();
                    try{
                     final AuthResult = await  auth.Signup(email.trim(), pass.trim());
                     modulhud.chngIsloading(false);
                     print(AuthResult.user?.uid);
                     Navigator.pushNamed(context, ScreenHome.id);
                     } on FirebaseAuthException catch(e){
                        modulhud.chngIsloading(false);
                        print(e.toString());
                        Scaffold.of(context).showSnackBar(SnackBar( content: Text(e.message.toString())));
                    }
                  }
                  modulhud.chngIsloading(false);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                color: Colors.black,
                child: Text('Signup',
                  style: TextStyle(
                      color: Colors.white
                  ),
                )
            ),
          ),
          ),
           SizedBox( height: height*0.01 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Do  have an account ? ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),

              ),
              GestureDetector(
                  onTap: (){ Navigator.pushNamed(context, LoginScreen.id); },
                  child :Text('Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  )
              )
            ],
          )

        ]
    ),
     )
     )
  );
  }
}
