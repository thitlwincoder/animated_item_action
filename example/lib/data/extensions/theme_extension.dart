import 'package:flutter/material.dart';

export 'textstyle_extension.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  Color get primary => theme.colorScheme.primary;

  Color? get iconColor => theme.iconTheme.color;

  TextTheme get textTheme => theme.textTheme;

  TextStyle get bodyLarge => textTheme.bodyLarge!;

  TextStyle get bodyMedium => textTheme.bodyMedium!;

  TextStyle get bodySmall => textTheme.bodySmall!;

  TextStyle get displayLarge => textTheme.displayLarge!;

  TextStyle get displayMedium => textTheme.displayMedium!;

  TextStyle get displaySmall => textTheme.displaySmall!;

  TextStyle get headlineLarge => textTheme.headlineLarge!;

  TextStyle get headlineMedium => textTheme.headlineMedium!;

  TextStyle get headlineSmall => textTheme.headlineSmall!;

  TextStyle get labelLarge => textTheme.labelLarge!;

  TextStyle get labelMedium => textTheme.labelMedium!;

  TextStyle get labelSmall => textTheme.labelSmall!;

  TextStyle get titleLarge => textTheme.titleLarge!;

  TextStyle get titleMedium => textTheme.titleMedium!;

  TextStyle get titleSmall => textTheme.titleSmall!;
}
