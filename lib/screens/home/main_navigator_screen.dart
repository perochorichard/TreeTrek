import 'package:TreeTrek/providers/screen_navigation_provider.dart';
import 'package:TreeTrek/screens/home/about_screen.dart';
import 'package:TreeTrek/screens/home/my_stats_screen.dart';
import 'package:TreeTrek/screens/home/trail_history_screen.dart';
import 'package:TreeTrek/screens/home/trails_screen.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPath = context.watch<ScreenNavigationProvider>().path ?? '';
    if (currentPath == '') {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (currentPath == '/trail-list') {
      return TrailsScreen();
    }
    if (currentPath == '/trail-history') {
      return TrailHistoryScreen();
    }
    if (currentPath == '/my-stats') {
      return MyStatsScreen();
    }
    if (currentPath == '/about') {
      return AboutScreen();
    }
    return Scaffold(
      body: Center(
        child: Text(
          'There was a problem retrieving pages.',
          style: Fonts.primaryText,
        ),
      ),
    );
  }
}
