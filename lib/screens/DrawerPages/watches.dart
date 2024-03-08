import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/models/watchModel.dart';
import 'package:watch_admin/screens/AddForms/new_products.dart';
import 'package:watch_admin/screens/watch_detail.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';

class Watches extends StatefulWidget {
  @override
  _WatchesState createState() => _WatchesState();
}

class _WatchesState extends State<Watches> {
  TextEditingController editingController = new TextEditingController();
  List<watchModel> list,list1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  getdata(){
    var authstate = Provider.of<AuthState>(context,listen: false);
    var state = Provider.of<FeedState>(context,listen: false);
   setState(() {

     list = state.getWatches(
         authstate.userModel);
     list1=list;
   });
  }
  @override
  Widget build(BuildContext context) {


    var state = Provider.of<FeedState>(context,listen: false);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primary,
          title: Text("Watches", style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: editingController,
                onChanged: (value) {
                  setState(() {
if(value.isNotEmpty) {
  list = list
      .where((x) =>
  x.title != null &&
      x.title.toLowerCase().contains(value.toLowerCase()))
      .toList();
}
else{
  list=list1;
}
                  });
                  print(list);
                },
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: list==null?0:list.length,
                    itemBuilder: (context, index) {
                      return WidgetAnimator(
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 18.0, right: 18.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) =>WatchDetail(feed: list[index])));

                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  child: Image.network(list[index].imagePath),
                                ),
                                title: Text(list[index].title),
                                subtitle: Text(list[index].user.displayName),
                                trailing: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(
                                    children: [
                                      IconButton(icon: Icon(
                                        Icons.delete, color: Colors.red,),
                                          onPressed: () {  SweetAlert.show(context,
                                              title: "Delete",
                                              subtitle: "Are you sure you want to delete this?",
                                              style: SweetAlertStyle.confirm,
                                              showCancelButton: true, onPress: (bool isConfirm) {
                                                if (isConfirm) {
                                                  setState(() {

                                                    state.deleteWatch(list[index]);
                                                    SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                                    // return false to keep dialog
                                                    return false;
                                                  });
                                                }
                                              });}),
                                      SizedBox(width: 10,),
                                      // IconButton(icon: Icon(
                                      //   Icons.edit, color: Colors.green,),
                                      //     onPressed: () {    Navigator.push(
                                      //         context, MaterialPageRoute(builder: (context) =>UpdateWatch(watch: list[index],)));
                                      //     }),
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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => AddProducts()));
        //   },
        //   backgroundColor: Colors.green,
        //   child: Icon(Icons.add, color: Colors.white,),
        // ),
      );
   // });

  }
}
