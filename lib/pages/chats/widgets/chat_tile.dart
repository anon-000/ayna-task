import 'package:ayna_task/config/app_colors.dart';
import 'package:ayna_task/data_models/chat.dart';
import 'package:ayna_task/utils/common_functions.dart';
import 'package:flutter/material.dart';

///
/// Created by Auro on 26/06/24
///

class ChatTile extends StatelessWidget {
  final Chat datum;

  const ChatTile(this.datum, {super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isServer = datum.createdBy == "SERVER";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: isServer ? Alignment.centerLeft : Alignment.centerRight,
        child: IntrinsicWidth(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700 * 0.7),
            child: Column(
              crossAxisAlignment:
                  isServer ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: const BoxConstraints(minWidth: 700 * 0.15),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: isServer
                          ? AppColors.chatServerBG
                          : AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isServer ? 0 : 15),
                        topRight: Radius.circular(isServer ? 15 : 0),
                        bottomLeft: const Radius.circular(15),
                        bottomRight: const Radius.circular(15),
                      )),
                  child: Text(
                    datum.text ?? '',
                    style: TextStyle(
                      color: isServer ? AppColors.greyTextColor : Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    datum.createdAt == null
                        ? "hh:mm am"
                        : timeInAgoFull(datum.createdAt!),
                    style: const TextStyle(
                      color: AppColors.greyTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
