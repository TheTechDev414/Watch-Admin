import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/helper/constant.dart';
import 'package:watch_admin/helper/enum.dart';
import 'package:watch_admin/helper/theme.dart';
import 'package:watch_admin/models/feedModel.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/widgets/customWidgets.dart';

class TweetBottomSheet {
  Widget tweetOptionIcon(
      BuildContext context, FeedModel model, TweetType type) {
    return customInkWell(
        radius: BorderRadius.circular(20),
        context: context,
        onPressed: () {
          _openbottomSheet(context, type, model);
        },
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: customIcon(context,
              icon: AppIcon.arrowDown,
              istwitterIcon: true,
              iconColor: AppColor.lightGrey),
        ));
  }

  void _openbottomSheet(
      BuildContext context, TweetType type, FeedModel model) async {
    var authState = Provider.of<AuthState>(context, listen: false);
    bool isMyTweet = authState.userId == model.userId;
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            padding: EdgeInsets.only(top: 5, bottom: 0),
            height:50,
            width: fullWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: _tweetOptions(context, isMyTweet, model, type));
      },
    );
  }
  //
  Widget _tweetDetailOptions(
      BuildContext context, bool isMyTweet, FeedModel model, TweetType type) {
    return Column(
      children: <Widget>[
        Container(
          width: fullWidth(context) * .1,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        // _widgetBottomSheetRow(
        //   context,
        //   AppIcon.link,
        //   text: 'Copy link to post',
        // ),
        // isMyTweet
        //     ? _widgetBottomSheetRow(
        //   context,
        //   AppIcon.unFollow,
        //   text: 'Pin to profile',
        // )
        //     : _widgetBottomSheetRow(
        //   context,
        //   AppIcon.unFollow,
        //   text: 'Unfollow ${model.user.userName}',
        // ),

         _widgetBottomSheetRow(
          context,
          AppIcon.delete,
          text: 'Delete Post',
          onPressed: () {
            _deleteTweet(
              context,
              type,
              model.key,
              parentkey: model.parentkey,
            );
          },
          isEnable: true,
        )
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.mute,
        //         text: 'Mute ${model.user.userName}',
        //       ),
        // _widgetBottomSheetRow(
        //   context,
        //   AppIcon.mute,
        //   text: 'Mute this convertion',
        // ),
        // _widgetBottomSheetRow(
        //   context,
        //   AppIcon.viewHidden,
        //   text: 'View hidden replies',
        // ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.block,
        //         text: 'Block ${model.user.userName}',
        //       ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.report,
        //         text: 'Report Tweet',
        //       ),
      ],
    );
  }

  Widget _tweetOptions(
      BuildContext context, bool isMyTweet, FeedModel model, TweetType type) {
    return Column(
      children: <Widget>[
        // Container(
        //   width: fullWidth(context) * .1,
        //   height: 5,
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).dividerColor,
        //     borderRadius: BorderRadius.all(
        //       Radius.circular(10),
        //     ),
        //   ),
        // ),
        // _widgetBottomSheetRow(
        //   context,
        //   AppIcon.link,
        //   text: 'Copy link to tweet',
        // ),
        // isMyTweet
        //     ? _widgetBottomSheetRow(
        //         context,
        //         AppIcon.thumbpinFill,
        //         text: 'Pin to profile',
        //       )
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.sadFace,
        //         text: 'Not interested in this',
        //       ),
        _widgetBottomSheetRow(
          context,
          AppIcon.delete,
          text: 'Delete Post',
          onPressed: () {
            _deleteTweet(
              context,
              type,
              model.key,
              parentkey: model.parentkey,
            );
          },
          isEnable: true,
        ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.unFollow,
        //         text: 'Unfollow ${model.user.userName}',
        //       ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.mute,
        //         text: 'Mute ${model.user.userName}',
        //       ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.block,
        //         text: 'Block ${model.user.userName}',
        //       ),
        // isMyTweet
        //     ? Container()
        //     : _widgetBottomSheetRow(
        //         context,
        //         AppIcon.report,
        //         text: 'Report Post',
        //       ),
      ],
    );
  }

  Widget _widgetBottomSheetRow(BuildContext context, int icon,
      {String text, Function onPressed, bool isEnable = false}) {
    return Expanded(
      child: customInkWell(
        color: Colors.white,
        context: context,
        onPressed: () {
          if (onPressed != null)
            onPressed();
          else {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              customIcon(
                context,
                icon: icon,
                istwitterIcon: true,
                size: 25,
                paddingIcon: 8,
                iconColor: isEnable ? AppColor.darkGrey : AppColor.lightGrey,
              ),
              SizedBox(
                width: 15,
              ),
              customText(
                text,
                context: context,
                style: TextStyle(
                  color: isEnable ? AppColor.secondary : AppColor.lightGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _deleteTweet(BuildContext context, TweetType type, String tweetId,
      {String parentkey}) {
    var state = Provider.of<FeedState>(context, listen: false);
    state.deleteTweet(tweetId, type, parentkey: parentkey);
    // CLose bottom sheet
    Navigator.of(context).pop();
    if (type == TweetType.Detail) {
      // Close Tweet detail page
      Navigator.of(context).pop();
      // Remove last tweet from tweet detail stack page
      state.removeLastTweetDetail(tweetId);
    }
  }
  //
  void openRetweetbottomSheet(
      BuildContext context, TweetType type, FeedModel model) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
            padding: EdgeInsets.only(top: 5, bottom: 0),
            height: 130,
            width: fullWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: _retweet(context, model, type));
      },
    );
  }

  Widget _retweet(BuildContext context, FeedModel model, TweetType type) {
    return Column(
      children: <Widget>[
        Container(
          width: fullWidth(context) * .1,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        _widgetBottomSheetRow(
          context,
          AppIcon.retweet,
          text: 'Repost',
        ),
        _widgetBottomSheetRow(
          context,
          AppIcon.edit,
          text: 'Repost with comment',
          isEnable: true,
          onPressed: () {
            var state = Provider.of<FeedState>(context, listen: false);
            // Prepare current Tweet model to reply
            state.setTweetToReply = model;
            Navigator.pop(context);

            /// `/ComposeTweetPage/retweet` route is used to identify that tweet is going to be retweet.
            /// To simple reply on any `Tweet` use `ComposeTweetPage` route.
            Navigator.of(context).pushNamed('/ComposeTweetPage/retweet');
          },
        )
      ],
    );
  }
}