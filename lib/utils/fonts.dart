import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final TextStyle _font = GoogleFonts.geologica();

  static final font44w800 = _font.copyWith(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 44
  );

  static final font14w300 = _font.copyWith(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w300
  );
}
