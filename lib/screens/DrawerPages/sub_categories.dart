import 'package:flutter/material.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/new_subCategory.dart';

class SubCategories extends StatefulWidget {
  @override
  _SubCategoriesState createState() => _SubCategoriesState();
}

class _SubCategoriesState extends State<SubCategories> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Sub Categories",style: TextStyle(color: Colors.white),),
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
                  itemCount: subCategories.length,
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
                                child: Image.network(subCategories[index].icon),
                              ),
                              title: Text(subCategories[index].name),
                              subtitle: Text(subCategories[index].status),
                              trailing: FittedBox(
                                fit: BoxFit.fill,
                                child: Row(
                                  children: [
                                    IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){}),
                                    SizedBox(width: 10,),
                                    IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddSubCategory(
                                        isEdit: true,
                                        name: subCategories[index].name,
                                        category: subCategories[index].category,
                                        image: subCategories[index].image,
                                        icon: subCategories[index].icon,
                                        status: subCategories[index].status,
                                      )));
                                    }),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddSubCategory()));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
