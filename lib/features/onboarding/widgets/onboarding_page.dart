import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../models/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // Decorative background blobs and waves
        Positioned.fill(
          child: CustomPaint(
            painter: _BlobsPainter(
              baseColor: model.backgroundColor,
              accentColor: model.accentColor,
            ),
          ),
        ),

        // Content
        SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.06,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: size.width * 0.8,
                        maxHeight: size.height * 0.3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: model.accentColor.withOpacity(0.18),
                            blurRadius: 30,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(model.imagePath, fit: BoxFit.cover),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.15),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      model.title,
                      style: TextStyle(
                        fontSize: size.width * 0.07,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: size.height * 0.015),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04,
                      ),
                      child: Text(
                        model.description,
                        style: TextStyle(
                          fontSize: math.min(
                            16,
                            math.max(14, size.width * 0.04),
                          ),
                          height: 1.5,
                          color: Colors.black.withOpacity(0.70),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _FeatureChip(label: 'Secure', color: model.accentColor),
                        _FeatureChip(
                          label: 'Fast',
                          color: model.accentColor.withOpacity(0.8),
                        ),
                        _FeatureChip(
                          label: 'Rewards',
                          color: model.accentColor.withOpacity(0.7),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final String label;
  final Color color;

  const _FeatureChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlobsPainter extends CustomPainter {
  final Color baseColor;
  final Color accentColor;

  _BlobsPainter({required this.baseColor, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint basePaint = Paint()..color = baseColor;

    // Background fill
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), basePaint);

    // Calculate responsive sizes based on the smaller dimension
    final smallerDimension = size.width < size.height
        ? size.width
        : size.height;
    final blobSize = smallerDimension * 0.3;

    // Accent blob top-right
    final Paint accentPaint = Paint()..color = accentColor.withOpacity(0.10);
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.15),
      blobSize,
      accentPaint,
    );

    // Accent blob bottom-left
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.85),
      blobSize * 1.2,
      accentPaint..color = accentColor.withOpacity(0.08),
    );

    // Soft wave at bottom
    final Path wave = Path()
      ..moveTo(0, size.height * 0.85)
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.80,
        size.width * 0.5,
        size.height * 0.85,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.90,
        size.width,
        size.height * 0.85,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final Paint wavePaint = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawPath(wave, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
