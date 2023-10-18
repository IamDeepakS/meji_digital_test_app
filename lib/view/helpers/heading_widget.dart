import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

headingWidget(heading) {
  return Text(
    heading,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.4),
    ),
  );
}

headingDataWidget(heading) {
  return Text(
    heading,
    style: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
  );
}
