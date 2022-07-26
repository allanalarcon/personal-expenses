import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function selectHandler;

  const AdaptiveFlatButton(this.text, this.selectHandler, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: selectHandler,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            style: (ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor,
              ),
            )),
            onPressed: selectHandler,
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
