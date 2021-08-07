import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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


  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = SendRequestPageView();
    SpecialofferFuture = SendRequestSpecialOffer();

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
      body: Container(
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
                              return Container(
                                width: 200,
                              );
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
          ],
        ),
      ),
    );
  }


  Future<List<PageViewModel>> SendRequestPageView() async{
    List<PageViewModel> model = [];

    var response = await Dio().get("http://besenior.ir/flutter_ecom_project/pageViewAsset/pageViewPics.json");
    print(response);

    for(var item in response.data['photos']){
      model.add(PageViewModel(item['id'],item['imgUrl']));
    }

    return model;
  }

  Future<List<SpecialOfferModel>> SendRequestSpecialOffer() async {
    List<SpecialOfferModel> models = [];

    var response = await Dio().get(
        "http://besenior.ir/flutter_ecom_project/Specialoffer/specialOffer.json");

    print(response.data);
    print(response.statusCode);

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

