import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'Model/PageViewModel.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pageViewFuture = SendRequestPageView();
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
              color: Colors.amber,
              child: FutureBuilder<List<PageViewModel>>(
                future: pageViewFuture,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Container(
                      height: 200,
                      color: Colors.red,
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
            )
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


}

