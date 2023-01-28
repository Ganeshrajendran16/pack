import 'package:awomowa_vendor/app/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalFormField extends StatefulWidget {
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final Function validator;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isAge;
  final bool isMobile;
  final bool isConfirmPass;
  final bool isDateOfBirth;
  final bool isMultiLine;
  final bool isEnabled;
  final isExpiryDate;
  final TextCapitalization textCapitalization;
  GlobalFormField(
      {this.hint,
      this.prefixIcon,
      this.isPassword = false,
      this.validator,
      this.controller,
      this.isAge = false,
      this.isMobile = false,
      this.isConfirmPass = false,
      this.inputType = TextInputType.name,
      this.isDateOfBirth = false,
      this.isMultiLine = false,
      this.isEnabled = true,
      this.textCapitalization = TextCapitalization.sentences,
      this.isExpiryDate = false});

  @override
  _GlobalFormFieldState createState() => _GlobalFormFieldState();
}

class _GlobalFormFieldState extends State<GlobalFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      enabled: widget.isEnabled,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: widget.isMultiLine ? null : 1,
      minLines: widget.isMultiLine ? 4 : null,
      textCapitalization: widget.textCapitalization,
      onTap: () async {
        if (widget.isDateOfBirth || widget.isExpiryDate) {
          DateTime date = DateTime(1900);
          FocusScope.of(context).requestFocus(new FocusNode());

          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: widget.isExpiryDate ? DateTime.now() : DateTime(1900),
              lastDate: widget.isExpiryDate ? DateTime(2100) : DateTime.now());
          final DateFormat formatter = DateFormat('MM/dd/yyyy');
          widget.controller.text = formatter.format(date);
        }
      },
      // style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.da),
      keyboardType: widget.isMobile ? TextInputType.number : widget.inputType,
      maxLength: widget.isAge
          ? 2
          : widget.isMobile
              ? 10
              : null,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          counterText: "",
          labelText: widget.hint,
          fillColor: Colors.grey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: BorderSide(color: Colors.grey)),
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            widget.prefixIcon,
          ),
          prefixText: widget.isMobile ? '+1' : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppTheme.themeColor,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null),
      obscureText: widget.isPassword
          ? !_passwordVisible
          : widget.isConfirmPass
              ? true
              : false,
      validator: widget.validator,
    );
  }
}
