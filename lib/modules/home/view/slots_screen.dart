import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/home/cubit/game_slot_cubit.dart';
import 'package:kolkata_fatafat/modules/home/model/game_model.dart';
import 'package:kolkata_fatafat/modules/home/model/game_slots_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class SlotsScreen extends StatelessWidget {
  final dynamic data;
  const SlotsScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    GameSlotCubit gameSlotCubit = BlocProvider.of<GameSlotCubit>(context);
    GamesSlotsModel gamesSlotsModel = GamesSlotsModel(slots: []);

    GamesModel gamesModel = data['gamesModel'];

    gameSlotCubit.gamesSlots(context, gameId: gamesModel.id);

    return Scaffold(
      appBar: CustomAppBar(title: 'Slots'),
      body: BlocBuilder<GameSlotCubit, GameSlotState>(
        builder: (context, state) {
          if (state is! GamesSlotsLoaded) {
            return Container();
          } else {
            gamesSlotsModel = state.gamesSlotsModel;
            return Padding(
              padding: const EdgeInsets.all(24),
              child:
                  gamesSlotsModel.slots.isEmpty
                      ? Center(
                        child: CustomText(
                          text: 'Slot Not found!!!',
                          color: AppColor.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : ListView.separated(
                        itemCount: gamesSlotsModel.slots.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Gap(20);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          Slot slot = gamesSlotsModel.slots[index];

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),

                              border: Border.all(
                                color: AppColor.themePrimary3Color,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              child: Column(
                                children: [
                                  CustomText(text: slot.time),
                                  Gap(16),
                                  CustomButton(
                                    text: slot.status,
                                    onTap:
                                        slot.status == 'open' && slot.isEligible
                                            ? () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.betScreen,
                                                arguments: {
                                                  'slot': slot.time,
                                                  'gamesModel': gamesModel,
                                                },
                                              );
                                            }
                                            : () {
                                              if (!slot.isEligible) {
                                                customToast(
                                                  context,
                                                  text:
                                                      'You have already placed bet',
                                                  animatedSnackBarType:
                                                      AnimatedSnackBarType
                                                          .warning,
                                                );
                                              }
                                            },
                                    backgroundColor:
                                        slot.status == 'open'
                                            ? AppColor.themePrimaryColor
                                            : AppColor.borderColor,

                                    textColor:
                                        slot.status == 'open'
                                            ? AppColor.backgroundColor
                                            : AppColor.themePrimary2Color,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            );
          }
        },
      ),
    );
  }
}
