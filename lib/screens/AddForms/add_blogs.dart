import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/blog_model.dart';
import 'package:watch_admin/models/news_model.dart';
import 'package:watch_admin/screens/DrawerPages/blogs.dart';
import 'package:watch_admin/screens/DrawerPages/news.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class AddBlogs extends StatefulWidget {
 final BlogModel blogs;
final bool isEdit;
  AddBlogs({Key key,this.blogs,this.isEdit}) : super(key: key);

  @override
  _AddBlogsState createState() => _AddBlogsState();
}

class _AddBlogsState extends State<AddBlogs> {

  TextEditingController blogtitle = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogtitle.text = widget.isEdit?widget.blogs.title:"";
    description.text =widget.isEdit?widget.blogs.description:"";
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
        title: Text(widget.isEdit == true ?"Edit Blog":'Add Blog'),
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
                          child: widget.isEdit?Image.network(widget.blogs.image,height: 200,width:200):_image != null ? Image.file(_image,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: blogtitle,
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
                          hintText: "Enter title",
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
                          AddOrEditBlog();

                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit Blog" :"Add Blog",style: TextStyle(
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
  Future<void> AddOrEditBlog() async {
    if(blogtitle.text==null||blogtitle.text.isEmpty){

      return;
    }

    if(description.text==null||description.text.isEmpty){

      return;
    }

    var state = Provider.of<FeedState>(context, listen: false);
    if(widget.isEdit){

      if(widget.blogs.image==null){

        return;
      }
      if(_image!=null){
        kScreenloader.showLoader(context);
        try {
          await state.uploadFile(_image).then((imagePath) {
            if (imagePath != null) {
              widget.blogs.image= imagePath;

              /// If type of tweet is new tweet
              state.updateBlog(widget.blogs);
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
widget.blogs.title=blogtitle.text;
widget.blogs.description=description.text;
          state.updateBlog(widget.blogs);
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
      BlogModel blogs=BlogModel(blogtitle.text, description.text, "", DateTime.now().toString());
      kScreenloader.showLoader(context);
      try {
        await state.uploadFile(_image).then((imagePath) {
          if (imagePath != null) {
            blogs.image= imagePath;

            /// If type of tweet is new tweet
            state.createBlog(blogs);
          }
        });
        kScreenloader.hideLoader();
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
            .sendCustomNotification(blogtitle.text, description.text, searchstate, authstate.userModel)
            .then((_) {
          /// Hide running loader on screen
          //  kScreenloader.hideLoader();

          /// Navigate back to home page
          // Navigator.pop(context);
        });

        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Blogs()));

      } catch (e) {
        print(e);
        kScreenloader.hideLoader();
      }

    }



  }
}
