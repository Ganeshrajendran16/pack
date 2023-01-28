import 'package:flutter/material.dart';

class GlobalDropDownButton extends StatefulWidget {
  final IconData prefixIcon;
  final String hint;
  final List<String> items;
  final Function onChanged;
  final Function validator;
  final String selectedValue;

  const GlobalDropDownButton(
      {this.prefixIcon,
      this.hint,
      this.items,
      this.onChanged,
      this.validator,
      this.selectedValue});

  @override
  _GlobalDropDownButtonState createState() => _GlobalDropDownButtonState();
}

class _GlobalDropDownButtonState extends State<GlobalDropDownButton> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.selectedValue != null) {
        print(widget.selectedValue);

        if (widget.items.contains(widget.selectedValue)) {
          widget.onChanged(widget.items.indexOf(widget.selectedValue));
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16.0),
        hintText: widget.hint,
        labelText: widget.hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: Colors.grey)),
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(
          widget.prefixIcon,
        ),
      ),
      isExpanded: true,
      value: widget.selectedValue == null
          ? null
          : (widget.items.contains(widget.selectedValue)
              ? widget.items.indexOf(widget.selectedValue).toString()
              : null),
      items: List.generate(
          widget.items.length,
          (index) => DropdownMenuItem<String>(
                value: index.toString(),
                child: new Text(
                  widget.items[index],
                ),
              )),
      onChanged: (_) => widget.onChanged(int.parse(_)),
    );
  }
}
