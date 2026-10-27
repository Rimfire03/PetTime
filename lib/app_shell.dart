import 'package:flutter/material.dart';

/// Wraps every screen of the app (it is the MaterialApp `builder`).
///
/// Since Android 15 apps are drawn edge to edge, under the phone's navigation buttons. Without this,
/// the bottom of any screen (the Save button of a form, a floating button) can end up hidden behind them.
/// Doing it once here covers every screen and dialog, including future ones. The top is left alone:
/// the AppBar already looks after the status bar.
Widget withSystemInsets(BuildContext context, Widget? child) => ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(top: false, left: false, right: false, child: child ?? const SizedBox.shrink()),
    );
