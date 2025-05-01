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
  Future<void> getFamilies({Map<String, dynamic>? filters}) async {
    emit(GetFamiliesLoading());

    final queryParams =
        filters != null
            ? filters.entries
                .where(
                  (entry) =>
                      entry.value != null && entry.value.toString().isNotEmpty,
                )
                .map(
                  (entry) =>
                      '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}',
                )
                .join('&')
            : '';

    final url =
        queryParams.isNotEmpty
            ? '${ApiConst.getFamilies}?$queryParams'
            : ApiConst.getFamilies;

    VPSDio.get(path: url)
        .then((value) {
          if (value.statusCode == 200) {
            familyModel = FamilyResponse.fromJson(value.data);
            emit(GetFamiliesSuccess());
          } else {
            emit(GetFamiliesError(message: value.data['message'] ?? 'Error'));
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
