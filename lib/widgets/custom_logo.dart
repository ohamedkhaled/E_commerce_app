import 'package:flutter/cupertino.dart';



class CustomLogo extends StatelessWidget {
  const CustomLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top:40),
        child: Container(
          height: MediaQuery.of(context).size.height*.2,
          child:Stack(
            alignment:Alignment.center,
            children: <Widget>[
              Image(image:AssetImage('images/icons/buyicon.png')),
              Positioned(
                bottom: 0,
                child: Text('Buy it' ,style: TextStyle(fontFamily:'Pacifico',fontSize: 25)  ) ,
              )
            ],
          ) ,
        )
    );
  }
}
