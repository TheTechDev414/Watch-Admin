import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/news_model.dart';
import 'package:watch_admin/screens/DrawerPages/news.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class NewNews extends StatefulWidget {
 final NewsModel news;
final bool isEdit;
  NewNews({Key key,this.news,this.isEdit}) : super(key: key);

  @override
  _NewNewsState createState() => _NewNewsState();
}

class _NewNewsState extends State<NewNews> {

  TextEditingController newss = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newss.text = widget.isEdit?widget.news.title:"";
    description.text =widget.isEdit?widget.news.description:"";
  }

  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit News":'Add News'),
      ),
      body: Consumer<ThemeNotifier>(
          builder:(context,notifier,value){
            return ListView(
              children: [
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: (){
                        getImage();
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          elevation: 5,
                          child: widget.isEdit?Image.network(widget.news.image,height: 200,width:200):_image != null ? Image.file(_image,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: newss,
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
                          hintText: "Enter news",
                        )
                    ),
                  ),
                ),

                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: description,
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
                          hintText: "Enter description",
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
                          AddOrEditNews();

                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit News" :"Add News",style: TextStyle(
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
  Future<void> AddOrEditNews() async {
    if(newss.text==null||newss.text.isEmpty){

      return;
    }

    if(description.text==null||description.text.isEmpty){

      return;
    }

    var state = Provider.of<FeedState>(context, listen: false);
    if(widget.isEdit){

      if(widget.news.image==null){

        return;
      }
      if(_image!=null){
        kScreenloader.showLoader(context);
        try {
          await state.uploadFile(_image).then((imagePath) {
            if (imagePath != null) {
              widget.news.image= imagePath;

              /// If type of tweet is new tweet
              state.updateNews(widget.news);
            }
          });
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
widget.news.title=newss.text;
widget.news.description=description.text;
          state.updateNews(widget.news);
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
    else{
      if(_image==null){

        return;
      }

      var authstate = Provider.of<AuthState>(context, listen: false);
      NewsModel news=NewsModel("", newss.text, description.text, "", DateTime.now().toString());
      kScreenloader.showLoader(context);
      try {
        await state.uploadFile(_image).then((imagePath) {
          if (imagePath != null) {
            news.image= imagePath;

            /// If type of tweet is new tweet
            state.createNews(news);
          }
        });
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
        final composetweetstate =
        Provider.of<ComposeTweetState>(context, listen: false);
        final searchstate = Provider.of<SearchState>(context, listen: false);
        composetweetstate
            .sendCustomNotification(newss.text, description.text, searchstate, authstate.userModel)
            .then((_) {
          /// Hide running loader on screen
          //  kScreenloader.hideLoader();

          /// Navigate back to home page
          // Navigator.pop(context);
        });

        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => News()));

      } catch (e) {
        print(e);
        kScreenloader.hideLoader();
      }

    }



  }
}
