import 'package:flutter/cupertino.dart';

class AdminModul extends ChangeNotifier
{
  bool isAdmin =false ;

  chndisAdmin( bool value)
  {
    isAdmin=value;
    notifyListeners();
  }

}