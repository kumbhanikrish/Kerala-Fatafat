import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolkata_fatafat/modules/home/model/game_slots_model.dart';
import 'package:kolkata_fatafat/modules/home/repository/home_repository.dart';

part 'game_slot_state.dart';

class GameSlotCubit extends Cubit<GameSlotState> {
  GameSlotCubit() : super(GameSlotInitial());
  HomeRepository homeRepository = HomeRepository();

  Future<Response> gamesSlots(
    BuildContext context, {
    required int gameId,
  }) async {
    GamesSlotsModel gamesSlotsModel = GamesSlotsModel(slots: []);
    Response response = await homeRepository.gamesSlotsRepository(
      context,
      gameId: gameId,
    );
    if (response.statusCode == 200) {
      gamesSlotsModel = GamesSlotsModel.fromJson(response.data);
      emit(GamesSlotsLoaded(gamesSlotsModel: gamesSlotsModel));
    }

    return response;
  }

  init() {
    emit(GameSlotInitial());    
  }
}
