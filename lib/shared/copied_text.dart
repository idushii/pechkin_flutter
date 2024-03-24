import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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

        showToast(
          "Скопировано в буфер обмена",
          context: context,
          position: const StyledToastPosition(align: Alignment.bottomRight, offset: 20.0),
          animDuration: const Duration(milliseconds: 100),
        );
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
