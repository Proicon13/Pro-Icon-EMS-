import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_config.dart';
import 'package:pro_icon/Core/widgets/base_app_scaffold.dart';
import 'package:pro_icon/Features/main/cubit/cubit/main_cubit.dart';
import 'package:pro_icon/Features/main/widgets/main_bottom_nav_bar.dart';

import 'widgets/start_icon.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main-screen';
  const MainScreen({super.key, this.selectedSection = MainSections.programs});
  final MainSections? selectedSection;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  late int intialPage;

  @override
  void initState() {
    if (widget.selectedSection == null) {
      intialPage = 0;
    } else {
      intialPage = MainSections.values.indexOf(widget.selectedSection!);
    }
    _pageController = PageController(initialPage: intialPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => getIt<MainCubit>()
          ..onInit(widget.selectedSection ?? MainSections.programs),
        child: BaseAppScaffold(
          body: PageView.builder(
              itemCount: MainSections.values.length,
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, index) {
                return MainSections.values[index].view;
              }),
          floatingActionButton: const StartIcon(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory),
            child: SizeConfig(
              baseSize: const Size(430, 100),
              height: context.setMinSize(100),
              width: context.screenWidth,
              child: Builder(builder: (context) {
                return MainBottomNavBar(pageController: _pageController);
              }),
            ),
          ),
        ));
  }
}
