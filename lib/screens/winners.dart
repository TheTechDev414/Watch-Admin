import 'dart:io';

import 'package:badges/badges.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
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

class WinnerScreen extends StatefulWidget {
  @override
  _WinnerScreenState createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loader = true;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();

  }




  @override
  Widget build(BuildContext context) {

    return Consumer<AdminState>(builder: (context, state, child) {

      return Scaffold(
        appBar: AppBar(
          key: _scaffoldKey,
          centerTitle: true,
          backgroundColor: primary,
          title: Text('Winners'),

        ),

        body: Column(
          children: [

            Expanded(
                child: ListView.builder(
                    itemCount: state.winner_users==null?0:state.winner_users.length,
                    itemBuilder: (context,index){
                      return WidgetAnimator(
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(state.winner_users[index].profilePic,height: 100,),
                                ),
                                title: Text(state.winner_users[index].displayName),
                                subtitle: Text("Winner on "+DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(state.winner_users[index].createdAt))),
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
                                              state.deleteWinner(state.winner_users[index]);
                                              SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                              // return false to keep dialog
                                              return false;
                                            }
                                          });}
                                          ),
                                      SizedBox(height: 20,),
                                      IconButton(icon: Icon(Icons.message,color: Colors.greenAccent,), onPressed: (){
                                        final chatState = Provider.of<ChatState>(context, listen: false);
                                        chatState.setChatUser = state.winner_users[index];
                                        Navigator.pushNamed(context, '/ChatScreenPage');

                                      }
                                      ),

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
