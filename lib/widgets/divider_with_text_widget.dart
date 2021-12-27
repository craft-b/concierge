import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  final String dividerText;
   const DividerWithText({Key? key, required this.dividerText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(child: Padding(
          padding: EdgeInsets.only(right:8.0),
          child: Divider(),
        )),
        Text(dividerText),
        const Expanded(child: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Divider(),
        )),
      ],
    );
  }
}