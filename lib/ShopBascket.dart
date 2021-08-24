import 'package:flutter/material.dart';
import 'package:untitled/BottomNav.dart';

class ShopBascket extends StatefulWidget {
  const ShopBascket({Key? key}) : super(key: key);

  @override
  _ShopBascketState createState() => _ShopBascketState();
}

class _ShopBascketState extends State<ShopBascket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,),
      bottomNavigationBar: BottomNav(),
      body: Container(),
    );
  }
}
