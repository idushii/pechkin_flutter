import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopiedText extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextOverflow? overflow;
  final int? minWidth;

  const CopiedText(this.text, {super.key, this.maxLines, this.overflow, this.minWidth});

  Widget _text() {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          width: 250,
          duration: Duration(milliseconds: 600),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: false,
          content: Text('Скопировано в буфер обмена'),
        ));
      },
      child: minWidth != null
          ? Container(
              constraints: BoxConstraints(
                minWidth: minWidth!.toDouble(),
              ),
              child: _text(),
            )
          : _text(),
    );
  }
}
