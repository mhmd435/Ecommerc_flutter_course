import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:untitled/BottomNav.dart';
import 'package:untitled/singleProduct.dart';

import 'GoogleMaps.dart';
import 'Model/SpecialOfferModel.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  _AllProductState createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {

  late Future<List<SpecialOfferModel>> SpecialofferFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SpecialofferFuture = SendRequestSpecialOffer();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNav(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text("فروشگاه",style: TextStyle(fontFamily: "Vazir"),),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GoogleMaps()));
            }, icon: Icon(Icons.map))
          ],
        ),
        body: Container(
          child: FutureBuilder<List<SpecialOfferModel>>(
            future: SpecialofferFuture,
            builder: (context ,snapshot){
              if(snapshot.hasData){
                List<SpecialOfferModel>? model = snapshot.data;

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: List.generate(model!.length, (index) => generateItem(model[index])),
                  ),
                );
              }else{
                return Center(
                  child: JumpingDotsProgressIndicator(
                    fontSize: 60,
                    dotSpacing: 5,
                  ),
                );
              }
            },
          ),
        ));
  }

  InkWell generateItem(SpecialOfferModel specialOfferModel){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => singleproduct(specialOfferModel)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        elevation: 10,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: 90,
                  height: 90,
                  child: Image.network(specialOfferModel.imgUrl),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(specialOfferModel.productName),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(specialOfferModel.price.toString()),
              ),

            ],
          )
        ),
      ),
    );
  }

  Future<List<SpecialOfferModel>> SendRequestSpecialOffer() async {
    List<SpecialOfferModel> models = [];

    var response = await Dio().get(
        "http://besenior.ir/flutter_ecom_project/Specialoffer/specialOffer.json");

    for (var item in response.data["product"]) {
      models.add(SpecialOfferModel(
          item["id"],
          item["product_name"],
          item["price"],
          item["off_price"],
          item["off_precent"],
          item["imgUrl"]));
    }

    return models;
  }
}
