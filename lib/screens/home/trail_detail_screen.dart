import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as int;
    final trail = context.watch<TrailsProvider>().findById(id);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.7),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(trail.thumbnailImageSrc), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Spacer(),
              // content
              Container(
                color: Colors.black.withOpacity(0.7),
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  children: [
                    // title
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        trail.title,
                        style:
                            Fonts().primaryText.copyWith(color: Colors.white),
                      ),
                    ), // title
                    // distance and tree count
                    Container(
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Distance',
                                style: Fonts()
                                    .secondaryText
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                '${trail.distanceMeters / 1000} km',
                                style: Fonts()
                                    .secondaryText
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tree Count',
                                style: Fonts()
                                    .secondaryText
                                    .copyWith(color: Colors.white),
                              ),
                              Text(
                                trail.trees.length.toString(),
                                style: Fonts()
                                    .secondaryText
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 3,
                          ),
                        ),
                      ),
                    ), // distance and tree count
                    // description
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 3,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Scrollbar(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Text(
                                trail.description,
                                style: Fonts()
                                    .secondaryText
                                    .copyWith(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // view trail button
                    BlockButton(
                      onPressed: () {
                        // TODO: trail preview screen
                      },
                      height: 50,
                      title: Text(
                        'View Trail',
                        style: Fonts().primaryText,
                      ),
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

// Column(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height / 3,
//                       ),
//                       Container(
//                         color: Colors.black.withOpacity(0.7),
//                         padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                         child: Column(
//                           children: [
//                             // title
//                             Container(
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.only(bottom: 20),
//                               child: Text(
//                                 trail.title,
//                                 style: Fonts()
//                                     .primaryText
//                                     .copyWith(color: Colors.white),
//                               ),
//                             ), // title
//                             // distance and tree count
//                             Container(
//                               child: Row(
//                                 children: [
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Distance',
//                                         style: Fonts()
//                                             .secondaryText
//                                             .copyWith(color: Colors.white),
//                                       ),
//                                       Text(
//                                         '${trail.distanceMeters / 1000} km',
//                                         style: Fonts()
//                                             .secondaryText
//                                             .copyWith(color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Tree Count',
//                                         style: Fonts()
//                                             .secondaryText
//                                             .copyWith(color: Colors.white),
//                                       ),
//                                       Text(
//                                         trail.trees.length.toString(),
//                                         style: Fonts()
//                                             .secondaryText
//                                             .copyWith(color: Colors.white),
//                                       ),
//                                     ],
//                                   ),
//                                   Spacer(),
//                                 ],
//                               ),
//                               padding: EdgeInsets.only(bottom: 20),
//                               decoration: BoxDecoration(
//                                 border: Border(
//                                   bottom: BorderSide(
//                                     color: Colors.white,
//                                     width: 3,
//                                   ),
//                                 ),
//                               ),
//                             ), // distance and tree count
//                             // description
//                             Container(
//                               padding: EdgeInsets.only(top: 20),
//                               child: Text(
//                                 trail.description,
//                                 style: Fonts()
//                                     .secondaryText
//                                     .copyWith(color: Colors.white),
//                               ),
//                             ),
//                             // view trail button
//                             BlockButton(
//                               onPressed: () {
//                                 // TODO: trail preview screen
//                               },
//                               height: 50,
//                               title: Text(
//                                 'View Trail',
//                                 style: Fonts().primaryText,
//                               ),
//                               color: Colors.white,
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
