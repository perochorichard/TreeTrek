import 'package:flutter/material.dart';

class BlockButton extends StatelessWidget {
  final Function onPressed;
  final double height;
  final Text title;
  final Color color;

  BlockButton(
      {@required this.onPressed,
      @required this.height,
      @required this.title,
      this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: RaisedButton(
          onPressed: onPressed,
          child: title,
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
