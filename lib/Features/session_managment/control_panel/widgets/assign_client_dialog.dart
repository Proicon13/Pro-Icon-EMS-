import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_icon/Core/theme/app_colors.dart';
import 'package:pro_icon/Core/theme/app_text_styles.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Core/utils/responsive_helper/size_constants.dart';
import 'package:pro_icon/Core/widgets/custom_circular_image.dart';
import 'package:pro_icon/Core/widgets/custom_loader.dart';
import 'package:pro_icon/Core/widgets/keyboard_dismissable.dart';

import '../../../../Core/cubits/client_managment/client_managment_cubit.dart';
import '../../../../Core/dependencies.dart';
import '../../../../Core/entities/user_entity.dart';
import '../../../../Core/utils/responsive_helper/size_config.dart';
import '../../../../Core/widgets/custom_text_field.dart';

class AssignClientDialog extends StatelessWidget {
  final void Function(UserEntity) onClientSelect;
  const AssignClientDialog({super.key, required this.onClientSelect});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ClientManagementCubit>()..getClients(),
      child: Builder(builder: (context) {
        return KeyboardDismissable(
          onDismiss: () {
            FocusManager.instance.primaryFocus?.unfocus();
            context.read<ClientManagementCubit>().toggleSearch(false);
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  context.setMinSize(16)), // Dynamic border radius
            ),
            backgroundColor: AppColors.backgroundColor,
            child: SizedBox(
              height: context.sizeConfig.height * 0.7,
              child: Padding(
                padding:
                    SizeConstants.kScaffoldPadding(context), // Dynamic padding
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Dialog Title
                    context.setMinSize(30).verticalSpace,
                    Text(
                      "Assign Client",
                      style: AppTextStyles.fontSize20(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    context
                        .setMinSize(16)
                        .verticalSpace, // Dynamic vertical spacing

                    // Search Bar & Add Button
                    AssignClientSearchSection(
                      onSearch: (query) => context
                          .read<ClientManagementCubit>()
                          .handleSearch(query),
                      onAddPressed: () {
                        // Handle add client action
                      },
                    ),

                    context
                        .setMinSize(16)
                        .verticalSpace, // Dynamic vertical spacing

                    // Expanded Client List with "Load More" stacked at the bottom
                    Expanded(
                      child: BlocBuilder<ClientManagementCubit,
                          ClientManagementState>(
                        buildWhen: (previous, current) =>
                            previous.clients != current.clients ||
                            previous.searchList != current.searchList ||
                            previous.isSearching != current.isSearching ||
                            previous.isPaginationLoading !=
                                current.isPaginationLoading,
                        builder: (context, state) {
                          final clientList = state.isSearching
                              ? state.searchList
                              : state.clients;

                          if (state.requestStatus == RequestStatus.loading &&
                              clientList.isEmpty) {
                            return const CustomLoader();
                          }

                          if (clientList.isEmpty) {
                            return Center(
                              child: Text(
                                "No clients found",
                                style: AppTextStyles.fontSize16(context)
                                    .copyWith(color: Colors.white),
                              ),
                            );
                          }

                          return Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              // Client List
                              ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: AppColors.white71Color,
                                  thickness: 1,
                                  height: context.setMinSize(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: context
                                        .setMinSize(8)), // Dynamic padding
                                itemCount: clientList.length,
                                itemBuilder: (context, index) {
                                  final client = clientList[index];
                                  return SizeConfig(
                                    baseSize: const Size(398, 50),
                                    width: context.setMinSize(398),
                                    height: context.setMinSize(50),
                                    child: Builder(builder: (context) {
                                      return SizedBox(
                                        child: ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          leading: CustomCircularImage(
                                              width: context.setMinSize(50),
                                              height: context.setMinSize(50),
                                              imageUrl: client.image!),
                                          title: Text(
                                            client.fullname!,
                                            style: AppTextStyles.fontSize18(
                                                    context)
                                                .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                          ),
                                          onTap: () {
                                            // Handle client selection
                                            onClientSelect(client);
                                          },
                                        ),
                                      );
                                    }),
                                  );
                                },
                              ),

                              // Load More Button (Stacked at the Bottom)
                              if (state.canFetchMore)
                                Positioned(
                                  bottom: context.setMinSize(50),
                                  child: state.isPaginationLoading
                                      ? const CustomLoader() // Show Loader if paginating
                                      : TextButton(
                                          onPressed: () => context
                                              .read<ClientManagementCubit>()
                                              .getClients(),
                                          child: Text(
                                            "Load More",
                                            style: AppTextStyles.fontSize16(
                                                    context)
                                                .copyWith(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class AssignClientSearchSection extends StatelessWidget {
  final void Function(String) onSearch;
  final void Function() onAddPressed;

  const AssignClientSearchSection({
    super.key,
    required this.onSearch,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    final double searchBarHeight =
        context.setMinSize(50); // Height for search bar
    final double iconSize = context.setMinSize(24);

    return Row(
      children: [
        // Search Bar
        Expanded(
          child: SizedBox(
            height: searchBarHeight,
            child: CustomTextField(
              name: 'searchBar',
              hintText: "userManagment.screen.searchHint".tr(),
              onChanged: (value) => onSearch(value ?? ''),
              keyboardInputType: TextInputType.emailAddress,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: context.setMinSize(5)),
                child: Icon(
                  Icons.search,
                  color: AppColors.white71Color,
                  size: iconSize,
                ),
              ),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: (searchBarHeight - iconSize) / 2, // Center vertically
              ),
            ),
          ),
        ),

        context.setMinSize(10).horizontalSpace,

        // Add Button
        InkWell(
          onTap: onAddPressed,
          child: Container(
            height: searchBarHeight,
            width: context.setMinSize(60),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: SizeConstants.kDefaultBorderRadius(context),
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: iconSize,
            ),
          ),
        ),
      ],
    );
  }
}
