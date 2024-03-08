import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/add_notification.dart';
import 'package:watch_admin/screens/AddForms/new_news.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/feedState.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  TextEditingController editingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    var state = Provider.of<AdminState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Notifications",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [

          Expanded(
              child: ListView.builder(
                  itemCount: state.notification==null?0:state.notification.length,
                  itemBuilder: (context,index){
                    return WidgetAnimator(
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,right: 18.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(

                              title: Text(state.notification[index].title),
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
                                              state.deleteNotification(state.notification[index]);
                                              SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                              // return false to keep dialog
                                              return false;
                                            });

                                          }
                                        });}),
                                    SizedBox(width: 10,),
                                    IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotification(
                                        isEdit:true,
                                        noitification:  state.notification[index],
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotification(isEdit: false,)));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
