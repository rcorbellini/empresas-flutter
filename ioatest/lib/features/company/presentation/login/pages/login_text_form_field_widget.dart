import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ioatest/features/company/presentation/login/pages/login_theme.dart';
import 'package:ioatest/main.dart';

///Component styled of login form
class LoginTextFormField extends StatefulWidget {
  ///The constructor
  ///use [withError] to set component status error.
  ///use [isPassword] to set as obscured text.
  ///use [onChanged] to set callback of text change.
  ///use [label] to set a text label of field.
  ///use [controller] to set the controller of preamble.
  const LoginTextFormField(
      {Key? key,
      this.withError = false,
      required this.onChanged,
      this.isPassword = false,
      required this.controller,
      required this.label})
      : super(key: key);

  ///to set component status error.
  final bool withError;

  ///to set as obscured text.
  final bool isPassword;

  ///to set a text label of field.
  final String label;

  ///to set callback of text change.
  final ValueChanged<String> onChanged;

  ///to set the controller of preamble.
  final TextEditingController controller;

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
                padding: const EdgeInsets.all(14),
                child: CupertinoTextField(
                  controller: widget.controller,
                  style: GoogleFonts.rubik(
                      textStyle: const TextStyle(
                    fontSize: LoginTheme.textSize,
                  )),
                  obscureText: widget.isPassword && !paswordVisible,
                  onChanged: widget.onChanged,
                  suffix: _buildSufix(),
                  cursorColor: MainTheme.mainColor,
                  decoration: const BoxDecoration(
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
      return const Icon(
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
