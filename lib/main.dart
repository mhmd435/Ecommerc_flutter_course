import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Model/EventsModel.dart';
import 'Model/PageViewModel.dart';
import 'Model/SpecialOfferModel.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late Future<List<PageViewModel>> pageViewFuture;
  late Future<List<SpecialOfferModel>> SpecialofferFuture;
  late Future<List<EventsModel>> EventsFuture;


  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = SendRequestPageView();
    SpecialofferFuture = SendRequestSpecialOffer();
    EventsFuture = SendRequestEvents();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("Digikala"),
        backgroundColor: Colors.red,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 250,
                child: FutureBuilder<List<PageViewModel>>(
                  future: pageViewFuture,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      List<PageViewModel>? model = snapshot.data;

                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                              controller: pageController,
                              allowImplicitScrolling: true,
                              itemCount: model!.length,
                              itemBuilder: (context, position){
                                return PageViewItems(model[position]);
                              }
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SmoothPageIndicator(
                                controller: pageController,
                                count: model.length,
                                effect: ExpandingDotsEffect(
                                    dotWidth: 10,
                                    dotHeight: 10,
                                    spacing: 3,
                                    dotColor: Colors.white,
                                    activeDotColor: Colors.red),
                                // your preferred effect
                                onDotClicked: (index) =>
                                    pageController.animateToPage(index,
                                        duration: Duration(microseconds: 500),
                                        curve: Curves.bounceOut)
                            ),
                          )
                        ],
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  color: Colors.red,
                  height: 300,
                  child: FutureBuilder<List<SpecialOfferModel>>(
                    future: SpecialofferFuture,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SpecialOfferModel>? model = snapshot.data;

                        return ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: model!.length,
                            itemBuilder: (context, position){
                              if(position == 0){
                                return Container(
                                  height: 300,
                                  width: 200,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15,left: 10,right: 10),
                                        child: Image.asset("images/pic0.png",height: 230,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Expanded(
                                          child: OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                side: BorderSide(color: Colors.white),
                                              ),
                                              onPressed: (){},
                                              child: Text("مشاهده همه",style: TextStyle(color: Colors.white),)),
                                        ),
                                      )

                                    ],
                                  ),
                                );
                              }else{
                                return SpecialofferItem(model[position - 1]);
                              }
                            }
                        );
                      } else {
                        return Center(
                            child: JumpingDotsProgressIndicator(
                              fontSize: 60,
                              dotSpacing: 5,
                            ));
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 500,
                width: double.infinity,
                child: FutureBuilder<List<EventsModel>>(
                  future: EventsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventsModel>? model = snapshot.data;

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(model![0].imgUrl,fit: BoxFit.fill,width: 210,)),
                                ),
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(model[1].imgUrl,fit: BoxFit.fill,width: 210,)),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(model[2].imgUrl,fit: BoxFit.fill,width: 210,)),
                                ),
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(model[3].imgUrl,fit: BoxFit.fill,width: 210,)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                          child: JumpingDotsProgressIndicator(
                            fontSize: 60,
                            dotSpacing: 5,
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container SpecialofferItem(SpecialOfferModel specialOfferModel){
    return Container(
      width: 200,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Container(
          width: 200,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(specialOfferModel.imgUrl,height: 150,fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(specialOfferModel.productName),
              ),
              Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(specialOfferModel.off_price.toString() + "T",style: TextStyle(fontSize: 20),),
                              Text(specialOfferModel.price.toString() + "T",style: TextStyle(fontSize: 15,decoration: TextDecoration.lineThrough),),
                            ],
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(bottom: 10, right: 10),
                              child: Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      specialOfferModel.off_precent.toString() +
                                          "%",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  )),
                            )),
                      ],
                    ),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<EventsModel>> SendRequestEvents() async {
    List<EventsModel> models = [];

    var response = await Dio()
        .get("http://besenior.ir/flutter_ecom_project/Events/Events.json");

    for (var item in response.data["product"]) {
      models.add(EventsModel(item["imgUrl"]));
    }

    return models;
  }

  Future<List<PageViewModel>> SendRequestPageView() async{
    List<PageViewModel> model = [];

    var response = await Dio().get("http://besenior.ir/flutter_ecom_project/pageViewAsset/pageViewPics.json");

    for(var item in response.data['photos']){
      model.add(PageViewModel(item['id'],item['imgUrl']));
    }

    return model;
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


  Padding PageViewItems(PageViewModel pageViewModel){
    return Padding(
      padding: const EdgeInsets.only(top: 10,left: 5,right: 5),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(pageViewModel.imgurl,fit: BoxFit.fill,)),
      ),
    );
  }


}

