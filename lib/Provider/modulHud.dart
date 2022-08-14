
import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier
{
  bool isloading =false ;

  chngIsloading(bool value  )
  {
    isloading=value;
    notifyListeners();
  }
}