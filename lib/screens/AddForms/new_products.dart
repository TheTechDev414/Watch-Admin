import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/models/category_model.dart';
import 'package:watch_admin/models/subcategory_model.dart';

class AddProducts extends StatefulWidget {
  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  String category;
  String subCategory;
  String featured;
  String status;

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Products",style: TextStyle(color: Colors.white),),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return ListView(
            children: [
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter your name",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter product description",
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
                        hint:  Text("Select  Sub Category"),
                        value: subCategory,
                        onChanged: (String Value) {
                          setState(() {
                            subCategory = Value;
                          });
                        },
                        items: subCategories.map((SubCategoryModel user) {
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
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter quantity",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter size",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter price",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
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
                        hintText: "Enter discount",
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
                        hint:  Text("Select featured"),
                        value: featured,
                        onChanged: (String Value) {
                          setState(() {
                            featured = Value;
                          });
                        },
                        items: ["No","Yes"].map((String user) {
                          return  DropdownMenuItem<String>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  user,
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
                        hint:  Text("Select status"),
                        value: status,
                        onChanged: (String Value) {
                          setState(() {
                            status = Value;
                          });
                        },
                        items: ["Active","In Active"].map((String user) {
                          return  DropdownMenuItem<String>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                SizedBox(width: 10,),
                                Text(
                                  user,
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
                    child: Text("Add Product",style: TextStyle(
                      color: secondary,
                      fontSize: 20,
                    ),),
                  )),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
