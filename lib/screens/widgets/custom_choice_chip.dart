import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/cubits/home_categorys/home_categorys_cubit.dart';
import 'package:sizer/sizer.dart';

class CustomChoiceChip extends StatefulWidget {
  const CustomChoiceChip({
    super.key,
  });

  @override
  State<CustomChoiceChip> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomChoiceChip> {
  List<bool> isSel = List.generate(6, (index) {
    return index == 0 ? true : false;
  });

  List<String> lables = [
    "Business",
    "Health",
    "Science",
    "Entertainment",
    "Sports",
    "Technology"
  ];
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
                  lables[index],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                // color of selected chip
                selectedColor: kPrimaryColor,
                // backgroundColor: Colors.blue,
                // selected chip value
                selected: isSel[index],
                // onselected method
                onSelected: (bool selected) {
                  setState(() {
                    isSel.fillRange(0, 6, false);
                    isSel[index] = selected;
                    BlocProvider.of<HomeCategorysCubit>(context)
                        .categoryChanged(lables[index].toLowerCase());
                  });
                },
              ),
            );
          })),
    );
  }
}
