import 'package:TreeTrek/widgets/custom_drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
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
                      ),
                      Text('Guest'),
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
            ],
          ),
        ),
      ),
    );
  }
}
