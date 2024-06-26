import 'package:ayna_task/config/app_assets.dart';
import 'package:ayna_task/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

///
/// Created by Auro on 26/06/24
///

class AppErrorWidget extends StatelessWidget {
  final String? title, subtitle, buttonText, assetPath;
  final VoidCallback? onRetry;
  final Color? textColor;

  const AppErrorWidget(
      {super.key,
      this.title,
      this.subtitle,
      this.buttonText,
      this.assetPath,
      this.onRetry,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(assetPath ?? AppAssets.skullStanding),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(title ?? 'Error',
                style: TextStyle(color: textColor, fontSize: 16)),
          ),
        ),
        if (onRetry != null)
          MaterialButton(
            onPressed: onRetry,
            textColor: Colors.white,
            color: AppColors.primaryColor,
            child: Text(buttonText ?? 'Retry'),
          )
      ],
    );
  }
}

class AppEmptyWidget extends StatelessWidget {
  final String? title, subtitle, buttonText, assetPath;
  final VoidCallback? onReload;
  final Color? textColor;

  const AppEmptyWidget(
      {this.title,
      this.subtitle,
      this.buttonText,
      this.assetPath,
      this.onReload,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          assetPath ?? AppAssets.skullStanding,
          height: 250,
        ),
        if (title != null)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(title ?? 'Empty',
                  style: const TextStyle(
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        if (onReload != null)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
              onPressed: onReload,
              child: Text(
                buttonText ?? 'Reload',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
      ],
    );
  }
}
