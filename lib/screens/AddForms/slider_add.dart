import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/news_model.dart';
import 'package:watch_admin/state/adminState.dart' as slid;
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';

class SliderAdd extends StatefulWidget {
final slid.Slider slider;
final bool isEdit;
  SliderAdd({Key key,this.slider,this.isEdit}) : super(key: key);

  @override
  _SliderAddState createState() => _SliderAddState();
}

class _SliderAddState extends State<SliderAdd> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
link_url.text=widget.isEdit?widget.slider.link_url:"";
  }

  File _image;
  final picker = ImagePicker();
  TextEditingController link_url=TextEditingController();
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
        title: Text(widget.isEdit == true ? "Edit Slider" :"Add Slider"),
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
                          child: widget.isEdit?Image.network(widget.slider.slider_url,height: 200,width:200):_image != null ? Image.file(_image,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                        controller: link_url,
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
                          hintText: "Enter link",
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
                          AddorEditSlider();

                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit Slider" :"Add Slider",style: TextStyle(
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
  AddorEditSlider() async {
    if(widget.isEdit){

      if(_image==null){

        final state = Provider.of<slid.AdminState>(context, listen: false);
        widget.slider.link_url=link_url.text;
        state.updateSlider(widget.slider);
        Navigator.pop(context);


      }
      else{
        kScreenloader.showLoader(context);
        try {

          final state = Provider.of<slid.AdminState>(context, listen: false);
          await state.uploadFile(_image).then((imagePath) {
            if (imagePath != null) {
              widget.slider.slider_url=imagePath;
              widget.slider.link_url=link_url.text;

              /// If type of tweet is new tweet
              state.updateSlider(widget.slider);
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
    }
    else{
      if(_image==null){

        return;
      }
      else{
        kScreenloader.showLoader(context);
        try {

          final state = Provider.of<slid.AdminState>(context, listen: false);
          await state.uploadFile(_image).then((imagePath) {
            if (imagePath != null) {
              slid.Slider slider=slid.Slider();
              slider.link_url=link_url.text;
              slider.slider_url=imagePath;

              /// If type of tweet is new tweet
              state.addSlider(slider);
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

    }

  }
}
