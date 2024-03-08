import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/feed/composeTweet/composeTweet.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/feed/feedPostDetail.dart';
import 'package:watch_admin/feed/imageViewPage.dart';
import 'package:watch_admin/message/chatScreenPage.dart';
import 'package:watch_admin/message/newMessagePage.dart';
import 'package:watch_admin/profile/EditProfilePage.dart';
import 'package:watch_admin/profile/profileImageView.dart';
import 'package:watch_admin/profile/profilePage.dart';
import 'package:watch_admin/screens/splash_screen.dart';
import 'package:watch_admin/search/SearchPage.dart';
import '../helper/customRoute.dart';
import '../widgets/customWidgets.dart';

class Routes{
  static dynamic route(){
      return {
          'SplashPage': (BuildContext context) =>   SplashScreen(),
      };
  }

  static void sendNavigationEventToFirebase(String path) {
    if(path != null && path.isNotEmpty){
      // analytics.setCurrentScreen(screenName: path);
    }
  }

  static Route onGenerateRoute(RouteSettings settings) {
     final List<String> pathElements = settings.name.split('/');
     if (pathElements[0] != '' || pathElements.length == 1) {
       return null;
     }
     switch (pathElements[1]) {
      case "ComposeTweetPage": 
        bool isRetweet = false;
        bool isTweet = false;
        if(pathElements.length == 3 && pathElements[2].contains('retweet')){
          isRetweet = true;
        }
        else if(pathElements.length == 3 && pathElements[2].contains('tweet')){
          isTweet = true;
        }
        return CustomRoute<bool>(builder:(BuildContext context)=> ChangeNotifierProvider<ComposeTweetState>(
          create: (_) => ComposeTweetState(),
          child: ComposeTweetPage(isRetweet:isRetweet, isTweet: isTweet),
        ));
      case "FeedPostDetail":
        var postId = pathElements[2];
          return SlideLeftRoute<bool>(builder:(BuildContext context)=> FeedPostDetail(postId: postId,),settings: RouteSettings(name:'FeedPostDetail'));
        case "ProfilePage":
         String profileId;
         if(pathElements.length > 2){
             profileId = pathElements[2];
         }
        return CustomRoute<bool>(builder:(BuildContext context)=> ProfilePage(
          profileId: profileId,
        )); 
      case "CreateFeedPage": return CustomRoute<bool>(builder:(BuildContext context)=> ChangeNotifierProvider<ComposeTweetState>(
          create: (_) => ComposeTweetState(),
          child: ComposeTweetPage(isRetweet:false, isTweet: true),
        ));
      case "SearchPage":return CustomRoute<bool>(builder:(BuildContext context)=> SearchPage()); 
      case "ImageViewPge":return CustomRoute<bool>(builder:(BuildContext context)=> ImageViewPge());
      case "EditProfile":return CustomRoute<bool>(builder:(BuildContext context)=> EditProfilePage()); 
      case "ProfileImageView":return SlideLeftRoute<bool>(builder:(BuildContext context)=> ProfileImageView()); 
      case "ChatScreenPage":return CustomRoute<bool>(builder:(BuildContext context)=> ChatScreenPage()); 
      case "NewMessagePage":return CustomRoute<bool>(builder:(BuildContext context)=> NewMessagePage(),);
    //  case "ConversationInformation":return CustomRoute<bool>(builder:(BuildContext context)=> ConversationInformation(),);
      default:return onUnknownRoute(RouteSettings(name: '/Feature'));
     }
  }

   static Route onUnknownRoute(RouteSettings settings){
     return MaterialPageRoute(
          builder: (_) => Scaffold(
                appBar: AppBar(title: customTitleText(settings.name.split('/')[1]),centerTitle: true,),
                body: Center(
                  child: Text('${settings.name.split('/')[1]} Comming soon..'),
                ),
              ),
        );
   }
}