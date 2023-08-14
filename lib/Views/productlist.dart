import 'package:cart/Model/ProductModel.dart';
import 'package:cart/backend/apiservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as b;
import 'package:provider/provider.dart';

import 'cartscreen.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
        return  Consumer<ApiService>(
          builder: (BuildContext context, productsData, Widget? child) => Scaffold(
          appBar: AppBar(
            title: const Text('Products List'),
            centerTitle: true,
            actions: [
              Center(
                child: b.Badge(
                  badgeContent: Text(productsData.counter.toString()),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartScreen()));
                    },
                      child: const Icon(CupertinoIcons.shopping_cart)),
                ),
              ),
              const SizedBox(width: 20,),
            ],
          ),
          body:Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                      future: productsData.fetchData(),
                      builder: (context,AsyncSnapshot<List<ProductModel>> snapshot){
                        if(snapshot.hasData)
                        {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    height: MediaQuery.of(context).size.height * .3,
                                    width: MediaQuery.of(context).size.width * .8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Image(
                                              height: MediaQuery.of(context).size.height * .3,
                                              width: MediaQuery.of(context).size.width * .5,
                                              image: NetworkImage(snapshot.data![index].image.toString()),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data![index].title.toString(),
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.of(context).size.height * .03,
                                                    ),
                                                    Text(
                                                      ("Price: ${snapshot.data![index].price}\$"),
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.of(context).size.height * .03,
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        productsData.addProductToCart(snapshot.data![index]);
                                                      },
                                                      child: Container(
                                                        height: MediaQuery.of(context).size.height * .04,
                                                        decoration: const BoxDecoration(
                                                          color: Colors.green,
                                                        ),
                                                        child: const Center(
                                                          child: Text('Add To Cart'),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                        else{
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                  ),
                )
              ],
            ),
          ),
        );
  }
}
