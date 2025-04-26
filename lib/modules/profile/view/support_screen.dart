import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/profile/cubit/profile_cubit.dart';
import 'package:kolkata_fatafat/modules/profile/model/chat_model.dart';
import 'package:kolkata_fatafat/utils/constant/asset_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  List<ChatModel> chatList = [];

  // Scroll controller

  bottomScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(
          _scrollController.position.maxScrollExtent + 60,
        );
      }
    });
  }

  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).chat(context).then((e) {
      bottomScroll();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Support'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ChatLoaded) {
                    chatList = state.chatList;
                  }

                  return ListView.builder(
                    controller: _scrollController, // Attach controller here
                    itemCount: chatList.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        text: chatList[index].message,
                        isMe: chatList[index].isAdminReply,
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: 'Type a message...',
                    controller: messageController,
                  ),
                ),
                Gap(10),
                Container(
                  decoration: BoxDecoration(
                    color: AppColor.borderColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    splashColor: AppColor.borderColor,
                    highlightColor: AppColor.borderColor,
                    onTap: () async {
                      await profileCubit.sendMessage(
                        context,
                        message: messageController.text.trim(),
                      );
                      messageController.clear();
                      bottomScroll();
                    },
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset(
                          AppImage.send,
                          color: AppColor.themePrimary2Color,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final int isMe;

  const ChatBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe == 0 ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe == 0 ? AppColor.themePrimaryColor : AppColor.grey100Color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isMe == 0 ? Radius.circular(12) : Radius.circular(0),
            bottomRight: isMe == 0 ? Radius.circular(0) : Radius.circular(12),
          ),
        ),
        child: CustomText(
          text: text,
          color: isMe == 0 ? AppColor.themePrimary2Color : AppColor.blackColor,
        ),
      ),
    );
  }
}
