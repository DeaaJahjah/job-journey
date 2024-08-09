import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_journey/features/chat/models/agora_setup.dart';

class VideoCallDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AgoraSetupModel?> getAgoraSetup() async {
    try {
      var query = await _db.collection('agoraSetup').doc('fQmx5eJCEPEjS4L3njf6').get();

      print(query);

      return AgoraSetupModel.fromJson(query.data()!);
    } on FirebaseException catch (_) {
      return null;
    }
  }
}
