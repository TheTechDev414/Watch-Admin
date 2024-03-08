import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/helper/constant.dart';
import 'package:watch_admin/helper/theme.dart';
import 'package:watch_admin/models/feedModel.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/widgets/customWidgets.dart';
import 'package:watch_admin/widgets/newWidget/customLoader.dart';
import 'package:watch_admin/widgets/newWidget/emptyList.dart';
import 'package:watch_admin/widgets/tweet/tweet.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key key, this.scaffoldKey, this.refreshIndicatorKey})
      : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/CreateFeedPage/tweet');
      },
      child: customIcon(
        context,
        icon: AppIcon.fabTweet,
        istwitterIcon: true,
        iconColor: Colors.black,
        size: 25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(context),
      body: SafeArea(
        child: Container(
          height: fullHeight(context),
          width: fullWidth(context),
          child: RefreshIndicator(
            key: refreshIndicatorKey,
            onRefresh: () async {
              /// refresh home page feed
              var feedState = Provider.of<FeedState>(context, listen: false);
              feedState.getDataFromDatabase();
              return Future.value(true);
            },
            child: _FeedPageBody(
              refreshIndicatorKey: refreshIndicatorKey,
              scaffoldKey: scaffoldKey,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedPageBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  const _FeedPageBody({Key key, this.scaffoldKey, this.refreshIndicatorKey})
      : super(key: key);
  Widget _getUserAvatar(BuildContext context) {
    var authState = Provider.of<AuthState>(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: customInkWell(
        context: context,
        onPressed: () {
          /// Open up sidebaar drawer on user avatar tap
          scaffoldKey.currentState.openDrawer();
        },
        child:
            customImage(context, authState.userModel?.profilePic, height: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var authstate = Provider.of<AuthState>(context, listen: false);
    return Consumer<FeedState>(
      builder: (context, state, child) {
        final List<FeedModel> list = state.getTweetList(authstate.userModel);
        return CustomScrollView(
          slivers: <Widget>[
            child,
            state.isBusy && list == null
                ? SliverToBoxAdapter(
                    child: Container(
                      height: fullHeight(context) - 135,
                      child: CustomScreenLoader(
                        height: double.infinity,
                        width: fullWidth(context),
                      ),
                    ),
                  )
                : !state.isBusy && list == null
                    ? SliverToBoxAdapter(
                        child: EmptyList(
                          'No Post added yet',
                          subTitle:
                              'When new post added, they\'ll show up here \n Tap post button to add new',
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildListDelegate(
                          list.map(
                            (model) {
                              return Container(
                                child: Tweet(
                                  model: model,
                                  // trailing: TweetBottomSheet().tweetOptionIcon(
                                  //   context,
                                  //   model,
                                  //   TweetType.Tweet,
                                  // ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      )
          ],
        );
      },
      child: SliverAppBar(
        floating: true,
        elevation: 0,
        // leading: _getUserAvatar(context),
        title: customTitleText('Lounge'),
        iconTheme: IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          child: Container(
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0.0),
        ),
      ),
    );
  }
}
