import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/new_news.dart';
import 'package:watch_admin/state/feedState.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  TextEditingController editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    var state = Provider.of<FeedState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("News",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: state.newslist==null?0:state.newslist.length,
                  itemBuilder: (context,index){
                    return WidgetAnimator(
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,right: 18.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network(state.newslist[index].image,height: 100,),
                              ),
                              title: Text(state.newslist[index].description),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
                                      SweetAlert.show(context,
                                        title: "Delete",
                                        subtitle: "Are you sure you want to delete this?",
                                        style: SweetAlertStyle.confirm,
                                        showCancelButton: true, onPress: (bool isConfirm) {
                                          if (isConfirm) {
                                            setState(() {
                                              state.deleteNews(state.newslist[index]);
                                              SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                              // return false to keep dialog
                                              return false;
                                            });

                                          }
                                        });}),
                                    SizedBox(width: 10,),
                                    IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewNews(
                                        isEdit:true,
                                        news: state.newslist[index],
                                      )));
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    );
                  })
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewNews(isEdit: false,)));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
