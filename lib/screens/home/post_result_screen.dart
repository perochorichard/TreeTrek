import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int id = ModalRoute.of(context).settings.arguments as int;
    Trail trail = context.watch<TrailsProvider>().findById(id);

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'Trail Completion Report',
          style: Fonts.primaryText.copyWith(color: Colors.white),
        ),
        backgroundColor: CustomTheme.primaryThemeColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              trail.title,
              style: Fonts.primaryText,
            ),
            Text(
              '${trail.trees.length} trees explored',
              style: Fonts.primaryText,
            ),
            Text(
              '${trail.distanceMeters / 1000} km trekked.',
              style: Fonts.primaryText,
            ),
            Spacer(),
            BlockButton(
              onPressed: () {
                Navigator.pop(context);
              },
              height: 50,
              title: Text(
                'Finish',
                style: Fonts.primaryText.copyWith(color: Colors.white),
              ),
              color: CustomTheme.primaryThemeColor,
            ),
          ],
        ),
      ),
    );
  }
}
