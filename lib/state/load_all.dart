import 'package:pechkin_flutter/index.dart';

loadAll() async {
  Api.setHeader(Cache.getToken());

  return await Future.wait<dynamic>([
    authCubit.load(),
    projectListCubit.load(),
  ]);
}
