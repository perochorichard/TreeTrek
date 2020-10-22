import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'About TreeTrek',
              style: Fonts.primaryText
                  .copyWith(color: CustomTheme.primaryThemeColor),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: CustomTheme.primaryThemeColor),
          ),
          SliverFillRemaining(
            child: Container(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Image(
                      image: AssetImage('assets/other/longbranch.jpg'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Almost 200 species of Trees have been identified in Long Branch, a neighborhood along the shore of Lake Ontario in the City of Toronto and bounded by two large parks.   This app is designed to help you discover and learn about our Urban Forest and the special trees we have in Long Branch.\n\nThe app has been designed to help visitors and residents  \n\n1) Learn how to identify and recognize trees and \n\n2) Visit our special Heritage Trees and other significant trees in Long Branch.  \n\n3) Learn how to care for trees.',
                      style: Fonts.secondaryText,
                    ),
                  ),
                  Text(
                    'You will never look at trees the same way again after exploring them using Treez!\n\nMany people have been involved in the development of Treez.',
                    style: Fonts.secondaryText,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'Special thanks to:',
                      style: Fonts.primaryText,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        'Richard Perocho',
                        style: Fonts.specialText,
                      ),
                      Text(
                        'App designer, developer and programmer',
                        style: Fonts.secondaryText,
                      )
                    ],
                  ),
                  _CreditText(
                      name: 'Jonathan Dionne',
                      desc:
                          'Lead trail guide and designer and urban forest content writer'),
                  _CreditText(
                      name: 'Nicole Bitter',
                      desc: 'Associate trail guide and designer; photography'),
                  _CreditText(
                      name: 'Lucas Udvarnoky',
                      desc: 'Tree identification and photography'),
                  _CreditText(
                      name: 'Savannah Bein',
                      desc: 'Tree identification and photography'),
                  _CreditText(
                      name: 'Evan Udvarnoky',
                      desc: 'Tree identification and photography'),
                  _CreditText(
                      name: 'Judy Gibson',
                      desc:
                          'Project Head;  Chair, LBNA Tree Canopy Preservation and Enhancement Committee'),
                  _CreditText(name: 'Stephanie Chris', desc: 'Design support'),
                  _CreditText(
                      name: 'Dr Danijela Puric-Mladenovic',
                      desc: 'Project Advisor'),
                  Text(
                    '\n\nLong Branch Neighbourhood private property tree owners and tree stewards for caring for our Gentle Giants and helping to maintain and enhance our Long Branch Urban Forest.' +
                        '\n\n\n\nFunded thanks to a Community Planting & Stewardship Grant from the City of Toronto',
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 100),
                    child: Image(
                      image: AssetImage('assets/other/toronto_blue_logo.png'),
                    ),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}

class _CreditText extends StatelessWidget {
  String name;
  String desc;
  _CreditText({@required this.name, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Text(
            name,
            style: Fonts.primaryText,
          ),
          Text(
            desc,
            style: Fonts.secondaryText,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
