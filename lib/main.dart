import 'package:TreeTrek/models/TreeTrekUser.dart';
import 'package:TreeTrek/providers/image_provider.dart';
import 'package:TreeTrek/providers/screen_navigation_provider.dart';
import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/screens/auth_wrapper_screen.dart';
import 'package:TreeTrek/screens/authentication/register_user_screen.dart';
import 'package:TreeTrek/screens/authentication/sign_in_screen.dart';
import 'package:TreeTrek/screens/home/about_screen.dart';
import 'package:TreeTrek/screens/home/maps/explore_screen.dart';
import 'package:TreeTrek/screens/home/maps/preview_trail_screen.dart';
import 'package:TreeTrek/screens/home/my_stats_screen.dart';
import 'package:TreeTrek/screens/home/post_result_screen.dart';
import 'package:TreeTrek/screens/home/trail_detail_screen.dart';
import 'package:TreeTrek/screens/home/trail_history_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/services/database_service.dart';
import 'package:TreeTrek/services/geolocator_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Location().hasPermission().then((value) {
      if (value != PermissionStatus.granted) {
        Location().requestPermission();
      }
    });
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider<ImageServiceProvider>(
          create: (_) => ImageServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => TrailsProvider(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
        Provider<GeolocatorService>(
          create: (_) => GeolocatorService(),
        ),
        ChangeNotifierProvider<ScreenNavigationProvider>(
          create: (_) => ScreenNavigationProvider(),
        )
      ],
      child: Builder(
        builder: (context) {
          var user = context.watch<User>();
          return MultiProvider(
            providers: [
              Provider<DatabaseService>(
                create: (context) => DatabaseService(uid: user.uid),
              ),
              StreamProvider<TreeTrekUser>(
                create: (context) =>
                    context.read<DatabaseService>().updatedTreeTrekUser,
              )
            ],
            child: MaterialApp(
              title: 'TreeTrek',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                primaryTextTheme: TextTheme(
                  headline6: TextStyle(color: Colors.black),
                ),
                primaryIconTheme: IconThemeData(color: Colors.black),
              ),
              home: AuthWrapperScreen(),
              routes: {
                '/sign-in': (context) => SignInScreen(),
                '/register': (context) => RegisterUserScreen(),
                '/trail-detail': (context) => TrailDetailScreen(),
                '/trail-list': (context) => TrailsScreen(),
                '/preview-trail': (context) => PreviewTrailScreen(),
                '/explore': (context) => ExploreScreen(),
                '/post-result': (context) => PostResultScreen(),
                '/my-stats': (context) => MyStatsScreen(),
                '/about': (context) => AboutScreen(),
                '/trail-history': (context) => TrailHistoryScreen(),
              },
            ),
          );
        },
      ),
    );
  }
}
