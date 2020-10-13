import 'package:TreeTrek/models/trail.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:TreeTrek/widgets/trails_grid_point.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var trails = context.watch<TrailsProvider>().trails;
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('Trails'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                return Provider<Trail>.value(
                    value: trails[i], child: TrailsGridPoint());
              },
              childCount: trails.length,
            ),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          )
        ],
      ),
    );
  }
}

// GridView.builder(
//           itemCount: trails.length,
//           itemBuilder: (context, i) {
//             return Provider<Trail>.value(
//               value: trails[i],
//               child: TrailsGridPoint(),
//             );
//           },
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 5 / 6,
//           ),
//         ),

// Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage(trail.thumbnailImageSrc), fit: BoxFit.cover),
//         ),
//         child: Column(
//           children: [
//             Spacer(),
//             Container(
//               color: Colors.black.withOpacity(0.7),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                 child: Column(
//                   children: <Widget>[
//                     // title
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       padding: EdgeInsets.only(bottom: 20),
//                       child: Text(
//                         trail.title,
//                         style:
//                             Fonts().primaryText.copyWith(color: Colors.white),
//                       ),
//                     ),
//                     // distance and tree count
// Container(
//   child: Row(
//     children: <Widget>[
//       // distance
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Distance',
//             style: Fonts()
//                 .secondaryText
//                 .copyWith(color: Colors.white),
//           ),
//           Text(
//             '${trail.distanceMeters / 1000} km',
//             style: Fonts()
//                 .secondaryText
//                 .copyWith(color: Colors.white),
//           ),
//         ],
//       ),
//       Spacer(),
//       // tree count
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Tree Count',
//             style: Fonts()
//                 .secondaryText
//                 .copyWith(color: Colors.white),
//           ),
//           Text(
//             trail.trees.length.toString(),
//             style: Fonts()
//                 .secondaryText
//                 .copyWith(color: Colors.white),
//           ),
//         ],
//       ),
//       Spacer(),
//     ],
//   ),
//   padding: EdgeInsets.only(bottom: 20),
//   decoration: BoxDecoration(
//     border: Border(
//       bottom: BorderSide(color: Colors.white, width: 3),
//     ),
//   ),
// ),
//                     // description
//                     Container(
//                       child: Text(
//                         trail.description,
//                         style:
//                             Fonts().secondaryText.copyWith(color: Colors.white),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 20),
//                     ),
//                     BlockButton(
//                       onPressed: () {
//                         // TODO: go to trail preview screen
//                       },
//                       title: Text(
//                         'view trail',
//                         style: Fonts().primaryText,
//                       ),
//                       height: 50,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       )

// Column(
//               children: [
//                 Spacer(),
//                 Container(
//                   color: Colors.black.withOpacity(0.7),
//                   padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
//                   child: Column(
//                     children: [
//                       // title
//                       Container(
//                         alignment: Alignment.centerLeft,
//                         padding: EdgeInsets.only(bottom: 20),
//                         child: Text(
//                           trail.title,
//                           style:
//                               Fonts().primaryText.copyWith(color: Colors.white),
//                         ),
//                       ), // title
//                       // distance and tree count
//                       Container(
//                         child: Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Distance',
//                                   style: Fonts()
//                                       .secondaryText
//                                       .copyWith(color: Colors.white),
//                                 ),
//                                 Text(
//                                   '${trail.distanceMeters / 1000} km',
//                                   style: Fonts()
//                                       .secondaryText
//                                       .copyWith(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Tree Count',
//                                   style: Fonts()
//                                       .secondaryText
//                                       .copyWith(color: Colors.white),
//                                 ),
//                                 Text(
//                                   trail.trees.length.toString(),
//                                   style: Fonts()
//                                       .secondaryText
//                                       .copyWith(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                           ],
//                         ),
//                         padding: EdgeInsets.only(bottom: 20),
//                         decoration: BoxDecoration(
//                           border: Border(
//                             bottom: BorderSide(
//                               color: Colors.white,
//                               width: 3,
//                             ),
//                           ),
//                         ),
//                       ), // distance and tree count
//                       // description
//                       Container(
//                         child: Text(
//                           trail.description,
//                           style: Fonts()
//                               .secondaryText
//                               .copyWith(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
