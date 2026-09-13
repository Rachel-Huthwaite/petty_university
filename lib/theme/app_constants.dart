
class AppConstants {
  AppConstants._();

  static const double cornerRadius = 51;

  // Glass effect spec (Figma) — used as reference when tuning
  // GlassContainer's BackdropFilter blur + overlay opacity in Issue 5.1.
  static const double glassRefraction = 94;
  static const double glassDepth = 41;
  static const double glassDispersion = 40;
  static const double glassFrost = 23;
  static const double glassSplay = 17;

  // Wallpaper asset paths (drop exported PNGs into assets/images/)
  static const String wallpaperHome = 'assets/images/pettyUniversity001.png';
  static const String wallpaperTimer = 'assets/images/pettyUniversity002.png';
  static const String wallpaperCases = 'assets/images/pettyUniversity003.png';
  static const String wallpaperUnpack = 'assets/images/pettyUniversity004.png';
  static const String wallpaperEntry = 'assets/images/pettyUniversity005.png';

  // Mindfulness timer duration
  static const Duration mindfulnessDuration = Duration(minutes: 2);
}
