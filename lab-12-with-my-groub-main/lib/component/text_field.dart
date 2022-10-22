import 'package:flutter/material.dart';

class Text_Field extends StatelessWidget {
  Text_Field(
      {this.obscure,
      required this.TypeInput,
      required this.prefixIcon,
      this.controller});
  bool? obscure;
  String? TypeInput;
  Icon? prefixIcon;
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        enabled: true,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1)),
          hintText: "Enter Your ${TypeInput} .",
          hintStyle: const TextStyle(color: Colors.black),
          label: Text(
            "${TypeInput}",
            style: const TextStyle(color: Colors.black),
          ),
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        maxLines: 1,
        maxLength: 40,
        cursorColor: Colors.white,
        textAlign: TextAlign.center,
        obscureText: obscure!,
      ),
    );
  }
}
