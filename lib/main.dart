import 'package:TreeTrek/providers/trails_provider.dart';
import 'package:TreeTrek/screens/auth_wrapper_screen.dart';
import 'package:TreeTrek/screens/authentication/register_user_screen.dart';
import 'package:TreeTrek/screens/authentication/sign_in_screen.dart';
import 'package:TreeTrek/screens/home/maps/preview_trail_screen.dart';
import 'package:TreeTrek/screens/home/trail_detail_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (context) => TrailsProvider(),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        ),
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
          '/auth-wrapper': (context) => AuthWrapperScreen(),
          '/register': (context) => RegisterUserScreen(),
          '/trail-detail': (context) => TrailDetailScreen(),
          '/trail-list': (context) => TrailsScreen(),
          'preview-trail': (context) => PreviewTrailScreen(),
        },
      ),
    );
  }
}
