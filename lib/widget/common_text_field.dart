import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    widget.setFunction!(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(updateValue);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.black,
      // maxLines: widget.visibility ? 1 : 1,
      controller: _controller,
      readOnly: widget.readOnly,
      obscureText: widget.visibility,
      // expands: widget.visibility ? false : true,
      decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: widget.hintText,
          filled: true,
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(10),
          errorMaxLines: 1,
          errorStyle: TextStyle(fontSize: 10),
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
              borderSide: BorderSide.none),
          labelStyle: const TextStyle(color: Colors.black)),
      validator: (value) {
        return widget.validateFunction(value);
      },
    );
  }
}
