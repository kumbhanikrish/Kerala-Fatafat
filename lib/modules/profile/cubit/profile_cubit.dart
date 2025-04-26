import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/main.dart';
import 'package:kolkata_fatafat/modules/profile/model/bid_history_model.dart';
import 'package:kolkata_fatafat/modules/profile/model/chat_model.dart';
import 'package:kolkata_fatafat/modules/profile/repository/profile_reository.dart';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  ProfileRepository profileRepository = ProfileRepository();

  Future<Response> profile(
    BuildContext context, {
    required Map<String, dynamic> body,
  }) async {
    final Response response = await profileRepository.profile(
      context,
      body: body,
    );

    if (response.statusCode == 200) {
      User user = User.fromJson(response.data['data']);
      await localDataSaver.setUserData(user);

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.profileScreen,
        (route) => false,
      );

      customToast(
        context,
        text: response.data['message'],

        animatedSnackBarType: AnimatedSnackBarType.success,
      );
    } else {
      customToast(
        context,
        text: response.data['message'],

        animatedSnackBarType: AnimatedSnackBarType.error,
      );
    }
    return response;
  }

  Future<Response> sendMessage(
    BuildContext context, {
    required String message,
  }) async {
    final Response response = await profileRepository.sendMessage(
      context,
      message: message,
    );

    List<ChatModel> chatList = [];

    if (state is ChatLoaded) {
      chatList = (state as ChatLoaded).chatList;
    }

    ChatModel chatModel = ChatModel.fromJson(response.data['data']);

    if (message.isNotEmpty) {
      chatList.add(
        ChatModel(
          id: chatModel.id,
          userId: chatModel.userId,
          adminId: chatModel.adminId,
          message: chatModel.message,
          isAdminReply: chatModel.isAdminReply,
          createdAt: chatModel.createdAt,
          updatedAt: chatModel.updatedAt,
        ),
      );
      emit(ChatLoaded(chatList: chatList));
    }

    return response;
  }

  Future<Response> chat(BuildContext context) async {
    List<ChatModel> chatList = [];
    final Response response = await profileRepository.chat(context);
    if (response.statusCode == 200) {
      chatList =
          (response.data['chats'] as List)
              .map((e) => ChatModel.fromJson(e))
              .toList();

      emit(ChatLoaded(chatList: chatList));
    }
    return response;
  }

  Future<Response> userBid(BuildContext context) async {
    List<BidHistoryModel> bidHistoryList = [];
    final Response response = await profileRepository.userBid(context);
    if (response.statusCode == 200) {
      bidHistoryList =
          (response.data['bets'] as List)
              .map((e) => BidHistoryModel.fromJson(e))
              .toList();

      emit(BidHistoryLoaded(bidHistoryList: bidHistoryList));
    }
    return response;
  }
}
