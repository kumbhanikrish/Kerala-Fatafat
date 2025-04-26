import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/bet/cubit/bet_cubit.dart';
import 'package:kolkata_fatafat/modules/bet/model/add_bet_model.dart';
import 'package:kolkata_fatafat/modules/home/model/game_model.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_app_bar.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_button.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_error_toast.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_textfield.dart';

class BetScreen extends StatelessWidget {
  final dynamic data;
  const BetScreen({super.key, this.data});
  @override
  Widget build(BuildContext context) {
    ChangeBorderCubit changeBorderCubit = BlocProvider.of<ChangeBorderCubit>(
      context,
    );
    BetCubit betCubit = BlocProvider.of<BetCubit>(context);

    final TextEditingController betAmountController = TextEditingController();

    int changBorderValue = -1;
    List<AddBetModel> addBetList = [];

    changeBorderCubit.init();
    betCubit.init();

    String slot = data['slot'];
    GamesModel gamesModel = data['gamesModel'];

    return Scaffold(
      appBar: CustomAppBar(title: 'Bet'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: <Widget>[
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return BlocBuilder<BetCubit, BetState>(
                    builder: (context, state) {
                      if (state is BetLoaded) {
                        addBetList = state.addBetList;
                      }
                      return BlocBuilder<ChangeBorderCubit, ChangeBorderState>(
                        builder: (context, state) {
                          if (state is ChangeBorderLoaded) {
                            changBorderValue = state.changeNumber;
                          }

                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: AppColor.borderColor,
                            highlightColor: AppColor.borderColor,
                            onTap: () {
                              changeBorderCubit.changeBorderValue(
                                changeNumber: index,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color:
                                    index == 0
                                        ? Colors.green
                                        : index == 1
                                        ? Colors.deepOrange
                                        : index == 2
                                        ? Colors.blue
                                        : index == 3
                                        ? Colors.cyan
                                        : index == 4
                                        ? Colors.deepPurpleAccent
                                        : index == 5
                                        ? Colors.pink
                                        : index == 6
                                        ? Colors.teal
                                        : index == 7
                                        ? Colors.grey
                                        : index == 8
                                        ? Colors.blueGrey
                                        : Colors.brown,

                                border: Border.all(
                                  width: 5,
                                  color:
                                      changBorderValue == index
                                          ? AppColor.themePrimaryColor
                                          : AppColor.transparentColor,
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                  text: '$index ',
                                  color: AppColor.themePrimary2Color,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              Gap(24),
              Row(
                children: <Widget>[
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Amount Rs.',
                      controller: betAmountController,
                      keyboardType: TextInputType.number,
                      onChanged: (p0) {},
                    ),
                  ),
                  Gap(16),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.borderColor,

                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: BlocBuilder<ChangeBorderCubit, ChangeBorderState>(
                      builder: (context, state) {
                        if (state is ChangeBorderLoaded) {
                          changBorderValue = state.changeNumber;
                        }
                        return InkWell(
                          borderRadius: BorderRadius.circular(12),
                          splashColor: AppColor.borderColor,
                          highlightColor: AppColor.borderColor,
                          onTap: () async {
                            final int minBet =
                                double.parse(gamesModel.minBet).toInt();

                            final int maxBet =
                                double.parse(gamesModel.maxBet).toInt();
                            final input = betAmountController.text;
                            final amount = int.tryParse(input);

                            if (input.isEmpty) {
                              customToast(
                                context,
                                text: 'Please enter an amount.',

                                animatedSnackBarType:
                                    AnimatedSnackBarType.error,
                              );
                            } else if (amount == null) {
                              customToast(
                                context,
                                text: 'Invalid number.',

                                animatedSnackBarType:
                                    AnimatedSnackBarType.error,
                              );
                            } else if (amount < minBet) {
                              customToast(
                                context,
                                text: 'Minimum bet is ₹$minBet.',

                                animatedSnackBarType:
                                    AnimatedSnackBarType.error,
                              );
                            } else if (amount > maxBet) {
                              customToast(
                                context,
                                text: 'Maximum bet is ₹$maxBet.',

                                animatedSnackBarType:
                                    AnimatedSnackBarType.error,
                              );
                            } else {
                              await betCubit.addBetSection(
                                context,
                                numberOfBet: changBorderValue,
                                betAmount: betAmountController.text,
                              );
                              changeBorderCubit.init();
                              betAmountController.clear();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: CustomText(
                              text: 'Add',
                              color: AppColor.themePrimary2Color,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(24),
              BlocBuilder<BetCubit, BetState>(
                builder: (context, state) {
                  if (state is BetLoaded) {
                    addBetList = state.addBetList;
                  }
                  return addBetList.isEmpty
                      ? Center(
                        child: CustomText(
                          text: 'Bet Not found!!!',
                          color: AppColor.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                      : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: addBetList.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Gap(20);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          AddBetModel addBetModel = addBetList[index];
                          return Stack(
                            children: [
                              Container(
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
                                      CustomTitleName(
                                        title: 'Digit',
                                        width: 70,

                                        text:
                                            addBetModel.numberOfBet.toString(),
                                      ),
                                      Gap(10),
                                      CustomTitleName(
                                        title: 'Amount',
                                        width: 70,

                                        text: 'Rs.${addBetModel.betAmount}',
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Align(
                                alignment: Alignment.topRight,
                                child: CustomIconButton(
                                  icon: Icons.close,
                                  onPressed: () async {
                                    await betCubit.removeBetSection(
                                      context,
                                      numberOfBet: addBetModel.numberOfBet,
                                    );
                                  },
                                  color: AppColor.redColor,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocBuilder<BetCubit, BetState>(
        builder: (context, state) {
          if (state is BetLoaded) {
            addBetList = state.addBetList;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(
                text: 'Play Game',
                onTap: () {
                  List<Map<String, dynamic>> bets =
                      addBetList.map((bet) {
                        return {
                          "game_id": 1,
                          "digit": bet.numberOfBet,

                          "amount": double.parse(
                            bet.betAmount.toString(),
                          ), // Convert String to double if needed
                        };
                      }).toList();
                  Map<String, dynamic> body = {"time_slot": slot, "bets": bets};
                  betCubit.addBet(context, gameId: gamesModel.id, body: body);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
