import '../../core.dart';

class GetPref {
  Future<bool> isLocationAccess() async {
    return await SharedPref().get(
      key: PrefConst.isLocationAccess,
      type: PrefType.bool,
    );
  }
}
