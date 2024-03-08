import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/feed/composeTweet/state/composeTweetState.dart';
import 'package:watch_admin/helper/routes.dart';
import 'package:watch_admin/screens/splash_screen.dart';
import 'package:watch_admin/state/adminState.dart';
import 'package:watch_admin/state/appState.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/notificationState.dart';
import 'package:watch_admin/state/searchState.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<FeedState>(create: (_) => FeedState()),
        ChangeNotifierProvider<ChatState>(create: (_) => ChatState()),
        ChangeNotifierProvider<SearchState>(create: (_) => SearchState()),
        ChangeNotifierProvider<AdminState>(create: (_) => AdminState()),

        ChangeNotifierProvider<ComposeTweetState>(create: (_) => ComposeTweetState()),
        ChangeNotifierProvider<NotificationState>(create: (_) => NotificationState()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier())
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
              theme: notifier.darkTheme ? dark : light,
              title: 'Elite Edge Ware',
              debugShowCheckedModeBanner: false,

              routes: Routes.route(),
              onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
              onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
              home: SplashScreen()
          );
        },
      ),
    );

  }
}

