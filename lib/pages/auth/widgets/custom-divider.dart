import 'package:flutter/material.dart';
import 'package:habits_app/customColors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 1,
              color: CustomColors.blanco,
              width: 100,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              'o',
              style: TextStyle(
                color: CustomColors.blanco,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Container(
              height: 1,
              color: CustomColors.blanco,
              width: 100,
            )
          ],
        ),
      ),
    );
  }
}
