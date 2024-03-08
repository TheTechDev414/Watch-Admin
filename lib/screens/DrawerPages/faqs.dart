import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/screens/AddForms/add_faqs.dart';
import 'package:watch_admin/state/adminState.dart';

class Faq extends StatefulWidget {
  @override
  _FaqState createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AdminState>(context, listen: false);
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFaq(isEdit: false,)));
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Faqs"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
            Expanded(
                child: ListView.builder(
                    itemCount: state.faqs==null?0:state.faqs.length,
                    itemBuilder: (context,index){
                      return WidgetAnimator(
                          Padding(
                            padding: const EdgeInsets.only(left:18.0,right: 18.0),
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                // leading: Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Image.network(state.newslist[index].image,height: 100,),
                                // ),
                                title: Text(state.faqs[index].question),
                                trailing: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Row(
                                    children: [
                                      IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
                                        SweetAlert.show(context,
                                            title: "Delete",
                                            subtitle: "Are you sure you want to delete this?",
                                            style: SweetAlertStyle.confirm,
                                            showCancelButton: true, onPress: (bool isConfirm) {
                                              if (isConfirm) {
                                                state.deleteFaq(state.faqs[index]);
                                                SweetAlert.show(context,style: SweetAlertStyle.success,title: "Success");
                                                // return false to keep dialog
                                                return false;
                                              }
                                            });}),
                                      SizedBox(width: 10,),
                                      IconButton(icon: Icon(Icons.edit,color: Colors.green,), onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddFaq(
                                          isEdit:true,
                                          faq: state.faqs[index],
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
    );
  }
}
