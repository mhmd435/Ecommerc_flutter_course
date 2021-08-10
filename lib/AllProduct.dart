import 'package:flutter/material.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text("فروشگاه"),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.map))
          ],
        ),
        body: Container());
  }
}
