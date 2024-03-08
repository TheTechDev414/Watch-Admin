import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';

class AddVendors extends StatefulWidget {
  bool isEdit = false;
  final String name;
  final String store;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zipCode;
  final String description;
  final String banner;
  final String logo;
  final String password;
  final String status;
  final String created;

  AddVendors({Key key, this.isEdit = false, this.name, this.store, this.email, this.phone, this.address, this.city, this.zipCode, this.description, this.banner, this.logo, this.password, this.status, this.created}) : super(key: key);

  @override
  _AddVendorsState createState() => _AddVendorsState();
}

class _AddVendorsState extends State<AddVendors> {
  TextEditingController name = TextEditingController();
  TextEditingController store = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController status  = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isHidden = true;
  File _image,_image1;
  final picker = ImagePicker();
  final picker1 = ImagePicker();

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
    store.text = widget.store;
    email.text = widget.email;
    phone.text = widget.phone;
    address.text = widget.address;
    city.text = widget.city;
    code.text = widget.zipCode;
    description.text = widget.description;
    status.text = widget.status;
    password.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.isEdit == true ?"Edit Vendor":'Add Vendor'),
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
                        hintText: "Enter your name",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: store,
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
                        hintText: "Enter your store",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: email,
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
                        hintText: "Enter your Email",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: phone,
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
                        hintText: "Enter your phone",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: address,
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
                        hintText: "Enter your address",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: city,
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
                        hintText: "Enter your city",
                      )
                  ),
                ),
              ),
              WidgetAnimator(
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: code,
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
                        hintText: "Enter your zip code",
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
              WidgetAnimator(
                 Padding(
                  padding: const EdgeInsets.only(left:18.0,right: 18,bottom: 18),
                  child: TextField(
                    controller: password,
                      obscureText: isHidden,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: Icon(
                              isHidden ? Icons.visibility_off : Icons.visibility ,
                            )),
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
                        hintText: "Enter your Password",
                      )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Banner",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                  Text("Logo",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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
                    child: Text(widget.isEdit == true ?"Edit Vendor":"Add Vendor",style: TextStyle(
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
