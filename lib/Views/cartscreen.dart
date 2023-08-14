import 'package:cart/backend/apiservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart'),centerTitle: true,),
      body: Consumer<ApiService>(
        builder: (context,productsData,Widget? child){
          return Column(
             children: [
               Expanded(
                 child: ListView.builder(
                     itemCount: productsData.cartItemList.length,
                     itemBuilder: (context,index){
                       return Card(
                         child:Padding(
                           padding: const EdgeInsets.all(10),
                           child: Row(
                             children: [
                               Image(
                                 height: MediaQuery.of(context).size.height * .2,
                                 width: MediaQuery.of(context).size.width * .4,
                                 image: NetworkImage(productsData.cartItemList[index].image.toString()),
                                 fit: BoxFit.fill,
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
                                           productsData.cartItemList[index].title.toString(),
                                           style: const TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 20,
                                           ),
                                         ),
                                         SizedBox(
                                           height: MediaQuery.of(context).size.height * .03,
                                         ),
                                         Text(
                                           ("Price: ${productsData.cartItemList[index].price}\$"),
                                           style: const TextStyle(
                                             fontWeight: FontWeight.bold,
                                             fontSize: 20,
                                           ),
                                         ),
                                         SizedBox(
                                           height: MediaQuery.of(context).size.height * .03,
                                         ),
                                         Container(
                                           height: MediaQuery.of(context).size.height * .04,
                                           decoration: const BoxDecoration(
                                             color: Colors.lightBlue,
                                           ),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             children: [
                                               IconButton(onPressed: (){
                                                 productsData.increaseQuantity(productsData.cartItemList[index].price!.toDouble(),index);
                                               },
                                                   icon: const Icon(CupertinoIcons.add_circled)),
                                               Text(productsData.quantityList[index].toString(),style: const TextStyle(fontSize: 20),),
                                               IconButton(
                                                   onPressed: (){
                                                     productsData.decreaseQuantity(productsData.cartItemList[index].price!.toDouble(),index);
                                                   },
                                                   icon: const Icon(CupertinoIcons.minus_circle)),
                                             ],
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
               ),
               Container(
                 height: MediaQuery.of(context).size.height * .06,
                 width: MediaQuery.of(context).size.width * 1,
                 decoration: const BoxDecoration(
                   color: Colors.blueGrey
                 ),
                 child: Expanded(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         const Text('Subtotal: ',
                           style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Text(
                             "${productsData.getTotalPrice().toString()} \$",
                           style: const TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold,
                           ),
                         ),

                       ],
                     ),
                   ),
                 ),
               )
             ],
          );
        },
      ),
    );
  }
}
