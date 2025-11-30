import 'package:flutter/material.dart';

class PhotoPicker extends StatelessWidget {
  const PhotoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 8,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            height: 56,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text("Photos", style: TextStyle(color: Colors.white)),
          ),
          Expanded(child: Text("Select Phots")),
        ],
      ),
    );
  }
}
