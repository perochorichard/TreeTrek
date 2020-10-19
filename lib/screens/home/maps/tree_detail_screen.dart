import 'package:TreeTrek/models/tree.dart';
import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:TreeTrek/widgets/block_button.dart';
import 'package:TreeTrek/widgets/snippet_text.dart';
import 'package:flutter/material.dart';

class TreeDetailScreen extends StatelessWidget {
  final Function onComplete;
  final Tree tree;

  TreeDetailScreen({@required this.onComplete, @required this.tree});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tree.name,
          style: Fonts.primaryText.copyWith(color: Colors.white),
        ),
        backgroundColor: CustomTheme.primaryThemeColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 40),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: tree.snippets.length,
                itemBuilder: (BuildContext context, int i) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: <Widget>[
                        // scientific name
                        if (i == 0)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                style: Fonts.smallText
                                    .copyWith(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(text: 'Scientific Name: '),
                                  TextSpan(
                                      text: tree.scientificName,
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                            ),
                          ),
                        if (tree.snippets[i].imagePath.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: <Widget>[
                                // snippet image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    image:
                                        AssetImage(tree.snippets[i].imagePath),
                                  ),
                                ),
                                // image description
                                SnippetText(
                                  text: tree.snippets[i].imageDesc,
                                  style: Fonts.secondaryText
                                      .copyWith(fontStyle: FontStyle.italic),
                                  padding: EdgeInsets.only(top: 5),
                                ),
                              ],
                            ),
                          ),
                        // average height
                        if (i == 0 && tree.heightMeters > 0)
                          SnippetText(
                            text: 'Average Height: ${tree.heightMeters} m',
                            style: Fonts.smallText,
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                        // native species
                        if (i == 1)
                          SnippetText(
                            text:
                                'Native Species: ${tree.isNative ? 'Yes' : 'No'}',
                            style: Fonts.smallText,
                            padding: EdgeInsets.only(bottom: 10),
                          ),
                        // snippet
                        Text(
                          tree.snippets[i].snippet,
                          style: Fonts.secondaryText,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            BlockButton(
              onPressed: () {
                Navigator.pop(context);
                onComplete();
              },
              height: 50,
              title: Text(
                'Tree Learned!',
                style: Fonts.primaryText.copyWith(color: Colors.white),
              ),
              color: CustomTheme.primaryThemeColor,
            )
          ],
        ),
      ),
    );
  }
}
