
import 'package:flutter/cupertino.dart';

import '../models/productmodel.dart';

class CardItem extends ChangeNotifier
{
List<Product> productCard =[];

AddProductToCard(Product product ) {

productCard.add(product);
notifyListeners();
}

RemoveProductFromCart(product ){

  productCard.remove(product);
  notifyListeners();
}
}