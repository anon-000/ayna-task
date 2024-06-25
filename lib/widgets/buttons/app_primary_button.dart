import 'package:ayna_task/config/environment.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../loaders/app_progress.dart';

///
/// Created by Auro on 25/06/24
///

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    required this.child,
    super.key,
    this.onPressed,
    this.height,
    this.width,
    this.color,
    this.shape,
    this.padding,
    this.radius,
    this.gradient = true,
    this.textStyle,
    this.isIconNeeded = false,
  });

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width, radius;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final bool gradient;
  final bool isIconNeeded;

  @override
  AppPrimaryButtonState createState() => AppPrimaryButtonState();
}

class AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = widget.width ??
        (MediaQuery.of(context).size.width > 400
            ? 400
            : MediaQuery.of(context).size.width);
    return _isLoading
        ? const Center(child: AppProgress(color: AppColors.primaryColor))
        : Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.primaryColor,
              borderRadius: BorderRadius.circular(widget.radius ?? 14),
              gradient: null,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width, 48),
                foregroundColor: Colors.white,
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: widget.padding ??
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 48),
                textStyle: widget.textStyle ??
                    const TextStyle(
                      fontSize: 14,
                      fontFamily: Environment.fontFamily,
                      letterSpacing: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 10),
                ),
              ),
              onPressed: widget.onPressed,
              child: widget.isIconNeeded
                  ? Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "",
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        widget.child
                      ],
                    )
                  : widget.child,
            ),
          );
  }
}
