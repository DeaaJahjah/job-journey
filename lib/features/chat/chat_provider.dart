import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/chat/chat_db_service.dart';

class ChatProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;
  Room? room;
  Future<void> createChatRoom({required String userId, required String userName}) async {
    dataState = DataState.loading;
    notifyListeners();
    final room = await ChatDbService().createChatRoom(userId: userId, userName: userName);
    if (room == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      this.room = room;
      dataState = DataState.done;
      notifyListeners();
    }
  }
}
