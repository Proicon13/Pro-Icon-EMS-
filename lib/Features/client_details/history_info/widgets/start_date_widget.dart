import 'package:flutter/material.dart';

import '../../../../Core/theme/app_text_styles.dart';

class StartDateWidget extends StatelessWidget {
  const StartDateWidget({super.key});
  // TODO: using row would be better for more control on spaces and sizes use the refactored widget (ClientHistoryInfoColumn)
  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          Text(
            "Start date",
            style:
                AppTextStyles.fontSize16(context).copyWith(color: Colors.white),
          ),
          Text("End date",
              style: AppTextStyles.fontSize16(context)
                  .copyWith(color: Colors.white)),
        ]),
        TableRow(children: [
          Text("1-2-2025",
              style: AppTextStyles.fontSize16(context)
                  .copyWith(color: Colors.grey)),
          Text("1-2-2025",
              style: AppTextStyles.fontSize16(context)
                  .copyWith(color: Colors.grey)),
        ])
      ],
    );
  }
}
