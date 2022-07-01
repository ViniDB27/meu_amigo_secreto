import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


import './app_colors.dart';


class AppFonts {  
  static final textOrAuth = GoogleFonts.itim(
    fontSize: 32,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
  );
  
  static final textForgotPassword = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );
  
  static final textInput = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textGrey
  );
  
  static final titleGroupCard = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );
  
  static final textGroupCard = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );
  
  static final createGroupEventData = GoogleFonts.itim(
    fontSize: 40,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );
  static final textProfile = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );
}