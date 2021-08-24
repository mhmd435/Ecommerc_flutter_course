import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Model/SpecialOfferModel.dart';
import 'dart:convert';


class singleproduct extends StatelessWidget {
  List<String> imgUrls = [];
  List<String> productTitles = [];
  List<String> ProductPrice = [];

  SpecialOfferModel specialOfferModel;


  singleproduct(this.specialOfferModel);


  @override
  Widget build(BuildContext context) {
    getDataDromPrefs();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("کالا",style: TextStyle(fontFamily: "Vazir"),),

      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Image.network(specialOfferModel.imgUrl,fit: BoxFit.fill,width: 300,),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(specialOfferModel.productName,style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(specialOfferModel.price.toString(),style: TextStyle(fontSize: 20,color: Colors.red),),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width - 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                      onPressed: (){
                        SaveDataToSP();
                      },
                      child: Text("افزودن به سبد خرید"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getDataDromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    imgUrls = prefs.getStringList("imgUrls") ?? [];
    productTitles = prefs.getStringList("productTitles") ?? [];
    ProductPrice = prefs.getStringList("ProductPrice") ?? [];

    for(String name in ProductPrice){
      print(name);
    }

  }


  Future<void> SaveDataToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    imgUrls.add(specialOfferModel.imgUrl);
    productTitles.add(specialOfferModel.productName);
    ProductPrice.add(specialOfferModel.price.toString());

    prefs.setStringList("imgUrls", imgUrls);
    prefs.setStringList("productTitles", productTitles);
    prefs.setStringList("ProductPrice", ProductPrice);

  }
}

