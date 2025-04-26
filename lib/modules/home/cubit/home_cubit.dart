// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolkata_fatafat/modules/home/model/game_model.dart';
import 'package:kolkata_fatafat/modules/home/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeRepository homeRepository = HomeRepository();

  Future<Response> homeBanners(BuildContext context) async {
    List<String> bannersList = [];

    Response response = await homeRepository.homeBanners(context);

    if (response.statusCode == 200) {
      homeGame(context);
      bannersList =
          (response.data['banners'] as List).map((e) => e.toString()).toList();

      emit(BannersLoaded(bannersList: bannersList));
    }
    return response;
  }

  Future<Response> homeGame(BuildContext context) async {
    List<GamesModel> gamesList = [];
    Response response = await homeRepository.homeGameRepository(context);

    if (response.statusCode == 200) {
      gamesList =
          (response.data as List).map((e) => GamesModel.fromJson(e)).toList();
      emit(HomeGamesLoaded(gamesList: gamesList));
    }
    return response;
  }

  init() {
    emit(HomeInitial());
  }
}
