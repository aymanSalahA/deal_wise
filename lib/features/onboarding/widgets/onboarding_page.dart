import 'package:flutter/material.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const Spacer(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.85,
                    maxHeight: size.height * 0.42,
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
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  model.description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                    color: Colors.black.withOpacity(0.70),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _FeatureChip(label: 'Secure', color: model.accentColor),
                    _FeatureChip(label: 'Fast', color: model.accentColor.withOpacity(0.8)),
                    _FeatureChip(label: 'Rewards', color: model.accentColor.withOpacity(0.7)),
                  ],
                ),
                const Spacer(),
              ],
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
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
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

    // Accent blob top-right
    final Paint accentPaint = Paint()..color = accentColor.withOpacity(0.10);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.18), size.width * 0.35, accentPaint);

    // Accent blob bottom-left
    canvas.drawCircle(Offset(size.width * 0.15, size.height * 0.85), size.width * 0.40, accentPaint..color = accentColor.withOpacity(0.08));

    // Soft wave at bottom
    final Path wave = Path()
      ..moveTo(0, size.height * 0.78)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.72, size.width * 0.5, size.height * 0.80)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.88, size.width, size.height * 0.82)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final Paint wavePaint = Paint()..color = Colors.white.withOpacity(0.9);
    canvas.drawPath(wave, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
