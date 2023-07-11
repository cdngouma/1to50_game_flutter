import 'package:flutter/material.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({
    super.key, required this.id, required this.value, required this.onCellTapped
  });
  final int id;
  final int value;
  final Function onCellTapped;

  Color selectColor(int value) {
    // Change cell color based on its value
    if(value == 0) {
      return Colors.black54;
    } else if (value > 25) {
      return Colors.amber;
    }
    return Colors.amber[300] ?? Colors.amberAccent;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onCellTapped(id),
      style: TextButton.styleFrom(
          backgroundColor: selectColor(value),
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.center,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero)
          )
      ),

      child: Text(
          "${value == 0 ? '' : value}",
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          )
      ),
    );
  }
}
