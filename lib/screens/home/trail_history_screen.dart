import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<TreeTrekUser>();
    var trails = context.watch<TrailsProvider>().trails;

    return Scaffold(
      drawer: CustomDrawer(),
      body: user == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Trails History',
                    style: Fonts.primaryText
                        .copyWith(color: CustomTheme.primaryThemeColor),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme:
                      IconThemeData(color: CustomTheme.primaryThemeColor),
                ),
                if (user.trailHistory.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Text(
                        'Go out there and explore some trails!',
                        style: Fonts.primaryText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var trail = trails
                          .firstWhere((t) => t.id == user.trailHistory[index]);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: CustomTheme.primaryThemeColor,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image(
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    image: AssetImage(trail.thumbnailImageSrc),
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trail.title,
                                      style: Fonts.primaryText
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      '${trail.distanceMeters / 1000} km',
                                      style: Fonts.secondaryText
                                          .copyWith(color: Colors.white),
                                    )
                                  ],
                                ),
                                Spacer(
                                  flex: 5,
                                ),
                              ],
                            )),
                      );
                    },
                    childCount: user.trailHistory.length,
                  ),
                )
              ],
            ),
    );
  }
}
