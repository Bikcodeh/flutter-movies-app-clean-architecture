import 'package:flutter/material.dart';

import '../../../../../domain/enums.dart';

class TrendingTitleAndFilter extends StatelessWidget {
  const TrendingTitleAndFilter({
    super.key,
    required this.timeWindow,
    required this.onTimeWindowChange,
  });
  final TimeWindow timeWindow;
  final void Function(TimeWindow) onTimeWindowChange;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text(
        'TRENDING',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const Spacer(),
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.grey.shade200,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: DropdownButton<TimeWindow>(
              isDense: true,
              underline: const SizedBox(),
              value: timeWindow,
              items: const [
                DropdownMenuItem(
                    value: TimeWindow.day, child: Text('Last 24h')),
                DropdownMenuItem(
                    value: TimeWindow.week, child: Text('Last week')),
              ],
              onChanged: ((newTimeWindow) {
                if (newTimeWindow != null && timeWindow != newTimeWindow) {
                  onTimeWindowChange(newTimeWindow);
                }
              }),
            ),
          ),
        ),
      )
    ]);
  }
}
