// Copyright 2023 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/material.dart';

class UiScaler extends StatelessWidget {
  const UiScaler({
    super.key,
    required this.child,
    required this.alignment,
    this.referenceHeight = 1080,
    this.referenceWidth = 1920,
  });

  final int referenceHeight;
  final int referenceWidth;
  final Widget child;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Scale based on both width and height so UI adapts to narrow devices
    final double scaleH = screenSize.height / referenceHeight;
    final double scaleW = screenSize.width / referenceWidth;
    final double scale = min(min(scaleH, scaleW), 1.0);
    return Transform.scale(scale: scale, alignment: alignment, child: child);
  }
}
