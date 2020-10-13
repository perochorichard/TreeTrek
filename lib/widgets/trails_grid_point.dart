import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailsGridPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var trail = context.watch<Trail>();
    return Padding(
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed('/trail-detail', arguments: trail.id);
            print('going to ${trail.title}');
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(trail.thumbnailImageSrc),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.black.withOpacity(0.7),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trail.title,
                            style: Fonts().primaryText,
                          ),
                          Text(
                            '${trail.distanceMeters / 1000} km',
                            style: Fonts().secondaryText,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
