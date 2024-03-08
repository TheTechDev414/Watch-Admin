import 'package:flutter/material.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/new_user.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  TextEditingController editingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Users",style: TextStyle(color: Colors.white),),
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
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: users.length,
          //         itemBuilder: (context,index){
          //           return WidgetAnimator(
          //               Padding(
          //                 padding: const EdgeInsets.only(left:18.0,right: 18.0),
          //                 child: Card(
          //                   elevation: 5,
          //                   child: ListTile(
          //                     leading: CircleAvatar(
          //                       backgroundColor: Colors.white,
          //                       radius: 30,
          //                       child: Icon(Icons.person,color: primary,size: 35,),
          //                     ),
          //                     title: Text(users[index].name),
          //                     subtitle: Text(users[index].email),
          //                     trailing: FittedBox(
          //                       fit: BoxFit.fill,
          //                       child: Row(
          //                         children: [
          //                           IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){}),
          //                           SizedBox(width: 10,),
          //                           IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
          //                             Navigator.push(context, MaterialPageRoute(builder: (context) => Newusers(
          //                               isEdit: true,
          //                               name: users[index].name,
          //                               email: users[index].email,
          //                               role: users[index].role,
          //                               status: users[index].status,
          //                             )));
          //                           }),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               )
          //           );
          //         })
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Newusers()));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
