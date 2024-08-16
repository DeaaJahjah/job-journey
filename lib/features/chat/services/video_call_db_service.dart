import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_journey/features/chat/models/agora_setup.dart';

class VideoCallDbService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<AgoraSetupModel?> getAgoraSetup() async {
    try {
      var query = await _db.collection('agoraSetup').get();

      print(query);

      return AgoraSetupModel.fromJson(query.docs[0].data());
    } on FirebaseException catch (e) {
      print('aaaaaaaa ${e.toString()}');
      return null;
    }
  }
}
