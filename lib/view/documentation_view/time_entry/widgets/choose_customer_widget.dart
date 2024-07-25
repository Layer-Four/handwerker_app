import 'package:flutter/material.dart';
import '../../../../constants/apptheme/app_colors.dart';

class ChooseCustomer<T> extends StatelessWidget {
  final T? value;
  final String title;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final void Function()? onTap;
  const ChooseCustomer({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.onTap,
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 20, right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColor.kTextfieldBorder),
              ),
              child: DropdownButton<T?>(
                onTap: onTap,
                menuMaxHeight: 350,
                underline: const SizedBox(),
                isExpanded: true,
                value: value,
                items: items,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      );
}
