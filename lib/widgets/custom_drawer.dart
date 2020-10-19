import 'package:TreeTrek/screens/auth_wrapper_screen.dart';
import 'package:TreeTrek/services/auth_service.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: CustomTheme.primaryThemeColor,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        size: 70,
                        color: Colors.white,
                      ),
                      Text(
                        'Guests',
                        style: Fonts.primaryText.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              CustomDrawerTile(
                title: 'trails',
                route: '/trail-list',
              ),
              CustomDrawerTile(
                title: 'Trail History',
                route: '/trail-history',
              ),
              CustomDrawerTile(
                title: 'My Stats',
                route: '/my-stats',
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.white, width: 3),
                  ),
                  color: Colors.yellow,
                ),
              ),
              CustomDrawerTile(
                title: 'About',
                route: '/about',
              ),
              Container(
                height: 60,
                child: InkWell(
                  onTap: () {
                    context.read<AuthService>().signOut();
                  },
                  child: Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Logout',
                            style: Fonts.secondaryText
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
