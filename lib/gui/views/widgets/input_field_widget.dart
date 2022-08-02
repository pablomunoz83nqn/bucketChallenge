import 'package:flutter/material.dart';

class InputFieldWidget extends StatefulWidget {
  final String? label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focus;
  final EdgeInsetsGeometry? margin;
  final IconButton? suffixIcon;
  final bool obscure;
  final bool enableInteractiveSelection;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixTitle;

  const InputFieldWidget({
    Key? key,
    this.label,
    this.suffixTitle,
    this.onChanged,
    this.validator,
    this.onTap,
    this.keyboardType,
    this.controller,
    this.focus,
    this.margin,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.obscure = false,
    this.enableInteractiveSelection = true,
  }) : super(key: key);

  @override
  State<InputFieldWidget> createState() => _InputFieldWidgetState();
}

class _InputFieldWidgetState extends State<InputFieldWidget> {
  bool _isObscure = false;

  @override
  initState() {
    super.initState();
    _isObscure = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: SizedBox(
          width: MediaQuery.maybeOf(context)!.size.width / 3,
          child: _inputTextForm()),
    );
  }

  TextFormField _inputTextForm() => TextFormField(
        enabled: widget.enabled,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        keyboardType: widget.keyboardType,
        obscureText: _isObscure,
        controller: widget.controller,
        focusNode: widget.focus,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
      );
}
