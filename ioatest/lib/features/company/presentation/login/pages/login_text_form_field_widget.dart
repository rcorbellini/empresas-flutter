import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_theme.dart';
import 'package:ioatest/main.dart';

class LoginTextFormField extends StatefulWidget {
  final bool withError;
  final bool isPassword;
  final String label;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const LoginTextFormField(
      {Key? key,
      this.withError = false,
      required this.onChanged,
      this.isPassword = false,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: paddingTB + 4, top: 8),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.rubik(
              textStyle: TextStyle(fontSize: 18, color: _buildTextColor()),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(paddingTB, 4, paddingTB, 8),
          child: Container(
            height: 48 + paddingTB + paddingTB,
            decoration: BoxDecoration(
              border: _buildBorder(),
              borderRadius: BorderRadius.circular(4.0),
              color: LoginTheme.bgTextColor,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: CupertinoTextField(
                  controller: widget.controller,
                  style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                    fontSize: LoginTheme.textSize,
                  )),
                  obscureText: widget.isPassword && !paswordVisible,
                  onChanged: widget.onChanged,
                  suffix: _buildSufix(),
                  cursorColor: MainTheme.pink,
                  decoration: BoxDecoration(
                    color: LoginTheme.bgTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _buildTextColor() {
    return widget.withError ? LoginTheme.textColorError : LoginTheme.textColor;
  }

  Border? _buildBorder() {
    return widget.withError
        ? Border.all(color: LoginTheme.iconColorError)
        : null;
  }

  Widget? _buildSufix() {
    if (widget.withError) {
      return Icon(
        Icons.error_outline,
        size: LoginTheme.iconSize,
        color: LoginTheme.iconColorError,
      );
    }

    if (widget.isPassword) {
      return GestureDetector(
        onTap: () => setState(() {
          paswordVisible = !paswordVisible;
        }),
        child: Icon(
          paswordVisible ? Icons.visibility_off : Icons.visibility,
          size: LoginTheme.iconSize,
          color: LoginTheme.iconColor,
        ),
      );
    }

    return null;
  }
}
