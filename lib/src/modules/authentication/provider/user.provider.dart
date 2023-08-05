import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/user.dart';

typedef UserNotifier = AutoDisposeAsyncNotifierProvider<UserProvider, List<PktbsUser>>;

final userProvider = UserNotifier(UserProvider.new);

// final pbStream = StreamProvider((_) => pb.authStore.onChange);

class UserProvider extends AutoDisposeAsyncNotifier<List<PktbsUser>> {
  late List<PktbsUser> userList;

  @override
  FutureOr<List<PktbsUser>> build() async {
    // final id = PktbsUser.fromJson(pb.authStore.model!.toJson()).id;
    // _stream(id);
    // await pb
    //     .collection(users)
    //     .getOne(id)
    //     .then((r) => userList = [PktbsUser.fromJson(r.toJson())]);
    return userList;
  }

  // _stream(String id) {
  //   //
  // }
}
