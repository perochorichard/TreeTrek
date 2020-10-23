import 'package:TreeTrek/providers/screen_navigation_provider.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerTile extends StatelessWidget {
  final String title;
  final String route;
  CustomDrawerTile({this.title, this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: InkWell(
        onTap: () {
          context.read<ScreenNavigationProvider>().path = route;
        },
        child: Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  title,
                  style: Fonts.secondaryText.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
