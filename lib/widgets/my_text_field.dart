import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? errorText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;
  
  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFDFA),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: errorText != null ? Colors.red : Colors.transparent,
              width: errorText != null ? 1.5 : 0,
            ),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 1)],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLength: maxLength,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'Actay',
                color: Colors.grey,
              ),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              counterText: '',
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
              errorText!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

