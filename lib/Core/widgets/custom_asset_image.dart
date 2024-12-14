import 'package:flutter/material.dart';

class CustomAssetImage extends StatelessWidget {
  final String path;
  final BoxFit? fit;
  const CustomAssetImage({
    super.key,
    required this.path,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Image(fit: fit ?? BoxFit.cover, image: AssetImage(path));
  }
}
