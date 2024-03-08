import 'dart:io';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/slider_add.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/appState.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class QueryScreen extends StatefulWidget {
  @override
  _QueryScreenState createState() => _QueryScreenState();
}

class _QueryScreenState extends State<QueryScreen> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loader = true;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getqueries();
  }
getqueries(){


  var adminstate = Provider.of<AdminState>(context, listen: false);
  var searchstate = Provider.of<SearchState>(context, listen: false);

  adminstate.getqueries(searchstate.userlist);
}




  @override
  Widget build(BuildContext context) {

    return Consumer<AdminState>(builder: (context, state, child) {

      return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          centerTitle: true,
          backgroundColor: primary,
          title: Text('Queries'),

        ),
        body: Column(
          children: [

            Expanded(
                child: ListView.builder(
                    itemCount: state.queries==null?0:state.queries.length,
                    itemBuilder: (context,index){
                      return WidgetAnimator(
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(state.queries[index].usermodel.profilePic,height: 100,),
                                ),
                                title: Text(state.queries[index].usermodel.displayName),
                                subtitle: Text(state.queries[index].comment),
                                trailing: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){     SweetAlert.show(context,
                                          title: "Delete",
                                          subtitle: "Are you sure you want to delete this?",
                                          style: SweetAlertStyle.confirm,
                                          showCancelButton: true, onPress: (bool isConfirm) {
                                            if (isConfirm) {
                                              setState(() {
                                                state.deleteQuery(state.queries[index]);
                                                SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                                // return false to keep dialog
                                                return false;
                                              });

                                            }
                                          });}),
                                      SizedBox(width: 10,),
                                      IconButton(icon: Icon(Icons.message,color: Colors.green,), onPressed: (){

                                        final chatState = Provider.of<ChatState>(context, listen: false);
                                        chatState.setChatUser = state.queries[index].usermodel;
                                        Navigator.pushNamed(context, '/ChatScreenPage');
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
      );
    });
  }
}
