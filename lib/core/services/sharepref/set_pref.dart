import '../../core.dart';

class SetPref {
  Future<void> isLocationAccess({required bool value}) async {
    return await SharedPref().set(
      key: PrefConst.isLocationAccess,
      value: value,
      type: PrefType.bool,
    );
  }
}
