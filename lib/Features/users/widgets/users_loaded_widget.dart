import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pro_icon/Core/entities/user_entity.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/widgets/custom_confirmation_dialog.dart';
import 'package:pro_icon/Core/widgets/empty_state_widget.dart';
import 'package:pro_icon/Features/users/widgets/user_card.dart';

import '../../../Core/widgets/custom_loader.dart';
import '../../manage_trainer/screens/manage_trainer_screen.dart';
import '../cubits/user_managment_cubit.dart';

class UsersListLoadedWidget extends StatefulWidget {
  final UserManagmentCubit cubit;

  const UsersListLoadedWidget({super.key, required this.cubit});

  @override
  State<UsersListLoadedWidget> createState() => _UsersListLoadedWidgetState();
}

class _UsersListLoadedWidgetState extends State<UsersListLoadedWidget> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emptyStateMessage = _getEmptyStateMessage(widget.cubit.state);

    final List<UserEntity> users = widget.cubit.state.isSearching!
        ? widget.cubit.state.searchList!
        : (widget.cubit.state.currentVariation == UserVariations.trainer
            ? widget.cubit.state.trainers!
            : widget.cubit.state.clients!);

    return emptyStateMessage != null
        ? Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: context.sizeConfig.height * 0.55,
                child: Center(
                  child: EmptyStateWidget(message: emptyStateMessage),
                ),
              ),
            ),
          )
        : Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: ListView.builder(
                controller: _scrollController,
                key: ValueKey(widget.cubit.state.currentVariation),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final UserEntity user = users[index];

                  // Check if it's the last item and pagination is loading
                  final isLastItem = index == users.length - 1 &&
                      widget.cubit.state.isPaginationLoading!;

                  if (isLastItem) {
                    // Wrap last user card with a loader below it
                    return Column(
                      children: [
                        UserCardLoaded(
                          key: ValueKey(user.id),
                          user: user,
                          onEdit: () {
                            if (widget.cubit.state.currentVariation ==
                                UserVariations.trainer) {
                              Navigator.pushNamed(
                                context,
                                ManageTrainerScreen.routeName,
                                arguments: user,
                              );
                            }
                          },
                          onDelete: () {
                            _handleDelete(user);
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: context.setMinSize(8),
                              bottom: context.setMinSize(8)),
                          child:
                              const CustomLoader(), // Loader below the last user card
                        ),
                      ],
                    );
                  }

                  // Normal user card
                  return UserCardLoaded(
                    key: ValueKey(user.id),
                    user: user,
                    onEdit: () {
                      if (widget.cubit.state.currentVariation ==
                          UserVariations.trainer) {
                        Navigator.pushNamed(
                          context,
                          ManageTrainerScreen.routeName,
                          arguments: user,
                        );
                      }
                    },
                    onDelete: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomConfirmationDialog(
                          title: "confirmation.deleteUser".tr(),
                          confirmationTitle: "confirmation.deleteMessage".tr(),
                          onConfirm: () {
                            Navigator.pop(context);
                            _handleDelete(user);
                          },
                        ),
                      );
                      _handleDelete(user);
                    },
                  );
                },
              ),
            ),
          );
  }

  String? _getEmptyStateMessage(UserManagmentState state) {
    if (state.isSearching! && state.searchList!.isEmpty) {
      return 'No search results Found';
    }

    final variationMessages = {
      UserVariations.trainer: 'No Trainers Found',
      UserVariations.client: 'No Clients Found',
    };

    if (!state.isSearching!) {
      if (state.currentVariation == UserVariations.trainer &&
          state.trainers!.isEmpty) {
        return variationMessages[UserVariations.trainer];
      }
      if (state.currentVariation == UserVariations.client &&
          state.clients!.isEmpty) {
        return variationMessages[UserVariations.client];
      }
    }

    return null;
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentVariation = widget.cubit.state.currentVariation;
    if (maxScroll == _scrollController.offset) {
      if (currentVariation == UserVariations.trainer) {
        widget.cubit.getTrainers();
      } else {
        widget.cubit.getClients();
      }
    }
  }

  void _handleDelete(UserEntity user) {
    widget.cubit.onDelete(user);
  }
}
