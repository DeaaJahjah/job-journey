import 'package:equatable/equatable.dart';

class AgoraSetupModel extends Equatable {
  final String channelName;
  final String tempToken;

  const AgoraSetupModel({
    required this.channelName,
    required this.tempToken,
  });

  @override
  List<Object?> get props => [channelName, tempToken];

  factory AgoraSetupModel.fromJson(Map<String, dynamic> json) {
    print('agora setup : $json');
    return AgoraSetupModel(
      channelName: json['agora_channel_name'],
      tempToken: json['agora_temp_token'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'agora_channel_name': channelName,
      'agora_temp_token': tempToken,
    };
  }
}
