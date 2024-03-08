import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/models/category_model.dart';

class AddSubCategory extends StatefulWidget {
  final bool isEdit;
  final String name;
  final String category;
  final String image;
  final String icon;
  final String status;

  AddSubCategory({Key key, this.isEdit, this.name, this.category, this.image, this.icon, this.status}) : super(key: key);

  @override
  _AddSubCategoryState createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  TextEditingController name = TextEditingController();
  TextEditingController status = TextEditingController();

  File _image,_image1;
  final picker = ImagePicker();
  final picker1 = ImagePicker();
  String category;

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
  Future getImage1() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image1 = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    category = widget.category;
    status.text = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit Sub Category":'Add Sub Category'),
      ),
      body: Consumer<ThemeNotifier>(
          builder:(context,notifier,value){
            return ListView(
              children: [
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: name,
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
                          hintText: "Enter sub category name",
                        )
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          isExpanded: true,
                          hint:  Text("Select Category"),
                          value: category,
                          onChanged: (String Value) {
                            setState(() {
                              category = Value;
                            });
                          },
                          items: categories.map((CategoryModel user) {
                            return  DropdownMenuItem<String>(
                              value: user.name,
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 10,),
                                  Text(
                                    user.name,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
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
                          child: _image != null ? Image.file(_image,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Icon",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  ],
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: (){
                        getImage1();
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          elevation: 5,
                          child: _image1 != null ? Image.file(_image1,height: 200,width:200) :Image.asset("assets/placeholder-image.png",height: 200,width:200)),
                    ),
                  ),
                ),
                WidgetAnimator(
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      controller: status,
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
                          hintText: "Enter status",
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
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                        }, child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(widget.isEdit == true ? "Edit Category":"Add Category",style: TextStyle(
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
}
