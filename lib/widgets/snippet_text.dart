import 'package:flutter/material.dart';

class SnippetText extends StatelessWidget {
  final EdgeInsets padding;
  final TextStyle style;
  final String text;

  SnippetText({
    this.padding,
    this.style,
    @required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: padding,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
