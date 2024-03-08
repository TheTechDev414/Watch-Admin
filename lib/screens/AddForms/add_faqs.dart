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
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class AddFaq extends StatefulWidget {
 final Faqs faq;
final bool isEdit;
  AddFaq({Key key,this.faq,this.isEdit}) : super(key: key);

  @override
  _AddFaqState createState() => _AddFaqState();
}

class _AddFaqState extends State<AddFaq> {

  TextEditingController question = TextEditingController();
  TextEditingController answer = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    question.text = widget.isEdit?widget.faq.question:"";
    answer.text =widget.isEdit?widget.faq.answer:"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit Faq":'Add Faq'),
      ),
      body: Consumer<ThemeNotifier>(
          builder:(context,notifier,value){
            return ListView(
              children: [

                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: question,
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
                          hintText: "Enter Question?",
                        )
                    ),
                  ),
                ),

                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller:answer,
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
                          hintText: "Enter Answer",
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
                          AddOrEditFaq();

                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit Faq" :"Add Faq",style: TextStyle(
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
  Future<void> AddOrEditFaq() async {
    if(question.text==null||question.text.isEmpty){

      return;
    }

    if(answer.text==null||answer.text.isEmpty){

      return;
    }

    var state = Provider.of<AdminState>(context, listen: false);
    if(widget.isEdit){

        kScreenloader.showLoader(context);
        try {
          widget.faq.question=question.text;
          widget.faq.answer=answer.text;
          state.addFaqs(widget.faq);
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
          Faqs faq=Faqs();

          faq.question=question.text;
          faq.answer=answer.text;
          state.addFaqs(faq);
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
    }

}
