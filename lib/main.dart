import 'package:cart/Model/ProductModel.dart';
import 'package:cart/Views/productlist.dart';
import 'package:cart/backend/apiservices.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main()async {
  await Hive.initFlutter();
  Box<ProductModel> box = await Hive.openBox('cart');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ApiService())
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const ProductListScreen(),
      ),
    );
  }
}
