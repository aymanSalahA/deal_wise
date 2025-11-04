import 'package:flutter/material.dart';

class ColorOptions extends StatelessWidget {
  final List<String> availableColors;
  final String selectedColorCode;
  const ColorOptions({
    super.key,
    required this.availableColors,
    required this.selectedColorCode,
  });

  Color _colorFromHex(String hexCode) {
    return Color(int.parse(hexCode.replaceAll('0x', ''), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Color',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: availableColors.map((hexCode) {
              final color = _colorFromHex(hexCode);
              final isSelected = hexCode == selectedColorCode;
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 18, color: Colors.black)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
