import 'package:ayna_task/config/app_colors.dart';
import 'package:flutter/material.dart';

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
        // SvgPicture.asset(assetPath ?? 'assets/icons/error.svg'),
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
        if (assetPath != null)
          Image.asset(
            assetPath ?? 'assets/icons/cute_dog.png',
            height: 250,
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(title ?? 'Empty',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        if (onReload != null)
          MaterialButton(
            textColor: Colors.white,
            color: AppColors.primaryColor,
            onPressed: onReload,
            child: Text(buttonText ?? 'Reload'),
          )
      ],
    );
  }
}
