import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/models/app_user_model.dart';
import '../../../data/models/city_model.dart';
import '../../../data/models/country_model.dart';
import 'user_card.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return UserCard(
              key: ValueKey(index),
              user: AppUserModel(
                id: index,
                fullname: 'Loading...',
                email: 'Loading...',
                phone: 'Loading...',
                city: const CityModel(
                  id: 1,
                  name: 'Loading...',
                  country: CountryModel(name: 'Loading...'),
                ),
                role: 'Loading...',
              ),
              onTap: () {},
              onEdit: () {},
              onDelete: () {},
            );
          },
        ),
      ),
    );
  }
}
