import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:servisgo_partner/features/auth/domain/entities/partner_entity.dart';
import 'package:servisgo_partner/features/home/domain/entities/user_entity.dart';
import 'package:servisgo_partner/features/home/presentation/bloc/user_cubit/user_cubit.dart';

import '../../../../size_config.dart';
import '../../domain/entities/text_message_entity.dart';
import '../bloc/chat_cubit/chat_cubit.dart';
import '../widgets/message_tile.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({
    Key? key,
    required this.currentPartner,
  }) : super(key: key);
  final PartnerEntity currentPartner;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).getTextMessages();
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Messages",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert_sharp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            final Map<String, TextMessageEntity> conversationMap = {};

            for (TextMessageEntity textMessageEntity in state.messages) {
              final String conversationId =
                  _getConversationId(textMessageEntity);
              if (!conversationMap.containsKey(conversationId) ||
                  textMessageEntity.timestamp.toDate().isAfter(
                        conversationMap[conversationId]!.timestamp.toDate(),
                      )) {
                conversationMap[conversationId] = textMessageEntity;
              }
            }

            final List<TextMessageEntity> allMessages =
                conversationMap.values.toList();
            allMessages.sort((a, b) =>
                b.timestamp.compareTo(a.timestamp)); // Sort by timestamp

            return ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(32),
              ),
              itemCount: allMessages.length,
              itemBuilder: (BuildContext context, int index) {
                return BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      final UserEntity user = state.users.firstWhere(
                        (user) =>
                            user.uid == allMessages[index].recipientId ||
                            user.uid == allMessages[index].senderId,
                      );
                      return Padding(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(28)),
                        child: MessageTile(
                          imgUrl: user.pfpURL,
                          name: user.name,
                          lastMsg: allMessages[index].message,
                          time: DateFormat('hh:mm a')
                              .format(allMessages[index].timestamp.toDate()),
                          currentUser: user,
                          currentPartner: widget.currentPartner,
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  String _getConversationId(TextMessageEntity message) {
    List<String> participants = [];
    if (message.senderId == widget.currentPartner.partnerId) {
      participants = [message.senderId, message.recipientId];
    } else {
      participants = [message.recipientId, message.senderId];
    }

    participants.sort();
    return participants.join('_');
  }
}
