import 'package:cart/Model/ProductModel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DbHelper extends HiveObject{
  Box<ProductModel> box = Hive.box('cart');
}