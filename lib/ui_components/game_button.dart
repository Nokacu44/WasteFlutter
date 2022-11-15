import 'package:flutter/material.dart';

import '../classes/constants.dart';

class GameButton extends StatelessWidget {
  final String _text;
  final void Function()? _function;
  final double _buttonSize;
  const GameButton(this._text, this._function, this._buttonSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      highlightColor: Colors.white,
      splashColor: Colors.blueAccent,
      onTap: _function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white54,
              width: 2,
            ),
          ),
          height: buttonSize,
          width: buttonSize,
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
