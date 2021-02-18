import 'package:flutter/material.dart';
import 'package:sapa_desa/theme.dart';
import 'package:sapa_desa/widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidePassword = true;

  void _togglePassword() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: _isHidePassword,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              _togglePassword();
            },
            child: Icon(
              _isHidePassword ? Icons.visibility_off : Icons.visibility,
              color: _isHidePassword ? Colors.grey : Colors.purple,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
