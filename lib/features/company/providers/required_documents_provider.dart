import 'package:flutter/material.dart';

class RequiredDocumentsProvider with ChangeNotifier {
  List<TextEditingController> controllers = [TextEditingController(), TextEditingController()];
  List<Helper> documents = [const Helper(id: 0, text: ''), const Helper(id: 1, text: '')];

  setdocuments(List<String> documents) {
    if (documents.isEmpty) return;
    this.documents.clear();
    controllers.clear();

    for (int i = 0; i < documents.length; i++) {
      this.documents.add(Helper(id: i, text: documents[i]));
      controllers.add(TextEditingController(text: documents[i]));
    }
    notifyListeners();
  }

  removeDocument(int id) {
    documents.removeAt(id);
    controllers.removeAt(id);

    notifyListeners();
  }

  updateDocument({required int id, required String text}) {
    for (int i = 0; i < documents.length; i++) {
      if (id == documents[i].id) {
        documents[i] = Helper(id: id, text: text);
        break;
      }
    }
  }

  addDocument() {
    documents.add(Helper(id: documents.last.id + 1, text: ''));
    controllers.add(TextEditingController());

    notifyListeners();
  }

  clearDocuments() {
    controllers = [TextEditingController(), TextEditingController()];
    documents = [const Helper(id: 0, text: ''), const Helper(id: 1, text: '')];
  }
}

class Helper {
  final int id;
  final String text;

  const Helper({required this.id, required this.text});
}
