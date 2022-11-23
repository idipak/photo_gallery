import 'package:flutter/material.dart';

class SelectionButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() onTap;
  const SelectionButton({Key? key, required this.label, this.isSelected = false, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 80,
        height: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(label,
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
            ),

            if(isSelected)
              Container(
                width: 60,
                height: 2,
                decoration: const BoxDecoration(
                    color: Colors.green
                ),
              )
          ],
        ),
      ),
    );
  }
}

