import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:arculus/extensions/l10n_extension.dart';
import 'package:arculus/providers/theme_provider.dart';
import 'package:arculus/services/otp_service.dart';
import 'package:arculus/utils/app_constants.dart';
import 'package:arculus/utils/app_database.dart';
import 'package:arculus/utils/app_theme.dart';

class TokenCard extends StatefulWidget {
  final Account account;
  final bool isSelected;
  final VoidCallback onSelect;

  const TokenCard({
    super.key,
    required this.account,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  State<TokenCard> createState() => _TokenCardState();
}

class _TokenCardState extends State<TokenCard> with TickerProviderStateMixin {
  Timer? _timer;
  String _code = '';
  int _secondsLeft = 30;
  bool _codeCopied = false;

  late final AnimationController _blinkController;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: 1.0,
    );
    _colorAnimation = Tween<Color?>(begin: Colors.transparent, end: null)
        .animate(
          CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
        );

    _refresh();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blinkController.dispose();
    super.dispose();
  }

  void _refresh() {
    if (widget.account.tokenType == TokenType.totp.label) {
      _code = OtpService.generateTotp(widget.account);
      _secondsLeft = OtpService.secondsRemaining(widget.account.interval);

      _handleBlinkAnimation();
    } else {
      _code = OtpService.generateHotp(widget.account);
    }
  }

  void _handleBlinkAnimation() {
    if (_isVeryLow) {
      if (!_blinkController.isAnimating) {
        _blinkController.repeat(reverse: true);
      }
    } else {
      _blinkController.stop();
      _blinkController.value = 1.0;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _refresh();
      });
    });
  }

  bool get _isLow => _secondsLeft <= 10;
  bool get _isVeryLow => _secondsLeft <= 5;

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _code));

    setState(() => _codeCopied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _codeCopied = false);
    });

    final l10n = context.l10n;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.homeScreen_tokenCopiedSnackbar_content),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = context.watch<ThemeProvider>();
    final l10n = context.l10n;
    final midCode = (_code.length / 2).ceil();

    return Padding(
      padding: const EdgeInsets.only(bottom: ThemeSpacing.halfMedium),
      child: Card(
        color: widget.isSelected
            ? colorScheme.primaryContainer
            : colorScheme.surface,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _copyCode,
          onLongPress: () => widget.onSelect(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeSpacing.medium,
              vertical: ThemeSpacing.halfMedium,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      final currentColor = _isLow
                          ? colorScheme.error
                          : colorScheme.onSurface;

                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          CircularProgressIndicator(
                            value: _secondsLeft / widget.account.interval,
                            strokeWidth: 3,
                            backgroundColor: currentColor.withValues(
                              alpha: 0.2,
                            ),
                            valueColor: AlwaysStoppedAnimation(currentColor),
                          ),
                          Center(
                            child: Text(
                              (widget.account.issuer ?? widget.account.name)
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: textTheme.headlineLarge?.copyWith(
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: ThemeSpacing.medium),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.account.issuer ?? widget.account.name,
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (widget.account.issuer != null) ...[
                            const SizedBox(width: 10),
                            Text(
                              '(${widget.account.name})',
                              style: textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                          const Spacer(),
                          IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap
                            ),
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              _codeCopied
                                  ? Icons.check_rounded
                                  : Icons.copy_rounded,
                              size: 18,
                              color: _codeCopied
                                  ? (themeProvider.themeMode == ThemeMode.light
                                        ? ThemeColors.successLight
                                        : ThemeColors.successDark)
                                  : colorScheme.onSurface,
                            ),
                            tooltip: l10n.homeScreen_tokenCard_copyButton_tooltip,
                            onPressed: _copyCode,
                          ),
                        ],
                      ),
                      AnimatedBuilder(
                        animation: _colorAnimation,
                        builder: (context, child) {
                          final baseColor = _isLow
                              ? colorScheme.error
                              : colorScheme.onSurface;
                          final dimmedColor = baseColor.withValues(
                            red: baseColor.r,
                            green: baseColor.g,
                            blue: baseColor.b,
                            alpha: 0.2,
                          );
                          final currentColor =
                              Color.lerp(
                                dimmedColor,
                                baseColor,
                                _blinkController.value,
                              ) ??
                              baseColor;

                          return Row(
                            children: [
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style:
                                    (textTheme.displayMedium ??
                                            const TextStyle())
                                        .copyWith(color: currentColor),
                                child: Text(
                                  _code.substring(0, midCode),
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: true,
                                    applyHeightToLastDescent: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: ThemeSpacing.small),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style:
                                    (textTheme.displayMedium ??
                                            const TextStyle())
                                        .copyWith(color: currentColor),
                                child: Text(
                                  _code.substring(midCode),
                                  textHeightBehavior: const TextHeightBehavior(
                                    applyHeightToFirstAscent: true,
                                    applyHeightToLastDescent: true,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
