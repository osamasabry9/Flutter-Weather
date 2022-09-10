import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../card_widget.dart';

class TodayCard extends StatelessWidget {
  const TodayCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? bodyMediumTextStyle =
        AppColors.collapsedMediumTextStyle(context, false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CardWidget(
        isLight: false,
        isCollapsed: false,
        widget: Column(
          children: [
            Text('Today\'s Temperature', style: bodyMediumTextStyle),
            const SizedBox(height: 5),
            Text('Expect the same as yesterday',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
