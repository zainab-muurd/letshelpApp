import 'package:flutter/material.dart';

import '../models/single-porduct.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({Key? key, required this.singleProduct})
      : super(key: key);

  final SingleProduct singleProduct;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        singleProduct.clientImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
