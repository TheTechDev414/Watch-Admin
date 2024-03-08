import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watch_admin/helper/constant.dart';
import 'package:watch_admin/screens/usersListPage.dart';
import 'package:watch_admin/state/authState.dart';

class FollowingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return UsersListPage(
        pageTitle: 'Following',
        userIdsList: state.profileUserModel.followingList,
        appBarIcon: AppIcon.follow,
        emptyScreenText:
            '${state?.profileUserModel?.userName ?? state.userModel.userName} isn\'t follow anyone',
        emptyScreenSubTileText: 'When they do they\'ll be listed here.');
  }
}
