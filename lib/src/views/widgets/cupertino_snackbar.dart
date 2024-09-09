import 'package:flutter/cupertino.dart';

void showCupertinoSnackBar({
  required BuildContext context,
  required String message,
  int durationMillis = 3000,
}) {
  const animationDurationMillis = 200;
  final overlayEntry = OverlayEntry(
    builder: (context) => _CupertinoSnackBar(
      message: message,
      animationDurationMillis: animationDurationMillis,
      waitDurationMillis: durationMillis,
    ),
  );
  Future.delayed(
    Duration(milliseconds: durationMillis + 2 * animationDurationMillis),
    overlayEntry.remove,
  );
  Overlay.of(context).insert(overlayEntry);
}

class _CupertinoSnackBar extends StatefulWidget {
  final String message;
  final int animationDurationMillis;
  final int waitDurationMillis;

  const _CupertinoSnackBar({
    required this.message,
    required this.animationDurationMillis,
    required this.waitDurationMillis,
  });

  @override
  State<_CupertinoSnackBar> createState() => _CupertinoSnackBarState();
}

class _CupertinoSnackBarState extends State<_CupertinoSnackBar> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => setState(() => _show = true));
    Future.delayed(
      Duration(
        milliseconds: widget.waitDurationMillis,
      ),
      () {
        if (mounted) {
          setState(() => _show = false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: _show ? MediaQuery.sizeOf(context).height * 0.8 : MediaQuery.sizeOf(context).height,
      left: 42.0,
      right: 42.0,
      curve: _show ? Curves.linearToEaseOut : Curves.easeInToLinear,
      duration: Duration(milliseconds: widget.animationDurationMillis),
      child: CupertinoPopupSurface(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          child: Text(
            widget.message,
            style: const TextStyle(
              fontSize: 18.0,
              color: CupertinoColors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
