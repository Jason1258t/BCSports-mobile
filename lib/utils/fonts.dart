import 'package:bcsports_mobile/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static final TextStyle _font =
      GoogleFonts.geologica(color: Colors.white, height: 1);

  static final TextStyle _fontAS =
      GoogleFonts.alumniSans(color: Colors.white, height: 1);

  static final font22w800ItalicAS = _fontAS.copyWith(
      fontSize: 22, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic);

  static final font36w800ItalicAS = _fontAS.copyWith(
      fontSize: 36, fontWeight: FontWeight.w800, fontStyle: FontStyle.italic);

  static final font9w600 =
      _font.copyWith(fontSize: 9, fontWeight: FontWeight.w600);

  static final font9w300 =
      _font.copyWith(fontSize: 9, fontWeight: FontWeight.w300);

  static final font12w400 =
      _font.copyWith(fontSize: 12, fontWeight: FontWeight.w400);

  static final font12w300 =
      _font.copyWith(fontSize: 12, fontWeight: FontWeight.w300);

  static final font8w400 =
      _font.copyWith(fontSize: 8, fontWeight: FontWeight.normal);

  static final font10w500 =
      _font.copyWith(fontSize: 10, fontWeight: FontWeight.w500);

  static final font44w800 =
      _font.copyWith(fontWeight: FontWeight.bold, fontSize: 44);

  static final font36w800 =
      _font.copyWith(fontWeight: FontWeight.bold, fontSize: 36);

  static final font12w600 =
      _font.copyWith(fontWeight: FontWeight.w600, fontSize: 12);

  static final font24w600 =
      _font.copyWith(fontWeight: FontWeight.w600, fontSize: 24);

  static final font24w500 =
      _font.copyWith(fontWeight: FontWeight.w500, fontSize: 24);

  static final font23w500 =
      _font.copyWith(fontWeight: FontWeight.w500, fontSize: 23);

  static final font14w300 =
      _font.copyWith(fontSize: 14, fontWeight: FontWeight.w300);

  static final font14w400 =
      _font.copyWith(fontSize: 14, fontWeight: FontWeight.w400);

  static final font14w500 = _font.copyWith(
      fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.white);

  static final font11w300 =
      _font.copyWith(fontSize: 11, fontWeight: FontWeight.w300);

  static final font16w600 =
      _font.copyWith(fontSize: 16, fontWeight: FontWeight.w600);

  static final font16w500 = _font.copyWith(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
  static final font16w400 = _font.copyWith(
      color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
  static final font64w400 = _font.copyWith(
      color: Colors.white, fontSize: 64, fontWeight: FontWeight.w400);

  static final font17w500 =
      _font.copyWith(fontSize: 17, fontWeight: FontWeight.w500);
  static final font17w400 =
      _font.copyWith(fontSize: 17, fontWeight: FontWeight.w400);

  static final font18w600 = _font.copyWith(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600);
  static final font18w500 = _font.copyWith(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
  static final font18w400 = _font.copyWith(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400);

  static final font20w600 = _font.copyWith(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);

  static final font20w400 = _font.copyWith(
      color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400);

  static font20w600WithColor(Color color) =>
      _font.copyWith(color: color, fontSize: 20, fontWeight: FontWeight.w600);

  static final font13w100 = _font.copyWith(
      color: Colors.white, fontSize: 12, fontWeight: FontWeight.w100);
}
