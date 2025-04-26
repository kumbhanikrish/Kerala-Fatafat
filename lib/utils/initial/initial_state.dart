import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolkata_fatafat/modules/auth/cubit/auth_cubit.dart';
import 'package:kolkata_fatafat/modules/bet/cubit/bet_cubit.dart';
import 'package:kolkata_fatafat/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:kolkata_fatafat/modules/home/cubit/game_slot_cubit.dart';

allStateInitial(BuildContext context) {
  context.read<AuthCubit>().init();
  context.read<ChangePassCubit>().init();
  context.read<ChangePass2Cubit>().init();
  context.read<BottomNavCubit>().init();
  context.read<BetCubit>().init();
  context.read<GameSlotCubit>().init();
}
