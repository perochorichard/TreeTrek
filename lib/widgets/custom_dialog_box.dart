import 'package:TreeTrek/shared/custom_theme.dart';
import 'package:TreeTrek/shared/fonts.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final Widget title;
  final String content;
  final List<Widget> actions;
  CustomDialogBox({
    @required this.title,
    @required this.content,
    @required this.actions,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomTheme.primaryThemeColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: title,
      content: Text(
        content,
        style: Fonts.secondaryText.copyWith(color: Colors.white),
      ),
      actions: actions,
    );
  }
}
