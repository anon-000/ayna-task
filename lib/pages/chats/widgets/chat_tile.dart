import 'package:ayna_task/config/app_colors.dart';
import 'package:ayna_task/data_models/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// Created by Auro on 26/06/24
///

class ChatTile extends StatelessWidget {
  final Chat datum;

  const ChatTile(this.datum, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.fromLTRB(datum.createdBy == "SERVER" ? 16 : 60, 0,
          datum.createdBy == "SERVER" ? 60 : 16, 0),
      decoration: BoxDecoration(
          color: datum.createdBy == "SERVER"
              ? AppColors.chatServerBG
              : AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(datum.createdBy == "SERVER" ? 0 : 10),
            topRight: Radius.circular(datum.createdBy == "SERVER" ? 10 : 0),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            datum.text ?? '',
            style: TextStyle(
              color: datum.createdBy == "SERVER"
                  ? AppColors.greyTextColor
                  : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${DateFormat("hh:mm a").format(datum.createdAt!)}",
            style: TextStyle(
              color: datum.createdBy == "SERVER"
                  ? AppColors.greyTextColor
                  : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
