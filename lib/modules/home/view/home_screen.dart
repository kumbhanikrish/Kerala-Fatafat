import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:kolkata_fatafat/modules/home/cubit/home_cubit.dart';
import 'package:kolkata_fatafat/modules/home/model/game_model.dart';
import 'package:kolkata_fatafat/utils/constant/routes_constant.dart';
import 'package:kolkata_fatafat/utils/theme/colors.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_banner.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_image.dart';
import 'package:kolkata_fatafat/utils/widgets/custom_text.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context).homeBanners(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<GamesModel> gamesList = [];
    List<String> bannerImages = [];

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is BannersLoaded) {
          bannerImages = state.bannersList;
        } else if (state is HomeGamesLoaded) {
          gamesList = state.gamesList;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(24),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,

                viewportFraction: 0.9,
                aspectRatio: 16 / 9,
              ),
              items:
                  bannerImages.map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CustomCachedImage(
                            imageUrl: imageUrl,

                            width: 100.w,
                          ),
                        );
                      },
                    );
                  }).toList(),
            ),
            Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomText(
                text: 'Games',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child:
                    gamesList.isEmpty
                        ? Center(
                          child: CustomText(
                            text: 'Game Not found!!!',
                            color: AppColor.greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                        : ListView.separated(
                          itemCount: gamesList.length,
                          separatorBuilder: (context, index) => Gap(20),
                          itemBuilder: (context, index) {
                            GamesModel gamesModel = gamesList[index];
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColor.whiteColor,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    splashColor: AppColor.borderColor,
                                    highlightColor: AppColor.borderColor,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.slotsScreen,
                                        arguments: {'gamesModel': gamesModel},
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: gamesModel.name,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Gap(10),
                                          CustomTitleName(
                                            width: 70,
                                            title: 'Max Bet',
                                            text: gamesModel.maxBet,
                                          ),
                                          Gap(5),
                                          CustomTitleName(
                                            width: 70,
                                            title: 'Min Bet',
                                            text: gamesModel.minBet,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -24,
                                  top: 18,
                                  child: CustomBanner(
                                    text:
                                        gamesModel.status[0].toUpperCase() +
                                        gamesModel.status
                                            .substring(1)
                                            .toLowerCase(),
                                    color: AppColor.borderColor,
                                    textColor: AppColor.themePrimaryColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
              ),
            ),
          ],
        );
      },
    );
  }
}
