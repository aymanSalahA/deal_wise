import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 
class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool isFirst;
  final bool isLast;

  const OtpInputField({
    super.key, 
    required this.controller, 
    required this.isFirst, 
    required this.isLast
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        controller: controller, 
        autofocus: isFirst, 
        onChanged: (value) {
          if (value.length == 1 && !isLast) {
            FocusScope.of(context).nextFocus(); 
          }
          if (value.isEmpty && !isFirst) {
            FocusScope.of(context).previousFocus(); 
          }
        },
        showCursor: false,
        readOnly: false,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }
}
