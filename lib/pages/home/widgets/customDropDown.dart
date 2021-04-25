import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown(
      {Key? key,
      required this.label,
      this.controller,
      required this.items,
      this.onSaved})
      : super(key: key);
  final label;
  final controller;
  final List<String> items;
  final Function(String?)? onSaved;
  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String _dropDownvalue = widget.items.first;
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 20,
                color: CustomColors.blanco,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: CustomColors.azul.dark,
              border: Border.all(
                color: CustomColors.blanco,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButtonFormField(
              dropdownColor: CustomColors.azul,
              onSaved: (_) {
                widget.onSaved!(_dropDownvalue);
              },
              value: _dropDownvalue,
              onChanged: (String? newValue) {
                setState(() {
                  _dropDownvalue = newValue!;
                });
              },
              icon: Icon(
                Icons.arrow_drop_down,
                color: CustomColors.blanco,
              ),
              iconSize: 25,
              style: TextStyle(color: CustomColors.blanco, fontSize: 18),
              items: [
                for (String item in widget.items)
                  DropdownMenuItem(
                    value: item,
                    child: Text('$item'),
                  )
              ],
              decoration: InputDecoration(
                fillColor: CustomColors.azul.dark,
                contentPadding: EdgeInsets.all(10.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
