import 'package:flutter/material.dart';

abstract class AppColors {
  static const primaryGradient = LinearGradient(
    colors: [sanJuan, eastBay],
  );
  static const sanJuan = Color(0xFF2B5876);
  static const eastBay = Color(0xFF4E4376);
  static const secondaryGradient =
      LinearGradient(colors: [havelockBlue, blueMarguerite]);
  static const havelockBlue = Color(0xFF64ABDB);
  static const blueMarguerite = Color(0xFF826EC8);
  static const coldPurple = Color(0xFFA6A1E0);
  static const anakiwa = Color(0xFFA1F3FE);
  static final secondaryGradient30 = LinearGradient(
      colors: [havelockBlue.withOpacity(0.3), blueMarguerite.withOpacity(0.3)]);
  static final backgroundGradient = LinearGradient(
      colors: [coldPurple.withOpacity(0.3), anakiwa.withOpacity(0.3)]);
}
