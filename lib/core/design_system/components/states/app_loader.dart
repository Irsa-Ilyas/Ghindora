import 'package:flutter/material.dart';

import '../../design_tokens.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final bool isWhite;

  const AppLoader({super.key, this.size = 32.0, this.isWhite = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(
            isWhite ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
