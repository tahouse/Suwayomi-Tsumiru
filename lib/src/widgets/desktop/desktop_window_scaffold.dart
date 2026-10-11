// Copyright (c) 2026 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter/material.dart';

import '../../utils/platform/platform_runtime.dart';
import 'desktop_title_bar.dart';

bool showDesktopTitleBarForLocation(
  Uri location, {
  required bool readerFullscreen,
  required bool readerChromeVisible,
}) {
  final segments = location.pathSegments;
  final isReader =
      segments.length == 4 &&
      segments[0] == 'manga' &&
      segments[2] == 'chapter';
  return !readerFullscreen || !isReader || readerChromeVisible;
}

/// Wraps the app with the custom title bar on desktop. A Column, not an
/// overlay Stack — the opaque bar must push content down, never occlude it
/// (macOS traffic lights float over the bar's left edge).
class DesktopWindowScaffold extends StatelessWidget {
  const DesktopWindowScaffold({
    super.key,
    required this.child,
    this.showTitleBar = true,
  });

  final Widget child;
  final bool showTitleBar;

  @override
  Widget build(BuildContext context) {
    if (!isDesktopPlatform || !showTitleBar) return child;

    return Column(
      children: [
        const DesktopTitleBar(),
        Expanded(child: child),
      ],
    );
  }
}
