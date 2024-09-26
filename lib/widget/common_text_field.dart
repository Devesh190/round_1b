import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../feature/login_signup/provider/auth_provider.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField(
      {super.key,
      required this.hintText,
      this.value = "",
      this.size = 44,
      this.setFunction,
      required this.validateFunction,
      this.visibility = false, // True if it is a password field
      this.textFieldColor = Colors.white,
      this.readOnly = false});
  final String hintText;
  final String value;
  final double size;
  final Function(String)? setFunction;
  final Function(String?) validateFunction;
  final bool visibility;
  final Color textFieldColor;
  final bool readOnly;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  TextEditingController _controller = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _controller.addListener(updateValue);
    if (!widget.visibility) {
      _obscureText = false;
    }
  }

  void updateValue() {
    if (widget.setFunction != null) {
      widget.setFunction!(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(updateValue);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 80),
        child: TextFormField(
          cursorColor: Colors.black,
          controller: _controller,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          decoration: InputDecoration(
            fillColor: Colors.white,
            hintText: widget.hintText,
            filled: true,
            isCollapsed: true,
            contentPadding: const EdgeInsets.all(10),
            errorMaxLines: 1,
            errorStyle: const TextStyle(
              fontSize: 10,
              height: 0.8,
            ),
            suffixIcon: widget.visibility
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null, // Only show the icon for password fields
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            labelStyle: const TextStyle(color: Colors.black),
          ),
          validator: (value) {
            return widget.validateFunction(value);
          },
        ),
      );
    });
  }
}
