import 'package:flutter/material.dart';

class MyPopupMenuItem<T> extends PopupMenuItem<T>{
  final Function Onclick ;
  MyPopupMenuItem( {required this.Onclick, @required Widget? child}) : super(child: child);



  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return MyPopupMenuItemState() ;

  }
}

class MyPopupMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T, MyPopupMenuItem<T>> {


  @override
  void handleTap() {
    widget.Onclick();
  }
}