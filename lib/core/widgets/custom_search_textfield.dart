import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:optomatica_task/core/utils/colors/app_colors.dart';
import 'package:optomatica_task/core/utils/text_styles/app_text_styles.dart';
import 'package:optomatica_task/view%20model/races_cubit/races_cubit.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({super.key, required this.title});
  final String title;
  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  late final TextEditingController controller;
  bool isFocused = false;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onSubmitted: (value) {
        print(value);
        setState(() {
          isFocused = false;
        });
        BlocProvider.of<RacesCubit>(context).searchItems(value);
      },
      onChanged: (value) {
        BlocProvider.of<RacesCubit>(context).searchItems(value);
      },
      onTapOutside: (event) {
        setState(() {
          isFocused = false;
        });
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                print(controller.text);
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {
                  isFocused = false;
                });
              },
              icon: SvgPicture.asset(
                'assets/images/searchIcon.svg',
                colorFilter: ColorFilter.mode(
                    isFocused
                        ? AppColors.secondaryColor
                        : const Color(0xff1C325F),
                    BlendMode.srcIn),
              )),
          hintText: widget.title,
          hintStyle: AppTextStyles.style16w400,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffCDD3E4), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.secondaryColor, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xffCDD3E4), width: 2))),
    );
  }
}
