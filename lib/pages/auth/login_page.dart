import 'package:ayna_task/blocs/auth_bloc/auth_bloc.dart';
import 'package:ayna_task/blocs/auth_bloc/auth_events.dart';
import 'package:ayna_task/blocs/base_state.dart';
import 'package:ayna_task/config/app_assets.dart';
import 'package:ayna_task/config/app_colors.dart';
import 'package:ayna_task/config/app_decorations.dart';
import 'package:ayna_task/utils/auth_helper.dart';
import 'package:ayna_task/widgets/buttons/app_primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/environment.dart';
import '../../utils/validation_helper.dart';

///
/// Created by Auro on 24/06/24 at 8:55 pm
///

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool get isLogin => AuthBloc().authType == 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.loginSideBG,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.asset(
                      AppAssets.skullIllustration,
                      errorBuilder: (a, b, c) => const SizedBox(),
                      // cacheHeight: 500,
                      // cacheWidth: 500,
                    ),
                  ),
                  const Text(
                    r"<The Echo Bot /> welcomes you ☠️",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocBuilder<AuthBloc, BaseState>(
                builder: (context, BaseState state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAssets.logo),
                      const SizedBox(height: 20),
                      Text(
                        isLogin ? "Login to your Account" : "Create an Account",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greyTextColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "To chat with the Server powered by WebSocket 👾",
                        style: TextStyle(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            AppFormValidators.validateMail(v, context),
                        onSaved: (v) {},
                        decoration: AppDecorations.textFieldDecoration(context)
                            .copyWith(hintText: "mail@abc.com"),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        validator: (v) =>
                            AppFormValidators.validateMail(v, context),
                        onSaved: (v) {},
                        decoration: AppDecorations.textFieldDecoration(context)
                            .copyWith(hintText: "******************"),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Checkbox(value: true, onChanged: (c) {}),
                            const Text("Remember Me")
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: AppPrimaryButton(
                          width: double.infinity,
                          child: const Text("Login"),
                          onPressed: () {
                            // AuthHelper.userSignUpWithEmail("Abc", "abc@gmail.com", "ABC@123");
                            AuthHelper.userLoginWithEmail(
                                "abc@gmail.com", "ABC@123");
                          },
                        ),
                      ),
                      const SizedBox(height: 36),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Not Registered Yet? ",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: Environment.fontFamily,
                              fontSize: 15,
                              color: Color(0xff868686),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: " Create an account.",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: AppColors.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    AuthBloc().add(
                                      HandleAuthTypeEvent(isLogin ? 1 : 0),
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
