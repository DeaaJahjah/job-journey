import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:job_journey/core/config/constant/propmts.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/keys.dart';

class AnalyzeProfileProvider extends ChangeNotifier {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  DataState dataState = DataState.notSet;

  String data = '';

  initGemini() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: GEMINI_KEY,
    );

    _chat = _model.startChat();
  }

  Future<void> analyzeMyProfile({required String cv}) async {
    dataState = DataState.loading;
    notifyListeners();
    final response = await _chat.sendMessage(
      Content.text(Propmts.analyzeProfile + cv),
    );

    if (response.text == null) {
      dataState = DataState.failure;
    } else {
      print(response.text);
      data = response.text!;
      dataState = DataState.done;
    }
    notifyListeners();
  }
}
