import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/DummyData/dummy_data.dart';
import 'package:watch_admin/animations/bottomAnimation.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/feedPage.dart';
import 'package:watch_admin/message/chatListPage.dart';
import 'package:watch_admin/message/chatScreenPage.dart';
import 'package:watch_admin/models/ListTiles.dart';
import 'package:watch_admin/profile/profilePage.dart';
import 'package:watch_admin/screens/DrawerPages/blogs.dart';
import 'package:watch_admin/screens/DrawerPages/categories.dart';
import 'package:watch_admin/screens/DrawerPages/faqs.dart';
import 'package:watch_admin/screens/DrawerPages/messages.dart';
import 'package:watch_admin/screens/DrawerPages/notifications.dart';
import 'package:watch_admin/screens/DrawerPages/products.dart';
import 'package:watch_admin/screens/DrawerPages/sub_categories.dart';
import 'package:watch_admin/screens/DrawerPages/vendors.dart';
import 'package:watch_admin/screens/DrawerPages/watches.dart';
import 'package:watch_admin/screens/add_watch_model.dart';
import 'package:watch_admin/screens/cart_wheel.dart';
import 'package:watch_admin/screens/login_screen.dart';
import 'package:watch_admin/screens/profile_screen.dart';
import 'package:watch_admin/screens/query.dart';
import 'package:watch_admin/screens/slider.dart';
import 'package:watch_admin/screens/usercart_wheel.dart';
import 'package:watch_admin/search/SearchPage.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/appState.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/notificationState.dart';
import 'package:watch_admin/state/searchState.dart';

import 'DrawerPages/news.dart';
import 'DrawerPages/users.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loader=true;

  List<ListTileModel> listTile=List<ListTileModel>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var state = Provider.of<AppState>(context, listen: false);
      state.setpageIndex = 0;

      initProfile();
      initSearch();
      initNotification();
      initChat();
      initAdminSettings();
      initTweets();
      initHomePage();
    });

    // TODO: implement initState
    super.initState();
  }

  void initTweets() {

    final authstate = Provider.of<AuthState>(context, listen: false);
    var state = Provider.of<FeedState>(context, listen: false);
    state.databaseInit();
    state.getDataFromDatabase();
    state.getwatchDataFromDatabase();
    state.getNewsFromDatabase();
    state.getFavouritesFromDatabase(authstate.user.uid);
    state.getBlogs();
  }


  void initAdminSettings(){
    setState(() {
      loader = true;
    });

    var searchState = Provider.of<SearchState>(context, listen: false);
    final state = Provider.of<AdminState>(context, listen: false);
    state.getslidersfromdatabase();
     state.getterms_and_condition();
     state.getNotification();
    state.getFaqs();
    state.getBrandNames();
    state.getBrandModels();
    state.getWinnerUsers();
    state.getContestSetting();
    state.getContestUsers();
    // for (int i = 0; i < state.sliders.length; i++) {
    //   setState(() {
    //     _sliders.add(NetworkImage(state.sliders[i]));
    //   });
    //   if (i == state.sliders.length - 1) {
    //     setState(() {
    //       loader = false;
    //     });
    //   }
    // }
  }

  void initProfile() {
    var state = Provider.of<AuthState>(context, listen: false);
    state.databaseInit();
  }

  void initSearch() {
    var searchState = Provider.of<SearchState>(context, listen: false);

    var authstate = Provider.of<AuthState>(context, listen: false);
    searchState.getDataFromDatabase(authstate.userId);
  }

  void initNotification() {
    var state = Provider.of<NotificationState>(context, listen: false);
    var authstate = Provider.of<AuthState>(context, listen: false);
    state.databaseInit(authstate.userId);
    state.initfirebaseService();
  }

  void initChat() {
    final chatState = Provider.of<ChatState>(context, listen: false);
    final state = Provider.of<AuthState>(context, listen: false);
    chatState.databaseInit(state.userId, state.userId);

    /// It will update fcm token in database
    /// fcm token is required to send firebase notification
    state.updateFCMToken();

    /// It get fcm server key
    /// Server key is required to configure firebase notification
    /// Without fcm server notification can not be sent
    chatState.getFCMServerKey();
  }
  initHomePage(){
setState(() {
  loader=true;
});
    var searchState = Provider.of<SearchState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    var adminstate = Provider.of<AdminState>(context, listen: false);
    var feedstate = Provider.of<FeedState>(context, listen: false);

    setState(() {
      listTile = [
        ListTileModel("Posts", feedstate.getTweetList(authState.userModel)==null?0:feedstate.getTweetList(authState.userModel).length, Icon(Icons.crop_square,color: Colors.teal,),Colors.teal),
        ListTileModel("Brands",adminstate.brandnames==null?0:adminstate.brandnames.length, Icon(Icons.category,color: Colors.orange,),Colors.orange),
        ListTileModel("Users",searchState.userlist==null?0:searchState.userlist.length, Icon(Icons.supervisor_account_rounded,color: Colors.redAccent,),Colors.redAccent),
      ];
      loader=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    initHomePage();

    final authstate = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primary,
        title: Text("Home",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              icon: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Elite Edge Ware"),
                        content: Text("Do you want to logout?"),
                        actions: [
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              authstate.logoutCallback();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => Login()),
                                      (Route<dynamic> route) => false);
                              // exit(0);
                            },
                          ),
                          FlatButton(
                            child: Text("No"),
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.exit_to_app,color: secondary,)), onPressed:(){})
        ],
      ),
      body: loader?SpinKitRipple(color:secondary):GridView.builder(
        primary: false,
        itemCount: listTile==null?0:listTile.length,
        itemBuilder:(cyx,index){
          return WidgetAnimator(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  color: listTile[index].color,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: listTile[index].icon,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 35,
                          ),
                          Text(listTile[index].name,style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Total",style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),),
                              SizedBox(width: 10,),
                              Text(listTile[index].total.toString(),style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),)
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 10/4,
            crossAxisCount: 1,
        ),
      ),
      drawer: Consumer<ThemeNotifier>(
        builder: (context,notifier,value){
          return Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountEmail: Text(authstate.userModel==null?"":authstate.userModel.email,style: TextStyle(color: secondary),),
                  accountName: Text(authstate.userModel==null?"":authstate.userModel.displayName,style: TextStyle(color: secondary),),
                  currentAccountPicture: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                    child: new CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 100,
                      child: ClipOval(
                        child: Image.network(authstate.userModel == null?"https://www.w3schools.com/w3images/avatar5.png":authstate.userModel.profilePic,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                ),
                // body

                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ListTile(
                    title: Text('Home',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.home, color: notifier.darkTheme ? Colors.white :primary),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            new FeedPage()));
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => new EventPage(
                    //   type: "user",
                    // )));
                  },
                  child: ListTile(
                    title: Text(
                      'Lounge',
                      style: TextStyle(
                          color: notifier.darkTheme ? Colors.white : primary),
                    ),
                    leading: Icon(Icons.camera_alt,
                        color: notifier.darkTheme ? Colors.white : primary),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => Vendor()));
                //   },
                //   child: ListTile(
                //     title: Text('Vendors',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                //     leading: Icon(Icons.supervisor_account_rounded, color: notifier.darkTheme ? Colors.white :primary),
                //   ),
                // ),
                //
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => Categories()));
                //   },
                //   child: ListTile(
                //     title: Text('Categories',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                //     leading: Icon(Icons.category, color: notifier.darkTheme ? Colors.white :primary),
                //   ),
                // ),
                //
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategories()));
                //   },
                //   child: ListTile(
                //     title: Text('Sub Categories',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                //     leading: Icon(Icons.card_travel_sharp, color: notifier.darkTheme ? Colors.white :primary,),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Faq()));
                  },
                  child: ListTile(
                    title: Text('Faqs',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.crop_square, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
                  },
                  child: ListTile(
                    title: Text('Notifications',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.notifications, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Watches()));
                  },
                  child: ListTile(
                    title: Text('Watches',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.watch, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddWatchModel()));
                  },
                  child: ListTile(
                    title: Text('Watch Models',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.watch_later_outlined, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SliderScreen()));
                  },
                  child: ListTile(
                    title: Text('Sliders',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.image, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QueryScreen()));
                  },
                  child: ListTile(
                    title: Text('Queries',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.help, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage()));
                  },
                  child: ListTile(
                    title: Text('Messages',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.message, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => News()));
                  },
                  child: ListTile(
                    title: Text('News',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.location_on, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Blogs()));
                  },
                  child: ListTile(
                    title: Text('Blogs',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.description, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  child: ListTile(
                    title: Text('Users',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.person, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CartWheel()));
                  },
                  child: ListTile(
                    title: Text('Give Away',style: TextStyle(color: notifier.darkTheme ? Colors.white :primary),),
                    leading: Icon(Icons.camera_rounded, color: notifier.darkTheme ? Colors.white :primary,),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
