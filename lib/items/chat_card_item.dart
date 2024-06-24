import 'package:coffee_house_admin_version/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/components.dart';
import '../models/massage_model.dart';
import '../screens/chat_screen.dart';
import '../shared/support_bloc/cubit.dart';

class ChatCartItem extends StatelessWidget {
      final String userEmail;
       MessageModel? message;

       ChatCartItem({Key? key, required this.userEmail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder(
        stream: SupportCubit.getLastMessage(userEmail),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
          if (list.isNotEmpty) message = list[0];
          return InkWell(
            onTap: () => navigateTo(context, ChatScreen(userEmail: userEmail,)),
            child: Container(
              padding: const EdgeInsets.all( 8.0),
              margin: const EdgeInsetsDirectional.all(5),
              decoration: BoxDecoration(
                color: secColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: defText(text: userEmail,textColor: defColor.withOpacity(0.3))),
                      defText(text: formatDateTime(message?.dateTime)),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  defText(text: message?.message ?? '',textColor: defColor),
                ],
              ),
            ),
          );
        }
    );
  }

      String formatDateTime(DateTime? dateTime) {
        DateTime now = DateTime.now();
        Duration difference = now.difference(dateTime ?? now);

        if (difference.inSeconds < 60) {
          return 'Now';
        } else if (difference.inMinutes < 60) {
          return '${difference.inMinutes}m ago';
        } else if (difference.inHours < 24) {
          return '${difference.inHours}h ago';
        }
        else if (difference.inDays < 2) {
          return 'yesterday';
        }
        else if (difference.inDays < 7) {
          return '${difference.inDays}d ago';
        } else  {
          return DateFormat('MM/dd/yyyy').format(dateTime ?? now);
        }
      }

}
