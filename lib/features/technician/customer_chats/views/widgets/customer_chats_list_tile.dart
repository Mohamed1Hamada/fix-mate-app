import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/helper/format_time_diffrence.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/chat/models/chat_model.dart';
import 'package:flutter/material.dart';

class CustomerChatsListTile extends StatelessWidget {
  final ChatModel chatModel;
  final int index;
  const CustomerChatsListTile({
    super.key,
    required this.chatModel,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.01,
          ),
          leading: CircleAvatar(
            radius: SizeConfig.width * 0.08,
            backgroundImage: NetworkImage(chatModel.chatWithUser!.image),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  chatModel.chatWithUser!.fullName,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.title16BlackW500,
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Text(
                formatTimeDifference(chatModel.messages!.last.createdAt)
                    .toString(),
                style: AppTextStyles.title12Grey,
              ),
            ],
          ),
          subtitle: Text(
            chatModel.messages!.last.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title14Grey,
          ),
          onTap: () {
            context.pushScreen(
              RouteNames.chatScreen,
              arguments: chatModel.toJson(),
            );
          },
        ),
      ),
    );
  }
}
