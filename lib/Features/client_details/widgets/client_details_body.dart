import 'package:flutter/material.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/client_details/cubit/cubit/client_details_cubit.dart';

import '../../../Core/utils/responsive_helper/size_constants.dart';
import 'client_details_section.dart';
import 'sections_list.dart';

class ClientDetailsBody extends StatefulWidget {
  const ClientDetailsBody({
    super.key,
  });

  @override
  State<ClientDetailsBody> createState() => _ClientDetailsBodyState();
}

class _ClientDetailsBodyState extends State<ClientDetailsBody> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        context.setMinSize(50).verticalSpace,
        const ClientDetailsSection(),
        context.setMinSize(30).verticalSpace,
        SectionsList(
          pageController: _pageController,
        ),
        Expanded(
          child: Padding(
            padding: SizeConstants.kScaffoldPadding(context),
            child: PageView.builder(
              itemCount: ClientSections.values.length,
              controller: _pageController,
              itemBuilder: (context, index) =>
                  clientSectionsToViewsMap[ClientSections.values[index]]!,
            ),
          ),
        ),
      ],
    );
  }
}
