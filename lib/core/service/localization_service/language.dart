/// Represents the supported languages in the application, each with its associated [Locale],
/// display text, and flag image asset path.
///
/// Each [Language] value contains:
/// - [locale]: The [Locale] object representing the language and region.
/// - [text]: The display name of the language (localized if needed).
/// - [image]: The asset path to the flag image representing the language.
///
/// Example usage:
/// ```dart
/// Language.english.locale // returns Locale('en', 'US')
/// Language.arabic.text    // returns 'العربية'
/// ```
library;

import 'dart:ui';

enum Language {
  english(Locale('en', 'US'), 'English', 'assets/flags/us.png'),
  arabic(Locale('ar', 'SA'), 'العربية', 'assets/flags/sa.png');

  const Language(this.locale, this.text, this.image);
  final Locale locale;
  final String text;
  final String image;
}
