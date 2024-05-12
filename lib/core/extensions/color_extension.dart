import 'dart:ui';

extension ColorToColorFilter on Color {
  ColorFilter get filter {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}
