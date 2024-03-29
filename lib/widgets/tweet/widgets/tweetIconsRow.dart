import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/helper/constant.dart';
import 'package:watch_admin/helper/customRoute.dart';
import 'package:watch_admin/helper/enum.dart';
import 'package:watch_admin/helper/theme.dart';
import 'package:watch_admin/helper/utility.dart';
import 'package:watch_admin/models/feedModel.dart';
import 'package:watch_admin/screens/usersListPage.dart';
import 'package:watch_admin/state/authState.dart';
import 'package:watch_admin/state/chats/chatState.dart';
import 'package:watch_admin/state/feedState.dart';
import 'package:watch_admin/widgets/customWidgets.dart';
import 'package:watch_admin/widgets/tweet/widgets/tweetBottomSheet.dart';

class TweetIconsRow extends StatelessWidget {
  final FeedModel model;
  final Color iconColor;
  final Color iconEnableColor;
  final double size;
  final bool isTweetDetail;
  final TweetType type;
  const TweetIconsRow(
      {Key key,
        this.model,
        this.iconColor,
        this.iconEnableColor,
        this.size,
        this.isTweetDetail = false,
        this.type})
      : super(key: key);

  Widget _likeCommentsIcons(BuildContext context, FeedModel model) {
    var authState = Provider.of<AuthState>(context, listen: false);

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          _iconWidget(
            context,
            text: isTweetDetail ? '' : model.commentCount.toString(),
            icon: AppIcon.reply,
            sysIcon: Icons.chat,
            iconColor: iconColor,
            size: size ?? 20,
            onPressed: () {
              var state = Provider.of<FeedState>(context, listen: false);
              state.setTweetToReply = model;
              Navigator.of(context).pushNamed('/ComposeTweetPage');
            },
          ),
          _iconWidget(context,
              text: isTweetDetail ? '' : model.retweetCount.toString(),
              icon: AppIcon.retweet,
              sysIcon: Icons.refresh,
              iconColor: iconColor,
              size: size ?? 20, onPressed: () {
                TweetBottomSheet().openRetweetbottomSheet(context, type, model);
              }),
          _iconWidget(
            context,
            text: isTweetDetail ? '' : model.likeCount.toString(),
            icon: model.likeList.any((userId) => userId == authState.userId)
                ? AppIcon.heartFill
                : AppIcon.heartEmpty,
            sysIcon: model.likeList.any((userId) => userId == authState.userId)
                ? Icons.favorite: Icons.favorite_border,
            onPressed: () {
              addLikeToTweet(context);
            },
            iconColor:
            model.likeList.any((userId) => userId == authState.userId)
                ? iconEnableColor
                : iconColor,
            size: size ?? 20,
          ),
          _iconWidget(context, text: '', icon: null, sysIcon: Icons.share,
              onPressed: () {
                share('${model.description}',
                    subject: '${model.user.displayName}\'s post');
              }, iconColor: iconColor, size: size ?? 20),
        ],
      ),
    );
  }

  Widget _iconWidget(BuildContext context,
      {String text,
        int icon,
        Function onPressed,
        IconData sysIcon,
        Color iconColor,
        double size = 20}) {
    return Expanded(
      child: Container(
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  if (onPressed != null) onPressed();
                },
                icon: Icon(sysIcon, color: iconColor, size: size)
              // : customIcon(
              //     context,
              //     size: size,
              //     icon: icon,
              //     istwitterIcon: true,
              //     iconColor: iconColor,
              //   ),
            ),
            customText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: iconColor,
                fontSize: size - 5,
              ),
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 8),
        Row(
          children: <Widget>[
            SizedBox(width: 5),
            customText(getPostTime2(model.createdAt), style: textStyle14),
            SizedBox(width: 10),
            customText('Elite Edge Ware',
                style: TextStyle(color: Theme.of(context).primaryColor))
          ],
        ),
        SizedBox(height: 5),
      ],
    );
  }

  Widget _likeCommentWidget(BuildContext context) {
    bool isLikeAvailable = model.likeCount != null ?  model.likeCount > 0 : false;
    bool isRetweetAvailable = model.retweetCount > 0;
    bool isLikeRetweetAvailable = isRetweetAvailable || isLikeAvailable;
    return Column(
      children: <Widget>[
        Divider(
          endIndent: 10,
          height: 0,
        ),
        AnimatedContainer(
          padding:
          EdgeInsets.symmetric(vertical: isLikeRetweetAvailable ? 12 : 0),
          duration: Duration(milliseconds: 500),
          child: !isLikeRetweetAvailable
              ? SizedBox.shrink()
              : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              !isRetweetAvailable
                  ? SizedBox.shrink()
                  : customText(model.retweetCount.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              !isRetweetAvailable
                  ? SizedBox.shrink()
                  : SizedBox(width: 5),
              AnimatedCrossFade(
                firstChild: SizedBox.shrink(),
                secondChild: customText('Retweets', style: subtitleStyle),
                crossFadeState: !isRetweetAvailable
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 800),
              ),
              !isRetweetAvailable
                  ? SizedBox.shrink()
                  : SizedBox(width: 20),
              InkWell(
                onTap: () {
                  onLikeTextPressed(context);
                },
                child: AnimatedCrossFade(
                  firstChild: SizedBox.shrink(),
                  secondChild: Row(
                    children: <Widget>[
                      customSwitcherWidget(
                        duraton: Duration(milliseconds: 300),
                        child: customText(model.likeCount.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                            key: ValueKey(model.likeCount)),
                      ),
                      SizedBox(width: 5),
                      customText('Likes', style: subtitleStyle)
                    ],
                  ),
                  crossFadeState: !isLikeAvailable
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 300),
                ),
              )
            ],
          ),
        ),
        !isLikeRetweetAvailable
            ? SizedBox.shrink()
            : Divider(
          endIndent: 10,
          height: 0,
        ),
      ],
    );
  }

  void addLikeToTweet(BuildContext context) {
    var state = Provider.of<FeedState>(context, listen: false);
    var authState = Provider.of<AuthState>(context, listen: false);
    state.addLikeToTweet(model, authState.userId);
  }

  void onLikeTextPressed(BuildContext context) {
    Navigator.of(context).push(
      CustomRoute<bool>(
        builder: (BuildContext context) => UsersListPage(
          pageTitle: "Liked by",
          userIdsList: model.likeList.map((userId) => userId).toList(),
          emptyScreenText: "This tweet has no like yet",
          emptyScreenSubTileText: "Once a user likes this tweet, user list will be shown here",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            isTweetDetail ? _timeWidget(context) : SizedBox(),
            isTweetDetail ? _likeCommentWidget(context) : SizedBox(),
            _likeCommentsIcons(context, model)
          ],
        ));
  }
}