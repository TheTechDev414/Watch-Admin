import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/constants/theme.dart';
import 'package:watch_admin/helper/constant.dart';
import 'package:watch_admin/helper/theme.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/feedModel.dart';
import 'package:watch_admin/models/user.dart';
import 'package:watch_admin/profile/widgets/tabPainter.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/state/searchState.dart';
import 'package:watch_admin/widgets/customWidgets.dart';
import 'package:watch_admin/widgets/newWidget/customLoader.dart';
import 'package:watch_admin/widgets/newWidget/customUrlText.dart';
import 'package:watch_admin/widgets/newWidget/emptyList.dart';
import 'package:watch_admin/widgets/newWidget/rippleButton.dart';
import 'package:watch_admin/widgets/tweet/tweet.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.profileId}) : super(key: key);

  final String profileId;

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  bool isMyProfile = false;
  int pageIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var authstate = Provider.of<AuthState>(context, listen: false);
      authstate.getProfileUser(userProfileId: widget.profileId);
      isMyProfile =
          widget.profileId == null || widget.profileId == authstate.userId;
    });
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  SliverAppBar getAppbar() {
    var authstate = Provider.of<AuthState>(context);
    return SliverAppBar(
      forceElevated: false,
      expandedHeight: 200,
      elevation: 0,
      stretch: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.transparent,
      // actions: <Widget>[
      //   authstate.isbusy
      //       ? SizedBox.shrink()
      //       : PopupMenuButton<Choice>(
      //           onSelected: (d) {},
      //           itemBuilder: (BuildContext context) {
      //             return choices.map((Choice choice) {
      //               return PopupMenuItem<Choice>(
      //                 value: choice,
      //                 child: Text(choice.title),
      //               );
      //             }).toList();
      //           },
      //         ),
      // ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.blurBackground
        ],
        background: authstate.isbusy
            ? SizedBox.shrink()
            : Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  SizedBox.expand(
                    child: Container(
                      padding: EdgeInsets.only(top: 50),
                      height: 30,
                    ),
                  ),
                  // Container(height: 50, color: Colors.black),

                  /// Banner image
                  Container(
                    height: 180,
                    padding: EdgeInsets.only(top: 28),
                    child: customNetworkImage(
                      'https://pbs.twimg.com/profile_banners/457684585/1510495215/1500x500',
                      fit: BoxFit.fill,
                    ),
                  ),

                  /// UserModel avatar, message icon, profile edit and follow/following button
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle),
                          child: RippleButton(
                            child: customImage(
                              context,
                              authstate.profileUserModel.profilePic,
                              height: 80,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            onPressed: () {
                              Navigator.pushNamed(context, "/ProfileImageView");
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 90, right: 30),
                          child: Row(
                            children: <Widget>[
                              isMyProfile
                                  ? Container(height: 40)
                                  : RippleButton(
                                      splashColor: TwitterColor.dodgetBlue_50
                                          .withAlpha(100),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      onPressed: () {
                                        if (!isMyProfile) {
                                          final chatState =
                                              Provider.of<ChatState>(context,
                                                  listen: false);
                                          chatState.setChatUser =
                                              authstate.profileUserModel;
                                          Navigator.pushNamed(
                                              context, '/ChatScreenPage');
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        padding: EdgeInsets.only(
                                            bottom: 5,
                                            top: 0,
                                            right: 0,
                                            left: 0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: isMyProfile
                                                    ? Colors.black87
                                                        .withAlpha(180)
                                                    : Colors.blue,
                                                width: 1),
                                            shape: BoxShape.circle),
                                        child: Icon(
                                          IconData(AppIcon.messageEmpty,
                                              fontFamily: 'TwitterIcon'),
                                          color: Colors.blue,
                                          size: 20,
                                        ),

                                        // customIcon(context, icon:AppIcon.messageEmpty, iconColor: TwitterColor.dodgetBlue, paddingIcon: 8)
                                      ),
                                    ),
                              SizedBox(width: 10),
                              RippleButton(
                                splashColor:
                                    TwitterColor.dodgetBlue_50.withAlpha(100),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                onPressed: () {
                                  if (isMyProfile) {
                                    Navigator.pushNamed(
                                        context, '/EditProfile');
                                  } else {
                                    print("hassan");
                                    var searchstate = Provider.of<SearchState>(context, listen: false);

                                    if(isBlocked()){

                                     UserModel user= searchstate.userlist[searchstate.userlist.indexWhere((element) => element.userId==widget.profileId)];
                                     user.isBlocked=false;
                                     authstate.updateUserProfile(user);
                                    }
                                    else{
                                      UserModel user= searchstate.userlist[searchstate.userlist.indexWhere((element) => element.userId==widget.profileId)];
                                      user.isBlocked=true;
                                      authstate.updateUserProfile(user);
                                    }
                                    // authstate.followUser(
                                    //   removeFollower: isFollower(),
                                    // );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isFollower()
                                        ? TwitterColor.dodgetBlue
                                        : TwitterColor.white,
                                    border: Border.all(
                                        color: isMyProfile
                                            ? Colors.black87
                                            : Colors.blue,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),

                                  /// If [isMyProfile] is true then Edit profile button will display
                                  // Otherwise Follow/Following button will be display
                                  child: Text(
                                    isMyProfile
                                        ? 'Edit Profile'
                                        : isBlocked()
                                            ? 'Unblock'
                                            : 'Block',
                                    style: TextStyle(
                                      color: isMyProfile
                                          ? Colors.black87.withAlpha(180)
                                          : isFollower()
                                              ? TwitterColor.white
                                              : Colors.blue,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed('/CreateFeedPage');
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

  Widget _emptyBox() {
    return SliverToBoxAdapter(child: SizedBox.shrink());
  }

  isFollower() {
    var authstate = Provider.of<AuthState>(context, listen: false);
    if (authstate.profileUserModel.followersList != null &&
        authstate.profileUserModel.followersList.isNotEmpty) {
      return (authstate.profileUserModel.followersList
          .any((x) => x == authstate.userModel.userId));
    } else {
      return false;
    }
  }
  isBlocked() {
    //var authstate = Provider.of<AuthState>(context, listen: false);

    var searchstate = Provider.of<SearchState>(context, listen: false);
    if (searchstate.userlist[searchstate.userlist.indexWhere((element) => element.userId==widget.profileId)].isBlocked) {
      return true;
    } else {
      return false;
    }
  }
  /// This meathod called when user pressed back button
  /// When profile page is about to close
  /// Maintain minimum user's profile in profile page list
  Future<bool> _onWillPop() async {
    final state = Provider.of<AuthState>(context, listen: false);

    /// It will remove last user's profile from profileUserModelList
    state.removeLastUser();
    return true;
  }

  TabController _tabController;

  @override
  build(BuildContext context) {
    var state = Provider.of<FeedState>(context);
    var authstate = Provider.of<AuthState>(context);
    List<FeedModel> list;
    String id = widget.profileId ?? authstate.userId;

    /// Filter user's tweet among all tweets available in home page tweets list
    if (state.feedlist != null && state.feedlist.length > 0) {
      list = state.feedlist.where((x) => x.userId == id).toList();
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: !isMyProfile ? null : _floatingActionButton(),
        body: NestedScrollView(
          // controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
            return <Widget>[
              getAppbar(),
              authstate.isbusy
                  ? _emptyBox()
                  : SliverToBoxAdapter(
                      child: Container(
                        child: authstate.isbusy
                            ? SizedBox.shrink()
                            : UserNameRowWidget(
                                user: authstate.profileUserModel,
                                isMyProfile: isMyProfile,
                              ),
                      ),
                    ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      child: TabBar(
                        indicator: TabIndicator(),
                        controller: _tabController,
                        tabs: <Widget>[
                          Text("Posts"),
                          Text("Posts & replies"),
                          Text("Media")
                        ],
                      ),
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              /// Display all independent tweers list
              _tweetList(context, authstate, list, false, false),

              /// Display all reply tweet list
              _tweetList(context, authstate, list, true, false),

              /// Display all reply and comments tweet list
              _tweetList(context, authstate, list, false, true)
            ],
          ),
        ),
      ),
    );
  }

  Widget _tweetList(BuildContext context, AuthState authstate,
      List<FeedModel> tweetsList, bool isreply, bool isMedia) {
    List<FeedModel> list;

    /// If user hasn't tweeted yet
    if (tweetsList == null) {
      // cprint('No Tweet avalible');
    } else if (isMedia) {
      /// Display all Tweets with media file

      list = tweetsList.where((x) => x.imagePath != null).toList();
    } else if (!isreply) {
      /// Display all independent Tweets
      /// No comments Tweet will display

      list = tweetsList
          .where((x) => x.parentkey == null || x.childRetwetkey != null)
          .toList();
    } else {
      /// Display all reply Tweets
      /// No intependent tweet will display
      list = tweetsList
          .where((x) => x.parentkey != null && x.childRetwetkey == null)
          .toList();
    }

    /// if [authState.isbusy] is true then an loading indicator will be displayed on screen.
    return authstate.isbusy
        ? Container(
            height: fullHeight(context) - 180,
            child: CustomScreenLoader(
              height: double.infinity,
              width: fullWidth(context),
          ),
          )

        /// if tweet list is empty or null then need to show user a message
        : list == null || list.length < 1
            ? Container(
                padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                child: NotifyText(
                  title: isMyProfile
                      ? 'You haven\'t ${isreply ? 'reply to any Post' : isMedia ? 'post any media Post yet' : 'post any Post yet'}'
                      : '${authstate.profileUserModel.userName} hasn\'t ${isreply ? 'reply to any Post' : isMedia ? 'post any media Watch yet' : 'post any Watch yet'}',
                  subTitle: isMyProfile
                      ? 'Tap Post button to add new'
                      : 'Once he\'ll do, they will be shown up here',
                ),
              )

            /// If tweets available then tweet list will displayed
            : ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 0),
                itemCount: list.length,
                itemBuilder: (context, index) => Container(
                  child: Tweet(
                    model: list[index],
                    isDisplayOnProfile: true,
                    // trailing: TweetBottomSheet().tweetOptionIcon(
                    //   context,
                    //   list[index],
                    //   TweetType.Tweet,
                    // ),
                  ),
                ),
              );
  }
}

class UserNameRowWidget extends StatelessWidget {
  const UserNameRowWidget({
    Key key,
    @required this.user,
    @required this.isMyProfile,
  }) : super(key: key);

  final bool isMyProfile;
  final UserModel user;

  String getBio(String bio) {
    if (isMyProfile) {
      return bio;
    } else if (bio == "Edit profile to update bio") {
      return "No bio available";
    } else {
      return bio;
    }
  }

  Widget _tappbleText(
      BuildContext context, String count, String text, String navigateTo) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/$navigateTo');
      },
      child: Row(
        children: <Widget>[
          customText(
            '$count ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          customText(
            '$text',
            style: TextStyle(color: AppColor.darkGrey, fontSize: 17),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context,notifier,child) {
        return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              children: <Widget>[
                UrlText(
                  text: user.displayName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: notifier.darkTheme ? Colors.white : Colors.black
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                user.isVerified
                    ? customIcon(context,
                    icon: AppIcon.blueTick,
                    istwitterIcon: true,
                    iconColor: AppColor.primary,
                    size: 13,
                    paddingIcon: 3)
                    : SizedBox(width: 0),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 9),
            child: customText(
              '${user.userName}',
              style: subtitleStyle.copyWith(fontSize: 13),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: customText(
              getBio(user.bio),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Consumer<ThemeNotifier>(
              builder: (context,notifier,child) => SwitchListTile(
                activeColor: Color(0xff151d3a),
                title: Text("Dark Mode",style: TextStyle(color: notifier.darkTheme ? Colors.white :Color(0xff151d3a),fontWeight: FontWeight.bold),),
                onChanged: (val){
                  notifier.toggleTheme();
                  print(notifier.darkTheme);
                },
                value: notifier.darkTheme,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                customIcon(context,
                    icon: AppIcon.locationPin,
                    size: 14,
                    istwitterIcon: true,
                    paddingIcon: 5,
                    iconColor: AppColor.darkGrey),
                SizedBox(width: 10),
                Expanded(
                  child: customText(
                    user.location,
                    style: TextStyle(color: AppColor.darkGrey),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: <Widget>[
                customIcon(context,
                    icon: AppIcon.calender,
                    size: 14,
                    istwitterIcon: true,
                    paddingIcon: 5,
                    iconColor: AppColor.darkGrey),
                SizedBox(width: 10),
                customText(
                  getJoiningDate(user.createdAt),
                  style: TextStyle(color: AppColor.darkGrey),
                ),
              ],
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   child: Row(
          //     children: <Widget>[
          //       SizedBox(
          //         width: 10,
          //         height: 30,
          //       ),
          //       _tappbleText(context, '${user.getFollower()}', ' Followers',
          //           'FollowerListPage'),
          //       SizedBox(width: 40),
          //       _tappbleText(context, '${user.getFollowing()}', ' Following',
          //           'FollowingListPage'),
          //     ],
          //   ),
          // ),
        ],
      );
      }
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final IconData icon;
  final String title;
}

// const List<Choice> choices = const <Choice>[
//   const Choice(title: 'Share', icon: Icons.directions_car),
//   const Choice(title: 'Draft', icon: Icons.directions_bike),
//   const Choice(title: 'View Lists', icon: Icons.directions_boat),
//   const Choice(title: 'View Moments', icon: Icons.directions_bus),
//   const Choice(title: 'QR code', icon: Icons.directions_railway),
// ];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
