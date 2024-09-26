import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField(
      {super.key,
      required this.hintText,
      this.value = "",
      this.size = 44,
      this.setFunction,
      required this.validateFunction,
      this.visibility = false,
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
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.value.isNotEmpty ? _controller.text = widget.value : null;
    _controller.addListener(updateValue);
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
    return ConstrainedBox(
      constraints:
          const BoxConstraints(maxHeight: 80), // Limits height of TextFormField
      child: TextFormField(
        cursorColor: Colors.black,
        controller: _controller,
        readOnly: widget.readOnly,
        obscureText: widget.visibility,
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
  }
}
