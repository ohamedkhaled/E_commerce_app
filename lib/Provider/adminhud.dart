import 'package:flutter/cupertino.dart';

class AdminHud extends ChangeNotifier {
  bool isSuccess = false;

  chngIsSuccess(bool value) {
    isSuccess = value;
    notifyListeners();
  }
}
