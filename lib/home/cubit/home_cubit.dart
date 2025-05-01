import 'package:charity/api/api_const.dart';
import 'package:charity/api/dio.dart';
import 'package:charity/model/family/family_m.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  int selectBottomindex = 0;

  void changeIndex(int index) {
    selectBottomindex = index;
    emit(HomeChangeIndex());
  }

  FamilyResponse? familyModel;
  Future<void> getFamilies() async {
    emit(GetFamiliesLoading());
    VPSDio.get(path: ApiConst.getFamilies)
        .then((value) {
          if (value.statusCode == 200) {
            familyModel = FamilyResponse.fromJson(value.data);
            emit(GetFamiliesSuccess());
          } else {
            emit(GetFamiliesError(message: value.data['message'] ?? 'error'));
          }
        })
        .catchError((e) {
          emit(GetFamiliesFaild());
        });
  }

  void initHome() {
    getFamilies();
  }
}
