import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  const BuildTextField({
    Key? key,
    required this.valController,
    required this.valLabelText,
    required this.valHintText,
    required this.valIcon,
    required this.isPassword,
  }) : super(key: key);

  final TextEditingController valController;
  final String valLabelText, valHintText;
  final IconData valIcon;
  final bool isPassword;

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.valController,
      obscureText: widget.isPassword ? _isObscured : false,
      style:
          const TextStyle(color: Colors.white), // Set the text color to white
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.white), // Set the default border color
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.white), // Set the enabled border color
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: widget.valLabelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        hintText: widget.valHintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : IconButton(
                onPressed: () {
                  widget.valController.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
        prefixIcon: Icon(
          widget.valIcon,
          color: Colors.white,
        ),
      ),
      onChanged: (value) {},
    );
  }
}
