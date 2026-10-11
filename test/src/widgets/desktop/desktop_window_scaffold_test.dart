// Copyright (c) 2026 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'package:flutter_test/flutter_test.dart';
import 'package:tsumiru/src/widgets/desktop/desktop_window_scaffold.dart';

void main() {
  test('fullscreen reader hides the desktop title bar', () {
    final location = Uri.parse('/manga/42/chapter/7');

    expect(
      showDesktopTitleBarForLocation(location, readerFullscreen: true),
      isFalse,
    );
  });

  test('reader keeps the desktop title bar when fullscreen is disabled', () {
    final location = Uri.parse('/manga/42/chapter/7');

    expect(
      showDesktopTitleBarForLocation(location, readerFullscreen: false),
      isTrue,
    );
  });

  test('similarly named settings route keeps the desktop title bar', () {
    final location = Uri.parse('/more/settings/reader');

    expect(
      showDesktopTitleBarForLocation(location, readerFullscreen: true),
      isTrue,
    );
  });
}