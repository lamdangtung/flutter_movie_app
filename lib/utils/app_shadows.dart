import 'package:flutter/material.dart';

abstract class AppShadows {
  static final primaryShadow = BoxShadow(
      color: Colors.white.withOpacity(0.1),
      offset: const Offset(4, 4),
      blurRadius: 15,
      spreadRadius: 0);
}
