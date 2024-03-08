import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/faq.dart';
import 'package:watch_admin/models/news_model.dart';
import 'package:watch_admin/models/notificationModel.dart';
import 'package:watch_admin/models/notifications.dart';
import 'package:watch_admin/screens/DrawerPages/notifications.dart' as not;
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class AddNotification extends StatefulWidget {
 final Notifications noitification;
final bool isEdit;
  AddNotification({Key key,this.noitification,this.isEdit}) : super(key: key);

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {

  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.isEdit?widget.noitification.title:"";
    message.text =widget.isEdit?widget.noitification.message:"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit Notification":'Add Notification'),
      ),
      body: Consumer<ThemeNotifier>(
          builder:(context,notifier,value){
            return ListView(
              children: [

                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: title,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.darkTheme ? Colors.white :primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.darkTheme ? Colors.white :primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter Title?",
                        )
                    ),
                  ),
                ),

                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller:message,
                       maxLines: 3,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: notifier.darkTheme ? Colors.white :primary,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: notifier.darkTheme ? Colors.white :primary),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Enter Message",
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        color: primary,
                        onPressed: (){
                          AddOrEditNotification();

                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit Notification" :"Add Notification",style: TextStyle(
                        color: secondary,
                        fontSize: 20,
                      ),),
                    )),
                  ),
                )
              ],
            );
          }
      ),
    );
  }
  Future<void> AddOrEditNotification() async {
    if(title.text==null||title.text.isEmpty){

      return;
    }

    if(message.text==null||message.text.isEmpty){

      return;
    }

    var state = Provider.of<AdminState>(context, listen: false);
    var authstate = Provider.of<AuthState>(context, listen: false);
    if(widget.isEdit){

        kScreenloader.showLoader(context);
        try {
          widget.noitification.title=title.text;
          widget.noitification.message=message.text;
          state.editNotification(widget.noitification);
          kScreenloader.hideLoader();
          Navigator.pop(context);
          /// Checks for username in tweet description
          /// If foud sends notification to all tagged user
          /// If no user found or not compost tweet screen is closed and redirect back to home page.
          // final composetweetstate =
          // Provider.of<ComposeTweetState>(context, listen: false);
          // final searchstate = Provider.of<SearchState>(context, listen: false);
          // await composetweetstate
          //     .sendNotificationwatch(watch, searchstate)
          //     .then((_) {
          //   /// Hide running loader on screen
          //   kScreenloader.hideLoader();
          //
          //   /// Navigate back to home page
          //   Navigator.pop(context);
          // });
        } catch (e) {
          print(e);
          kScreenloader.hideLoader();
        }

      }
      else{
        kScreenloader.showLoader(context);
        try {
          Notifications notificationModel=Notifications();


          notificationModel.title=title.text;
          notificationModel.message=message.text;
          state.addNotification(notificationModel);

          kScreenloader.hideLoader();
          /// Checks for username in tweet description
          /// If foud sends notification to all tagged user
          /// If no user found or not compost tweet screen is closed and redirect back to home page.
           final composetweetstate =
          Provider.of<ComposeTweetState>(context, listen: false);
          final searchstate = Provider.of<SearchState>(context, listen: false);
           composetweetstate
              .sendCustomNotification(title.text, message.text, searchstate, authstate.userModel)
              .then((_) {
            /// Hide running loader on screen
          //  kScreenloader.hideLoader();

            /// Navigate back to home page
           // Navigator.pop(context);
          });

Navigator.of(context).pop();
          Navigator.push(context, MaterialPageRoute(builder: (context) => not.Notifications()));

        } catch (e) {
          print(e);
          kScreenloader.hideLoader();
        }

      }
    }

}
