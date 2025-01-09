import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pro_icon/Core/cubits/user_state/user_state_cubit.dart';
import 'package:pro_icon/Core/utils/extensions/size_helper.dart';
import 'package:pro_icon/Core/utils/extensions/spaces.dart';
import 'package:pro_icon/Features/Profile/Cubit/profile_cubit.dart';
import 'package:pro_icon/data/models/city_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Core/cubits/phone_registration/phone_register_cubit.dart';
import '../../../Core/cubits/region_cubit/region_cubit.dart';
import '../../../Core/dependencies.dart';
import '../../../Core/entities/user_entity.dart';
import '../../../Core/utils/extract_local_phone.dart';
import '../../../Core/widgets/city_dropdown_form_section.dart';
import '../../../Core/widgets/country_dropdown_form_section.dart';
import '../../../Core/widgets/custom_button.dart';
import '../../../Core/widgets/custom_loader.dart';
import '../../../Core/widgets/custom_snack_bar.dart';
import '../../../Core/widgets/full_address_form_section.dart';
import '../../../Core/widgets/fullname_form_section.dart';
import '../../auth/register/widgets/phone_form_section.dart';

class UpdateProfileForm extends StatelessWidget {
  const UpdateProfileForm({
    super.key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFullNameSection(),
            context.setMinSize(20).verticalSpace,
            context.setMinSize(20).verticalSpace,
            _buildPhoneSection(),
            context.setMinSize(20).verticalSpace,
            _buildRegionSection(),
            context.setMinSize(20).verticalSpace,
            _buildAddressSection(),
            context.setMinSize(130).verticalSpace,
            _buildConfirmButton(context),
          ],
        ));
  }

  Widget _buildConfirmButton(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state.isError) {
          buildCustomAlert(context, state.message!, Colors.red);
        }
        if (state.isSuccess) {
          buildCustomAlert(context, state.message!, Colors.green);
          Future.delayed(const Duration(seconds: 3), () {
            context.read<ProfileCubit>().setStatus(ProfileStatus.initial);
          });
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return SizedBox(
              height: context.setMinSize(60), child: const CustomLoader());
        }
        return CustomButton(
          onPressed: () {
            if (_formKey.currentState?.saveAndValidate() ?? false) {
              print("Form validated successfully");
              _handleProfileUpdate(context, state);
            }
          },
          text: "confirm".tr(),
        );
      },
    );
  }

  void _handleProfileUpdate(BuildContext context, ProfileState state) {
    final phoneCubit = context.read<PhoneRegistrationCubit>();

    // Validate phone number
    if (!_isPhoneValid(phoneCubit)) return;

    // Build the full phone number
    final String? phone = _formKey.currentState?.fields['phone']?.value;
    final String fullPhoneNumber = _buildFullPhoneNumber(phoneCubit, phone);

    // Prepare form data
    final Map<String, dynamic> formData =
        _buildFormData(context, state, fullPhoneNumber);

    // Extract only changed fields
    final UserEntity user = context.read<UserStateCubit>().state.currentUser!;
    final Map<String, dynamic> changedFields =
        _getChangedFields(user, formData);

    // Perform update only if there are changes
    if (changedFields.isNotEmpty) {
      final cubit = context.read<ProfileCubit>();
      cubit.updateProfile(body: changedFields);
    }
  }

  /// Checks if the phone number is valid
  bool _isPhoneValid(PhoneRegistrationCubit phoneCubit) {
    return phoneCubit.state.errorMessage?.isEmpty ?? false;
  }

  /// Builds the full phone number by appending the country code
  String _buildFullPhoneNumber(
      PhoneRegistrationCubit phoneCubit, String? phone) {
    final countryCode = phoneCubit.state.phoneCode;
    return '$countryCode$phone';
  }

  /// Builds the form data with the updated fields
  Map<String, dynamic> _buildFormData(
      BuildContext context, ProfileState state, String fullPhoneNumber) {
    final formData = Map<String, dynamic>.from(_formKey.currentState!.value);
    final updatedFormData = formData.map((key, value) {
      if (key == "city") {
        return MapEntry("cityId", (value as CityModel).id.toString());
      }
      if (key == "fullAddress") {
        return MapEntry("address", value);
      }
      if (key == "fullName") {
        return MapEntry("fullname", value);
      }
      if (key == "phone") {
        return MapEntry("phone", fullPhoneNumber);
      }

      return MapEntry(key, value);
    });

    // Include the image path if it is not empty
    if (state.selectedImagePath != null &&
        state.selectedImagePath!.isNotEmpty) {
      updatedFormData['file'] = state.selectedImagePath;
    }

    return updatedFormData;
  }

  /// Extracts only the changed fields
  Map<String, dynamic> _getChangedFields(
      UserEntity user, Map<String, dynamic> formData) {
    final Map<String, dynamic> changedFields = {};

    if (user.fullname != formData["fullname"]) {
      changedFields["fullname"] = formData["fullname"];
    }

    if (user.phone != formData["phone"]) {
      changedFields["phone"] = formData["phone"];
    }
    if (user.city?.id != int.parse(formData["cityId"])) {
      changedFields["cityId"] = formData["cityId"];
    }
    if (user.address != formData["address"]) {
      changedFields["address"] = formData["address"];
    }
    if (formData.containsKey("file")) {
      changedFields["file"] = formData["file"];
    }

    return changedFields;
  }

  Widget _buildAddressSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.address!;
      },
      builder: (context, state) {
        return FullAddressFormSection(
          intialValue: state,
        );
      },
    );
  }

  Widget _buildPhoneSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.phone!;
      },
      builder: (context, state) {
        return PhoneFormSection(
          intialValue: state.isEmpty ? "" : extractLocalNumber(state),
        );
      },
    );
  }

  Widget _buildFullNameSection() {
    return BlocSelector<UserStateCubit, UserStateState, String>(
      selector: (state) {
        return state.currentUser!.fullname!;
      },
      builder: (context, state) {
        return FullNameFormSection(
          intialValue: state,
        );
      },
    );
  }

  Widget _buildRegionSection() {
    return BlocConsumer<RegionCubit, RegionState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          buildCustomAlert(context, state.errorMessage!, Colors.red);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final intialCountryValue =
            getIt<UserStateCubit>().state.currentUser!.city!.country;

        final intialCityValue =
            getIt<UserStateCubit>().state.currentUser!.city!;
        return Skeletonizer(
          enabled: state.status == RequestStatus.loading,
          child: Builder(builder: (context) {
            return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: context.setMinSize(130)),
              child: Row(
                children: [
                  Expanded(
                    child: CountryDropDownFormSection(
                      keyName: state.status == RequestStatus.loading
                          ? "country-loading"
                          : "country",
                      countries: state.countries!,
                      onChanged: (country) {
                        if (country != null) {
                          BlocProvider.of<RegionCubit>(context)
                              .onSelectCountry(country);
                        }
                      },
                      initialValue: intialCountryValue,
                    ),
                  ),
                  context.setMinSize(20).horizontalSpace,
                  Expanded(
                    child: CityDropDownFormSection(
                      keyName: state.status == RequestStatus.loading
                          ? "city-loading"
                          : "city",
                      cities: state.cities!,
                      initialValue: intialCityValue,
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
