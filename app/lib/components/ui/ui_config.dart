import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';

class UiConfig {
  static final themeData = FluentThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.green,
      menuColor: Color(0xFF1E1E1E),
      acrylicBackgroundColor: Colors.grey.withOpacity(.1),
      iconTheme: IconThemeData(
        color: Color(0xFF1B6770),
      ),
      typography: Typography.raw(
        title: GoogleFonts.sourceSansPro().copyWith(
          fontSize: 36,
          color: Colors.white,
        ),
        subtitle: GoogleFonts.sourceSansPro().copyWith(
          fontSize: 24,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.sourceSansPro().copyWith(
          fontSize: 16,
          color: Colors.white,
        ),
        bodyStrong: GoogleFonts.sourceSansPro().copyWith(
          fontSize: 12,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        body: GoogleFonts.sourceSansPro().copyWith(
          fontSize: 12,
          color: Colors.white,
        ),
      ));
}
