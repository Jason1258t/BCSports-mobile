import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final TextStyle _font = GoogleFonts.geologica(
    color: Colors.white,
    height: 1
  );

  static final font44w800 = _font.copyWith(
    fontWeight: FontWeight.bold,
    fontSize: 44
  );

  static final font14w300 = _font.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w300
  );

  static final font16w600 = _font.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600
  );

  
  static final font16w500 = _font.copyWith(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500
  );
}
