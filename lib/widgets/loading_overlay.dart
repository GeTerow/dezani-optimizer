import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    required this.text,
    this.tintColor = AppColors.primary,
    super.key,
  });

  final String text;
  final Color tintColor;

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1, end: 1.06).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _opacity = Tween<double>(begin: 0.6, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withAlpha(140)),
              ),
            ),
            Center(
              child: Container(
                width: 260,
                constraints: const BoxConstraints(minHeight: 180),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.overlay.withAlpha(184),
                  borderRadius: BorderRadius.circular(AppRadii.overlay),
                  boxShadow: AppShadows.overlay,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _opacity.value,
                          child: Transform.scale(
                            scale: _scale.value,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: widget.tintColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: widget.tintColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 22),
                        Text(
                          widget.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.overlayText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
