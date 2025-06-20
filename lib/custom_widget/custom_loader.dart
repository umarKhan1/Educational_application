import 'dart:ui';
import 'package:flutter/material.dart';

/// Call this to show the loader:
void showGlassLoader(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: 'Loader',
    useRootNavigator: true,
    barrierColor: Colors.black.withValues(alpha:  0.2),
    pageBuilder: (_, __, ___) => const _GlassLoaderOverlay(),
  );
}


void hideGlassLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

class _GlassLoaderOverlay extends StatelessWidget {
  const _GlassLoaderOverlay();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors
          .transparent, // so the barrierColor shows through behind the filter
      body: Stack(
        children: [
          // 1) blur the entire screen behind
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: Colors.transparent),
          ),

          // 2) center a frosted box with spinner
          Center(
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: theme.cardColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
