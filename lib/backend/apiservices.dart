import 'dart:convert';
import 'package:cart/Model/ProductModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class ApiService extends ChangeNotifier {
  int counter =0;
  bool isFirstTime = true;
  double totalPrice = 0;
  int quantity = 0;
  int getQuantity() => quantity;
  int getCounter() => counter;
  double getTotalPrice() => totalPrice;
  List<int> quantityList = [];
  List<ProductModel> listOfProducts = [];
  List<ProductModel> cartItemList = [];
  String api_url = 'https://fakestoreapi.com/products';

  Future<List<ProductModel>> fetchData ()async{
    final http.Response response = await http.get(Uri.parse(api_url));
    var data = jsonDecode(response.body.toString());
    for(Map i in data) {
      listOfProducts.add(ProductModel.fromJson(i));
    }
    return listOfProducts;
  }
  void increaseQuantity(double p,int index){
    quantityList[index]+=1;
    totalPrice+=p;
    notifyListeners();
  }
  void decreaseQuantity(double p,int index){
    quantityList[index]-=1;
    if(totalPrice != 0){
      totalPrice-=p;
    }
    notifyListeners();
  }
  void addProductToCart(ProductModel product){
    if(isFirstTime){
      quantityMethod();
      isFirstTime = false;
    }
    if(!cartItemList.contains(product)){
    cartItemList.add(product);
    counter++;
    updatePrice(product.price!.toInt());
    }
    notifyListeners();
  }
  void updatePrice(int p){
    totalPrice+=p;
  }
  void quantityMethod(){
    for (int i=0;i<100;i++) {
      quantityList.add(1);
    }
  }
}
