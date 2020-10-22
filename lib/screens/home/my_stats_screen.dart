import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyStatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<TreeTrekUser>();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          'My Stats',
          style:
              Fonts.primaryText.copyWith(color: CustomTheme.primaryThemeColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: CustomTheme.primaryThemeColor),
      ),
      body: Container(
        color: CustomTheme.primaryThemeColor,
        padding: EdgeInsets.symmetric(horizontal: 30),
        alignment: Alignment.center,
        child: Column(
          children: [
            Spacer(),
            Text(
              'Hi there Tree Trekker! Since you began your journey with TreeTerk, you\'ve...',
              style: Fonts.primaryText.copyWith(color: Colors.white),
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.eco,
                  size: 70,
                  color: Colors.white,
                ),
                Text(
                  'Seen ${user.treesSeen} trees',
                  style: Fonts.primaryText.copyWith(color: Colors.white),
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.directions_walk,
                  size: 70,
                  color: Colors.white,
                ),
                Text(
                  'Travelled ${user.tavelDistanceMeters / 1000} km',
                  style: Fonts.primaryText.copyWith(color: Colors.white),
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(
                  Icons.map,
                  size: 70,
                  color: Colors.white,
                ),
                Text(
                  'Taken ${user.trailHistory.length} trails',
                  style: Fonts.primaryText.copyWith(color: Colors.white),
                )
              ],
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
