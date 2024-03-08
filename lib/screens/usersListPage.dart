import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/helper/theme.dart';
import 'package:watch_admin/models/user.dart';
import 'package:watch_admin/state/searchState.dart';
import 'package:watch_admin/widgets/customAppBar.dart';
import 'package:watch_admin/widgets/customWidgets.dart';
import 'package:watch_admin/widgets/newWidget/emptyList.dart';
import 'package:watch_admin/widgets/newWidget/userListWidget.dart';

class UsersListPage extends StatelessWidget {
  UsersListPage({
    Key key,
    this.pageTitle = "",
    this.appBarIcon,
    this.emptyScreenText,
    this.emptyScreenSubTileText,
    this.userIdsList,
  }) : super(key: key);

  final String pageTitle;
  final String emptyScreenText;
  final String emptyScreenSubTileText;
  final int appBarIcon;
  final List<String> userIdsList;

  @override
  Widget build(BuildContext context) {
    List<UserModel> userList;
    return Scaffold(
      backgroundColor: TwitterColor.mystic,
      appBar: CustomAppBar(
          isBackButton: true,
          title: customTitleText(pageTitle),
          icon: appBarIcon),
      body: Consumer<SearchState>(
        builder: (context, state, child) {
          if (userIdsList != null && userIdsList.isNotEmpty) {
            userList = state.getuserDetail(userIdsList);
          }
          return !(userList != null && userList.isNotEmpty)
              ? Container(
                  width: fullWidth(context),
                  padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                  child: NotifyText(
                    title: emptyScreenText,
                    subTitle: emptyScreenSubTileText,
                  ),
                )
              : UserListWidget(
                  list: userList,
                  emptyScreenText: emptyScreenText,
                  emptyScreenSubTileText: emptyScreenSubTileText,
                );
        },
      ),
    );
  }
}
