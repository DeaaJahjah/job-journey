import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ChatDbService {
  Future<Room?> createChatRoom({required String userId, required String userName}) async {
    try {
      final room = await FirebaseChatCore.instance.createRoom(User(id: userId, firstName: userName));
      return room;
    } catch (e) {
      print(e.toString());

      return null;
    }
  }
}
