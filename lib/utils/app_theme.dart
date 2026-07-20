import 'package:flutter/material.dart';

class ThemeColors {
  ThemeColors._();

  static const Color primaryLight = Color(0xFF1868DB);
  static const Color primaryHoverLight = Color(0xFF1558BC);
  static const Color primaryActiveLight = Color(0xFF144794);

  static const Color bodyLight = Color(0xFF292A2E);
  static const Color bodyDimmedLight = Color(0xFF6B6E76);
  static const Color bodyInverseLight = Color(0xFFFFFFFF);

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundSecondaryLight = Color(0xFFF8F8F8);
  static const Color backgroundInverseLight = Color(0xFF292A2E);

  static const Color borderLight = Color(0x240B120E);
  static const Color formFieldBorderLight = Color(0xFF8C8F97);
  static const Color formFieldBackgroundLight = Color(0xFFFFFFFF);

  static const Color warningLight = Color(0xFFFBC828);
  static const Color infoLight = Color(0xFF1868DB);
  static const Color successLight = Color(0xFF1F845A);
  static const Color dangerLight = Color(0xFFC9372C);
  static const Color dangerHoverLight = Color(0xFFAE2E24);

  static const Color disabledContentLight = Color(0x4A080F21);
  static const Color disabledBackgroundLight = Color(0x08171717);

  static const Color primaryDark = Color(0xFF669DF1);
  static const Color primaryHoverDark = Color(0xFF8FB8F6);
  static const Color primaryActiveDark = Color(0xFFADCBFB);

  static const Color bodyDark = Color(0xFFCECFD2);
  static const Color bodyDimmedDark = Color(0xFF96999E);
  static const Color bodyInverseDark = Color(0xFF1F1F21);

  static const Color backgroundDark = Color(0xFF1F1F21);
  static const Color backgroundSecondaryDark = Color(0xFF18191A);
  static const Color backgroundInverseDark = Color(0xFFCECFD2);

  static const Color borderDark = Color(0x1FE3E4F2); // #E3E4F21F
  static const Color formFieldBorderDark = Color(0xFF7E8188);
  static const Color formFieldBackgroundDark = Color(0xFF242528);

  static const Color warningDark = Color(0xFFFBC828);
  static const Color infoDark = Color(0xFF669DF1);
  static const Color successDark = Color(0xFF4BCE97);
  static const Color dangerDark = Color(0xFFF87168);
  static const Color dangerHoverDark = Color(0xFFFD9891);

  static const Color disabledContentDark = Color(0x40E5E9F6);
  static const Color disabledBackgroundDark = Color(0x0ABDBDBD);

  static const Color grey8 = Color(0xFF292A2E);
  static const Color grey7 = Color(0xFF3B3D42);
  static const Color grey6 = Color(0xFF6B6E76);
  static const Color grey5 = Color(0xFF8C8F97);
  static const Color grey4 = Color(0xFFB7B9BE);
  static const Color grey3 = Color(0xFFDDDEE1);
  static const Color grey2 = Color(0xFFF0F1F2);
  static const Color grey1 = Color(0xFFF8F8F8);
  static const Color greyWhite = Color(0xFFFFFFFF);

  static const Color blurpleLight = Color(0xFFE9F2FE);
  static const Color blurple = Color(0xFF1868DB);
  static const Color blurpleDark = Color(0xFF1558BC);
  static const Color blurpleStrong = Color(0xFF123263);
}

class ThemeSpacing {
  ThemeSpacing._();

  static const double xsmall = 4;
  static const double small = 8;
  static const double halfMedium = 12;
  static const double medium = 16;
  static const double large = 24;
  static const double xlarge = 40;
  static const double xxlarge = 64;
}

class ThemeRadii {
  ThemeRadii._();

  static const double none = 0;
  static const double r25 = 2;
  static const double r50 = 4;
  static const double r75 = 6;
  static const double r100 = 8;
  static const double r150 = 12;
  static const double r200 = 16;
  static const double round = 999;
}

class ThemeShadows {
  ThemeShadows._();

  static const List<BoxShadow> small = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 4), blurRadius: 10),
  ];

  static const List<BoxShadow> medium = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 10),
  ];

  static const List<BoxShadow> large = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 6), blurRadius: 24),
  ];
}

class ThemeTypography {
  ThemeTypography._();

  static const String? fontFamily = null;

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle bodySm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 18 / 12,
    fontWeight: regular,
  );

  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 21 / 14,
    fontWeight: regular,
  );

  static const TextStyle bodyLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 25 / 18,
    letterSpacing: -0.2,
    fontWeight: regular,
  );

  static const TextStyle headingSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 27 / 24,
    letterSpacing: -0.2,
    fontWeight: bold,
  );

  static const TextStyle headingMd = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 36 / 32,
    letterSpacing: -0.5,
    fontWeight: bold,
  );

  static const TextStyle headingLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    height: 55 / 48,
    letterSpacing: -1.2,
    fontWeight: bold,
  );

  static TextStyle mainTitle(Color color) =>
      headingMd.copyWith(fontWeight: bold, color: color);

  static TextStyle title(Color color) =>
      bodyLg.copyWith(fontWeight: bold, color: color);

  static TextStyle body(Color color) =>
      bodyMd.copyWith(fontWeight: regular, color: color);
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: ThemeColors.primaryLight,
      onPrimary: ThemeColors.bodyInverseLight,
      primaryContainer: ThemeColors.blurpleLight,
      onPrimaryContainer: ThemeColors.primaryActiveLight,
      secondary: ThemeColors.infoLight,
      onSecondary: ThemeColors.bodyInverseLight,
      error: ThemeColors.dangerLight,
      onError: ThemeColors.bodyInverseLight,
      surface: ThemeColors.backgroundLight,
      onSurface: ThemeColors.bodyLight,
      surfaceContainerHighest: ThemeColors.backgroundSecondaryLight,
      onSurfaceVariant: ThemeColors.bodyDimmedLight,
      outline: ThemeColors.formFieldBorderLight,
      outlineVariant: ThemeColors.borderLight,
      inverseSurface: ThemeColors.backgroundInverseLight,
      onInverseSurface: ThemeColors.bodyInverseLight,
    );

    return _buildTheme(colorScheme, brightness: Brightness.light);
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: ThemeColors.primaryDark,
      onPrimary: ThemeColors.bodyInverseDark,
      primaryContainer: ThemeColors.blurpleStrong,
      onPrimaryContainer: ThemeColors.primaryActiveDark,
      secondary: ThemeColors.infoDark,
      onSecondary: ThemeColors.bodyInverseDark,
      error: ThemeColors.dangerDark,
      onError: ThemeColors.bodyInverseDark,
      surface: ThemeColors.backgroundDark,
      onSurface: ThemeColors.bodyDark,
      surfaceContainerHighest: ThemeColors.backgroundSecondaryDark,
      onSurfaceVariant: ThemeColors.bodyDimmedDark,
      outline: ThemeColors.formFieldBorderDark,
      outlineVariant: ThemeColors.borderDark,
      inverseSurface: ThemeColors.backgroundInverseDark,
      onInverseSurface: ThemeColors.bodyInverseDark,
    );

    return _buildTheme(colorScheme, brightness: Brightness.dark);
  }

  static ThemeData _buildTheme(
    ColorScheme colorScheme, {
    required Brightness brightness,
  }) {
    final bodyColor = colorScheme.onSurface;
    final dimmedColor = colorScheme.onSurfaceVariant;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      fontFamily: ThemeTypography.fontFamily,

      textTheme: TextTheme(
        displayLarge: ThemeTypography.headingLg.copyWith(color: bodyColor),
        displayMedium: ThemeTypography.headingMd.copyWith(color: bodyColor),
        displaySmall: ThemeTypography.headingSm.copyWith(color: bodyColor),
        headlineLarge: ThemeTypography.headingMd.copyWith(color: bodyColor),
        headlineMedium: ThemeTypography.headingSm.copyWith(color: bodyColor),
        headlineSmall: ThemeTypography.bodyLg.copyWith(
          color: bodyColor,
          fontWeight: ThemeTypography.bold,
        ),
        titleLarge: ThemeTypography.title(bodyColor),
        titleMedium: ThemeTypography.bodyMd.copyWith(
          color: bodyColor,
          fontWeight: ThemeTypography.medium,
        ),
        titleSmall: ThemeTypography.bodySm.copyWith(
          color: bodyColor,
          fontWeight: ThemeTypography.medium,
        ),
        bodyLarge: ThemeTypography.bodyLg.copyWith(color: bodyColor),
        bodyMedium: ThemeTypography.body(bodyColor),
        bodySmall: ThemeTypography.bodySm.copyWith(color: dimmedColor),
        labelLarge: ThemeTypography.bodyMd.copyWith(
          color: bodyColor,
          fontWeight: ThemeTypography.medium,
        ),
        labelMedium: ThemeTypography.bodySm.copyWith(
          color: dimmedColor,
          fontWeight: ThemeTypography.medium,
        ),
        labelSmall: ThemeTypography.bodySm.copyWith(color: dimmedColor),
      ),

      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: bodyColor,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: ThemeTypography.mainTitle(
          bodyColor,
        ).copyWith(fontSize: ThemeTypography.bodyLg.fontSize),
        iconTheme: IconThemeData(color: bodyColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: brightness == Brightness.light
              ? ThemeColors.disabledBackgroundLight
              : ThemeColors.disabledBackgroundDark,
          disabledForegroundColor: brightness == Brightness.light
              ? ThemeColors.disabledContentLight
              : ThemeColors.disabledContentDark,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeSpacing.large,
            vertical: ThemeSpacing.small + ThemeSpacing.xsmall, // 12
          ),
          textStyle: ThemeTypography.bodyMd.copyWith(
            fontWeight: ThemeTypography.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r100),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeSpacing.large,
            vertical: ThemeSpacing.small + ThemeSpacing.xsmall,
          ),
          textStyle: ThemeTypography.bodyMd.copyWith(
            fontWeight: ThemeTypography.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r100),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeSpacing.medium,
            vertical: ThemeSpacing.small,
          ),
          textStyle: ThemeTypography.bodyMd.copyWith(
            fontWeight: ThemeTypography.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r75),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? ThemeColors.formFieldBackgroundLight
            : ThemeColors.formFieldBackgroundDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ThemeSpacing.medium,
          vertical: ThemeSpacing.small + ThemeSpacing.xsmall,
        ),
        hintStyle: ThemeTypography.bodyMd.copyWith(color: dimmedColor),
        labelStyle: ThemeTypography.bodySm.copyWith(color: dimmedColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
          borderSide: BorderSide(
            color: brightness == Brightness.light
                ? ThemeColors.formFieldBorderLight
                : ThemeColors.formFieldBorderDark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
          borderSide: BorderSide(
            color: brightness == Brightness.light
                ? ThemeColors.formFieldBorderLight
                : ThemeColors.formFieldBorderDark,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),

      cardTheme: CardThemeData(
        color: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r150),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),

      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: ThemeSpacing.medium,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: brightness == Brightness.light
            ? ThemeColors.grey2
            : ThemeColors.grey7,
        labelStyle: ThemeTypography.bodySm.copyWith(color: bodyColor),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeSpacing.small,
          vertical: ThemeSpacing.xsmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.round),
        ),
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r150),
        ),
        titleTextStyle: ThemeTypography.title(bodyColor),
        contentTextStyle: ThemeTypography.body(bodyColor),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: brightness == Brightness.light
            ? ThemeColors.backgroundInverseLight
            : ThemeColors.backgroundInverseDark,
        contentTextStyle: ThemeTypography.body(
          brightness == Brightness.light
              ? ThemeColors.bodyInverseLight
              : ThemeColors.bodyInverseDark,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }

          if (brightness == Brightness.light) {
            return ThemeColors.greyWhite;
          }

          return ThemeColors.grey4;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withValues(alpha: 0.5);
          }

          if (brightness == Brightness.light) {
            return ThemeColors.grey3;
          }

          return ThemeColors.grey6;
        }),
      ),

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }

          return Colors.transparent;
        }),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r25),
        ),
      ),

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }

          return colorScheme.outline;
        }),
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: brightness == Brightness.light
              ? ThemeColors.backgroundInverseLight
              : ThemeColors.backgroundInverseDark,
          borderRadius: BorderRadius.circular(ThemeRadii.r50),
        ),
        textStyle: ThemeTypography.bodySm.copyWith(
          color: brightness == Brightness.light
              ? ThemeColors.bodyInverseLight
              : ThemeColors.bodyInverseDark,
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),

      iconTheme: IconThemeData(color: bodyColor, size: 20),

      badgeTheme: BadgeThemeData(
        backgroundColor: colorScheme.error,
        textColor: colorScheme.onError,
        padding: const EdgeInsets.symmetric(horizontal: ThemeSpacing.xsmall),
        textStyle: ThemeTypography.bodySm.copyWith(
          fontWeight: ThemeTypography.medium,
        ),
      ),

      bannerTheme: MaterialBannerThemeData(
        backgroundColor: brightness == Brightness.light
            ? ThemeColors.backgroundSecondaryLight
            : ThemeColors.backgroundSecondaryDark,
        contentTextStyle: ThemeTypography.body(bodyColor),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeSpacing.medium,
          vertical: ThemeSpacing.small,
        ),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeRadii.r150),
          ),
        ),
        showDragHandle: true,
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light
                ? ThemeColors.greyWhite
                : ThemeColors.grey8,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeRadii.r75),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      menuTheme: MenuThemeData(
        style: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(
            brightness == Brightness.light
                ? ThemeColors.greyWhite
                : ThemeColors.grey8,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeRadii.r75),
            ),
          ),
          elevation: const WidgetStatePropertyAll(0),
        ),
      ),

      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(ThemeTypography.bodyMd),
          foregroundColor: WidgetStatePropertyAll(bodyColor),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: ThemeSpacing.medium,
              vertical: ThemeSpacing.small,
            ),
          ),
        ),
      ),

      popupMenuTheme: PopupMenuThemeData(
        color: brightness == Brightness.light
            ? ThemeColors.grey2
            : ThemeColors.grey8,
        textStyle: ThemeTypography.body(bodyColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
        ),
        elevation: 0,
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeSpacing.large,
            vertical: ThemeSpacing.small + ThemeSpacing.xsmall,
          ),
          textStyle: ThemeTypography.bodyMd.copyWith(
            fontWeight: ThemeTypography.medium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r100),
          ),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: bodyColor,
          hoverColor: brightness == Brightness.light
              ? ThemeColors.backgroundLight.withValues(alpha: 0.06)
              : ThemeColors.backgroundDark.withValues(alpha: 0.06),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r75),
          ),
        ),
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStatePropertyAll(
          brightness == Brightness.light
              ? ThemeColors.formFieldBackgroundLight
              : ThemeColors.formFieldBackgroundDark,
        ),
        textStyle: WidgetStatePropertyAll(ThemeTypography.body(bodyColor)),
        hintStyle: WidgetStatePropertyAll(
          ThemeTypography.bodyMd.copyWith(color: dimmedColor),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeRadii.r75),
            side: BorderSide(
              color: brightness == Brightness.light
                  ? ThemeColors.formFieldBorderLight
                  : ThemeColors.formFieldBorderDark,
            ),
          ),
        ),
        elevation: const WidgetStatePropertyAll(0),
      ),

      searchViewTheme: SearchViewThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r75),
        ),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.primary,
        unselectedLabelColor: dimmedColor,
        labelStyle: ThemeTypography.bodyMd.copyWith(
          fontWeight: ThemeTypography.medium,
        ),
        unselectedLabelStyle: ThemeTypography.bodyMd,
        indicatorColor: colorScheme.primary,
        dividerColor: colorScheme.outlineVariant,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeRadii.r150),
        ),
      ),

      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.primary;
            }

            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return colorScheme.onPrimary;
            }

            return bodyColor;
          }),
          side: WidgetStatePropertyAll(
            BorderSide(color: colorScheme.outlineVariant),
          ),
          textStyle: WidgetStatePropertyAll(
            ThemeTypography.bodySm.copyWith(fontWeight: ThemeTypography.medium),
          ),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: ThemeSpacing.medium,
              vertical: ThemeSpacing.small,
            ),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeRadii.r75),
            ),
          ),
        ),
      ),

      splashFactory: NoSplash.splashFactory,
      visualDensity: VisualDensity.standard,
    );
  }
}
