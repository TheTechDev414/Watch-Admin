import 'package:flutter/material.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/new_vendors.dart';

class Vendor extends StatefulWidget {
  @override
  _VendorState createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Vendors",style: TextStyle(color: Colors.white),),
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: vendors.length,
                  itemBuilder: (context,index){
                    return WidgetAnimator(
                      Padding(
                        padding: const EdgeInsets.only(left:18.0,right: 18.0),
                        child: GestureDetector(
                          onTap: (){
                             },
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: Image.network(vendors[index].logo),
                              ),
                              title: Text(vendors[index].name),
                              subtitle: Text(vendors[index].email),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){}),
                                    SizedBox(width: 10,),
                                    IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddVendors(
                                          isEdit: true,
                                          name:vendors[index].name,
                                          store:vendors[index].store,
                                          email:vendors[index].email,
                                          phone:vendors[index].phone,
                                          address:vendors[index].address,
                                          city:vendors[index].city,
                                          zipCode:vendors[index].zipCode,
                                          description:vendors[index].description,
                                          banner:vendors[index].banner,
                                          logo:vendors[index].logo,
                                          password:vendors[index].password,
                                          status:vendors[index].status,
                                          created:vendors[index].created
                                      )));
                                    }),
                                  ],
                                ),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddVendors()));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
