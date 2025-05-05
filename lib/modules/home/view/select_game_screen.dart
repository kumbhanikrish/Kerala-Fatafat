import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:kolkata_fatafat/modules/bet/model/add_bet_model.dart';
import 'package:kolkata_fatafat/modules/home/model/game_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

List<AddBetModel> gamesList = [
  AddBetModel(numberOfBet: 1, betAmount: 'Single'),
  AddBetModel(numberOfBet: 2, betAmount: 'Patti'),
];

class SelectGameScreen extends StatelessWidget {
  final dynamic data;
  const SelectGameScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    String slot = data['slot'];
    bool isEligible = data['isEligible'];
    GamesModel gamesModel = data['gamesModel'];
    return Scaffold(
      appBar: CustomAppBar(title: 'Games'),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.builder(
          itemCount: gamesList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: AppColor.themePrimaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap:
                    isEligible
                        ? () {
                          if (gamesList[index].numberOfBet == 1) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.betScreen,
                              arguments: {
                                'slot': slot,
                                'gamesModel': gamesModel,
                              },
                            );
                          } else if (gamesList[index].numberOfBet == 2) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.pattiScreen,
                              arguments: {
                                'slot': slot,
                                'gamesModel': gamesModel,
                              },
                            );
                          }
                        }
                        : () {
                          if (!isEligible) {
                            customToast(
                              context,
                              text: 'You have already placed bet',
                              animatedSnackBarType:
                                  AnimatedSnackBarType.warning,
                            );
                          }
                        },
                child: Center(
                  child: CustomText(
                    text: gamesList[index].betAmount,
                    color: AppColor.backgroundColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
