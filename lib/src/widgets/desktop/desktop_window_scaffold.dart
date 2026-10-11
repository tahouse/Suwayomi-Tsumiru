// Copyright (c) 2026 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';

import '../../utils/platform/platform_runtime.dart';
import 'desktop_title_bar.dart';

bool _isReaderLocation(Uri location) {
  final segments = location.pathSegments;
  return segments.length == 4 &&
      segments[0] == 'manga' &&
      segments[2] == 'chapter';
}

bool showDesktopTitleBarForLocation(
  Uri location, {
  required bool readerFullscreen,
  required bool readerChromeVisible,
}) {
  return !readerFullscreen ||
      !_isReaderLocation(location) ||
      readerChromeVisible;
}

bool overlayDesktopTitleBarForLocation(
  Uri location, {
  required bool readerFullscreen,
}) =>
    readerFullscreen && _isReaderLocation(location);

/// Wraps the app with the custom title bar on desktop. Normal windows use a
/// column so the title bar takes layout space. A fullscreen reader overlays it
/// and receives an equivalent safe inset, keeping the zoom viewport stable.
class DesktopWindowScaffold extends StatelessWidget {
  const DesktopWindowScaffold({
    super.key,
    required this.child,
    this.showTitleBar = true,
    this.overlayTitleBar = false,
  });

  final Widget child;
  final bool showTitleBar;
  final bool overlayTitleBar;

  @override
  Widget build(BuildContext context) {
    if (!isDesktopPlatform || !showTitleBar) return child;

    if (overlayTitleBar) {
      final mediaQuery = MediaQuery.of(context);
      return Stack(
        fit: StackFit.expand,
        children: [
          MediaQuery(
            data: mediaQuery.copyWith(
              padding: mediaQuery.padding.copyWith(
                top: mediaQuery.padding.top + kDesktopTitleBarHeight,
              ),
              viewPadding: mediaQuery.viewPadding.copyWith(
                top: mediaQuery.viewPadding.top + kDesktopTitleBarHeight,
              ),
            ),
            child: child,
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: DesktopTitleBar(),
          ),
        ],
      );
    }

    return Column(
      children: [
        const DesktopTitleBar(),
        Expanded(child: child),
      ],
    );
  }
}
