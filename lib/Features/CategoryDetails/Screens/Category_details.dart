import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/widgets/base_app_Scaffold.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/animated_Container_widget.dart';
import 'package:pro_icon/Features/CategoryDetails/Widget/custom_app_bar.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
        resizeToAvoidBottomInset: true,
        body: Column(

          children: [
            CustomAppBar(icon: Icons.arrow_back_ios, text: "name"),
          const SizedBox(height: 30,),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: AnimatedContainerWidget(),
                ))

          ],
        ),
    );
  }
}
