import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_theme.dart';

class LoginTextFormField extends StatefulWidget {
  final bool withError;
  final bool isPassword;
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const LoginTextFormField(
      {Key? key,
      required this.withError,
      required this.onChanged,
      required this.isPassword,
      required this.controller,
      required this.label})
      : super(key: key);

  @override
  _LoginTextFormFieldState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  final double paddingTB = 16;
  bool paswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final textColor =
        widget.withError ? LoginTheme.textColorError : LoginTheme.textColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: paddingTB + 4, top: 8),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(fontSize: 18, color: textColor),
            ),
          ),
        ),
        Container(
          height: 48 + paddingTB + paddingTB,
          padding: EdgeInsets.fromLTRB(paddingTB, 4, paddingTB, 8),
          child: CupertinoTextField(
            controller: widget.controller,
            obscureText: widget.isPassword && !paswordVisible,
            placeholderStyle: GoogleFonts.rubik(
                textStyle: TextStyle(
              color: LoginTheme.textColor,
              fontSize: LoginTheme.textSize,
            )),
            onChanged: widget.onChanged,
            suffix: _buildSufix(),
            decoration: BoxDecoration(
              border: widget.withError ? Border.all(color: LoginTheme.iconColorError) : null,
              borderRadius: BorderRadius.circular(4.0),
              color: LoginTheme.bgTextColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSufix() {
    if (widget.withError) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(0, 14, 16, 14),
          child: Icon(
            Icons.error_outline,
            size: LoginTheme.iconSize,
            color: LoginTheme.iconColorError,
          ));
    }

    if (widget.isPassword) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 14, 16, 14),
        child: GestureDetector(
          onTap: () => setState(() {
            paswordVisible = !paswordVisible;
          }),
          child: Icon(
            paswordVisible ? Icons.visibility_off : Icons.visibility,
            size: LoginTheme.iconSize,
            color: LoginTheme.iconColor,
          ),
        ),
      );
    }

    return null;
  }
}
