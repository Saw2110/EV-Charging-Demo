import 'package:flutter/material.dart';

extension GapExtension on double {
  SizedBox get xGap => SizedBox(width: this);
  SizedBox get yGap => SizedBox(height: this);
}
