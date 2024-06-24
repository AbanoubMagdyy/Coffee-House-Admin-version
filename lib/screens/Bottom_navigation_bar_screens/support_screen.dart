import 'package:coffee_house_admin_version/components/components.dart';
import 'package:coffee_house_admin_version/items/chat_card_item.dart';
import 'package:coffee_house_admin_version/shared/support_bloc/cubit.dart';
import 'package:coffee_house_admin_version/shared/support_bloc/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../style/colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SupportCubit, SupportStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SupportCubit.get(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: cubit.thePeopleWhoSentTheirComplaints.isNotEmpty,
              replacement: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.support_agent,
                    size: 70,
                    color: secColor,
                  ),
                  defText(text: 'No chats here'),
                ],
              ),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) => ChatCartItem(
                    userEmail: cubit.thePeopleWhoSentTheirComplaints[index],
                ),
                itemCount: cubit.thePeopleWhoSentTheirComplaints.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
