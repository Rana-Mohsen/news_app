import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({
    super.key,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomChoiceChip> {
  List<bool> isSel = List.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 10.h,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ChoiceChip(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                showCheckmark: false,
                elevation: 1,
                shadowColor: Colors.grey.withOpacity(0.5),
                padding: const EdgeInsets.all(8),
                label: Text(
                  'button$index',
                  style: const TextStyle(fontSize: 17),
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                // color of selected chip
                selectedColor: Colors.red,
                backgroundColor: Colors.blue,
                // selected chip value
                selected: isSel[index],
                // onselected method
                onSelected: (bool selected) {
                  setState(() {
                    isSel.fillRange(0, 5, false);
                    isSel[index] = selected;
                  });
                },
              ),
            );
          })),
    );
  }
}
