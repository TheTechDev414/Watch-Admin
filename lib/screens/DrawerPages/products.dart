import 'package:flutter/material.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/new_products.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Products",style: TextStyle(color: Colors.white),),
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
                  itemCount: products.length,
                  itemBuilder: (context,index){
                    return WidgetAnimator(
                        Padding(
                          padding: const EdgeInsets.only(left:18.0,right: 18.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 40,
                                child: Image.network(products[index].picture),
                              ),
                              title: Text(products[index].name),
                              subtitle: Text(products[index].status),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){}),
                                    SizedBox(width: 10,),
                                    IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){}),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
