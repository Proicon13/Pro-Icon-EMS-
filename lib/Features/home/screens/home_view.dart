import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_icon/Core/dependencies.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/widgets/app_bar_widget.dart';
import 'package:pro_icon/Core/widgets/pro_icon_logo.dart';
import 'package:pro_icon/Features/CategoryDetails/Screens/Category_details.dart';
import 'package:pro_icon/Features/home/cubit/home_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => getIt<HomeCubit>()..getCategories(),
      child: DecoratedBox(
        decoration: const BoxDecoration(color: AppColors.backgroundColor),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Center(child: ProIconLogo()),
            const SizedBox(
              height: 30,
            ),
            const AppBarWidget(text: "Welcome!", username: "Admin"),
            const Divider(
              thickness: 2,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Choose a category to start with",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, state) {
                  if (state is CategoryError) {
                    return Text("${state.errorMessage}");
                  }
                  if (state is CategoryLoaded) {
                    return GridView.builder(
                      itemCount: state.categories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        final currentCategory = state.categories[index];
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CategoryDetails(),
                                  ),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      "${currentCategory.image}",
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "${currentCategory.name}",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
