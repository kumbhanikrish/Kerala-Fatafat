import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:kolkata_fatafat/modules/result/cubit/result_cubit.dart';
import 'package:kolkata_fatafat/modules/result/model/result_model.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ResultCubit resultCubit = BlocProvider.of<ResultCubit>(context);
    ScrollController scrollController = ScrollController();

    List<ResultModel> resultList = [];
    resultCubit.result(context, isRefresh: true);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        resultCubit.result(context);
      }
    });
    return Padding(
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          if (state is! ResultLoaded) {
            return Container();
          } else {
            resultList = state.resultList;
            return resultList.isEmpty
                ? Center(
                  child: CustomText(
                    text: 'Result Not found!!!',
                    color: AppColor.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
                : ListView.separated(
                  controller: scrollController,
                  itemCount: resultList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Gap(20);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    ResultModel resultModel = resultList[index];

                    resultModel.session.sort((a, b) {
                      final format = DateFormat('hh:mm a');
                      final timeA = format.parse(a.session.split(' - ')[0]);
                      final timeB = format.parse(b.session.split(' - ')[0]);
                      return timeA.compareTo(timeB);
                    });
                    return Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: AppColor.transparentColor,
                        splashColor: AppColor.transparentColor,
                        highlightColor: AppColor.transparentColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColor.whiteColor,
                            width: 0.5,
                          ),
                        ),
                        child: ExpansionTile(
                          title: CustomText(
                            text: resultModel.date,

                            fontWeight: FontWeight.bold,
                          ),
                          initiallyExpanded:
                              resultModel.date ==
                                      DateFormat(
                                        'dd-MM-yyyy',
                                      ).format(DateTime.now())
                                  ? true
                                  : false,
                          iconColor: AppColor.themePrimary3Color,
                          collapsedIconColor: AppColor.themePrimary3Color,

                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12,
                                right: 12,
                                left: 12,
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: resultModel.session.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Session session = resultModel.session[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.themePrimaryColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: AppColor.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 15,
                                              vertical: 8,
                                            ),
                                            child: CustomText(
                                              text:
                                                  session.winNumber.toString(),
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          Gap(20),

                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  CustomText(
                                                    text: 'Winning Person :',
                                                    color: AppColor.borderColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  Gap(5),
                                                  CustomText(
                                                    text:
                                                        session.totalWinners
                                                            .toString(),
                                                    color: AppColor.whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),

                                              CustomText(
                                                text: session.session,
                                                color: AppColor.borderColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  return Gap(20);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
          }
        },
      ),
    );
  }
}
