import 'package:flutter/material.dart';

enum InputType { email, password, number, text }

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    required this.label,
    required this.controller,
    required this.needlabel,
    super.key,
    this.inputType = InputType.text,
    this.hintText,
    this.suffixIconPath,
    this.showPrefixOnFocus = false,
    this.matchController,
  });

  final String label;
  final TextEditingController controller;
  final InputType inputType;
  final String? hintText;
  final bool needlabel;

  /// path to your asset image
  final String? suffixIconPath;

  /// whether to show the prefix when the field is focused
  final bool showPrefixOnFocus;

  /// for confirm-password matching
  final TextEditingController? matchController;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    switch (widget.inputType) {
      case InputType.email:
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
      case InputType.number:
        if (double.tryParse(value) == null) return 'Enter a valid number';
      case InputType.password:
        if (value.length < 6) return 'Password too short';
      // ignore: no_default_cases
      default:
        break;
    }
    if (widget.matchController != null &&
        value != widget.matchController!.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.needlabel)
          Text(
            widget.label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        const SizedBox(height: 8),
        TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          keyboardType: widget.inputType == InputType.number
              ? TextInputType.number
              : TextInputType.text,
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: widget.inputType == InputType.password
              ? _obscureText
              : false,
          validator: _validate,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
           prefixIcon: widget.suffixIconPath != null
      ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Image.asset(
            widget.suffixIconPath!,
            width: 34,
            fit: BoxFit.contain,
            height: 26,
          ),
        )
      : null,
           prefixIconConstraints: const BoxConstraints(
      minWidth: 48,
      minHeight: 48,
    ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 1.5),
            ),
            suffixIcon: widget.inputType == InputType.password
                ? IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        setState(() => _obscureText = !_obscureText),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
