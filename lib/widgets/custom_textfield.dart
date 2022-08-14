import 'package:flutter/material.dart';
import '../constans.dart';



class CustomTextField extends StatelessWidget {

  String? hint ;
  IconData? icon ;
  String?  Function(String?) onClick;


  String _errmesg(String str){
      switch(hint)
      {
        case 'Enter your Name' :return 'Name is empty!';
        case 'Enter your Email' :return 'Email is empty!';
        case 'Enter your Password' :return 'Password is empty!';
        case 'Product Name' :return 'Product Name is empty!';
        case 'Product Price' :return 'Product Price is empty!';
        case 'Product Discription' :return 'Product Discription is empty!';
        case 'Product Category' :return 'Product Category is empty!';
        case 'Product Location' :return 'Product Location is empty!';

      }
     return "";
  }
  CustomTextField( this.onClick , this.hint,this.icon);
  CustomTextField.Hint(String Hint,{required this.onClick} ){ hint=Hint; }

  @override
  Widget build(BuildContext context) {

    return Padding( padding: const EdgeInsets.symmetric(horizontal: 25),
        child:TextFormField(
          validator: (value)
          {
            if(value!.isEmpty)
            {
              return _errmesg(hint!);
            }
          } ,
          onSaved: onClick,
          obscureText: hint=='Enter your Password'?true :false,
          cursorColor: Kmaincolor,
          decoration: InputDecoration(
              hintText: hint,
              prefixIcon: Icon(
                icon,
                color: Kmaincolor,

              ),
              filled: true,
              fillColor:Ksecondary,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.white
                  )
              ),
            border:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),

          ),

        )
    );
  }


}