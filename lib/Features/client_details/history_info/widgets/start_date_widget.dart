import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_date_picker_section.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';

class StartDateWidget extends StatelessWidget {
  const StartDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocSelector<ClientDetailsCubit, ClientDetailsState, String>(
          selector: (state) {
            return state.client!.startDate!;
          },
          builder: (context, state) {
            return Expanded(
              child: DatePickerFormSection(
                  initialValue: DateTime.parse(
                      state), //TODO: here we put client start Date as intial value
                  title: "Start Date",
                  name: "startDate",
                  hintText: "start date"),
            );
          },
        ),
        context.setMinSize(20).horizontalSpace,
        Expanded(
          child: DatePickerFormSection(
              initialValue: DateTime.now()
                ..add(const Duration(
                    days:
                        1)), //TODO: heree we put client end Date as intial value
              title: "End Date",
              name: "endDate",
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
              hintText: "End date"),
        ),
      ],
    );
  }
}
