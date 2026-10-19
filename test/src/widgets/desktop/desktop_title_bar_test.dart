// Copyright (c) 2026 Contributors to the Suwayomi project
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tsumiru/src/widgets/desktop/desktop_title_bar.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('window_manager');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      if (call.method == 'isMaximized' || call.method == 'isFullScreen') {
        return false;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  testWidgets('drag area does not overlap Linux window controls',
      (tester) async {
    if (!Platform.isLinux) return;

    await tester.pumpWidget(
      const MaterialApp(
        home: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(width: 600, child: DesktopTitleBar()),
        ),
      ),
    );
    await tester.pump();

    final dragArea = tester.getRect(find.byKey(desktopTitleBarDragAreaKey));
    final controls = tester.getRect(find.byKey(desktopTitleBarControlsKey));

    expect(dragArea.right, controls.left);
    expect(dragArea.overlaps(controls), isFalse);
  });
}