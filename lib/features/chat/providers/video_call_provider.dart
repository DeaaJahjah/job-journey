import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/features/chat/models/agora_setup.dart';
import 'package:job_journey/features/chat/services/video_call_db_service.dart';

class VideoCallProvider with ChangeNotifier {
  DataState dataState = DataState.notSet;
  AgoraSetupModel? agoraSetupModel;
  Future<void> getAgoraSetup() async {
    dataState = DataState.loading;
    this.agoraSetupModel = null;
    notifyListeners();
    final agoraSetupModel = await VideoCallDbService().getAgoraSetup();
    if (agoraSetupModel == null) {
      dataState = DataState.failure;
      notifyListeners();
    } else {
      this.agoraSetupModel = agoraSetupModel;
      dataState = DataState.done;
      notifyListeners();
    }
  }
}
