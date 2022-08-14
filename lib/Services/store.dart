import 'package:e_commerce/constans.dart';
import 'package:e_commerce/models/productmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  addProduct(Product product) {
    firestore.collection(KProductCollection).add(
        {KProductName: product.Name,
          KProductCategory: product.Category,
          KProductDescription: product.Discription,
          KProductPrice: product.Price,
          KProductLocation: product.Location
        });
  }

  Stream<QuerySnapshot> loadProduct() {
    return firestore.collection(KProductCollection).snapshots();
  }
  Stream<QuerySnapshot> orderProduct(){
    return firestore.collection(Korders).snapshots();
  }
  Stream<QuerySnapshot> orderDetailsProduct( documentId){
    return firestore.collection(Korders).doc(documentId).collection(KordersDetails).snapshots();
  }
  
  deleteproduct(documentId){
    firestore.collection(KProductCollection).doc(documentId).delete();
  }

  updataproduct(data, documentId){
    firestore.collection(KProductCollection).doc(documentId).update(data);
  }
  storOrder(data, List<Product> products ){
    var  documentRef = firestore.collection(Korders).doc();
     documentRef.set(data);

     for(var  product in products ){
       documentRef.collection(KordersDetails).doc().set({
        KProductName: product.Name,
         KProductPrice:product.Price,
         KProductLocation:product.Location,
         KProductQuantity:product.Quantity,
         KProductCategory:product.Category
       });
     }

  }


  // Future<List<Product>> tes() async {
  //   List<Product> product = [];
  //   var snapshot = await firestore.collection(KProductCollection).get();
  //   for (var doc in snapshot.docs) {
  //     var data = doc.data();
  //     product.add(Product(Name: data[KProductName],
  //         Price: data[KProductPrice],
  //         Discription: data[KProductDescription],
  //         Category: data[KProductCategory],
  //         Location: data[KProductLocation]));
  //   }
  //
  //   return product;
  // }

}





