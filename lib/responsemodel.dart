import 'dart:convert';

class ResponseModel {
  List<dynamic> choices;

  ResponseModel({required this.choices});

  factory ResponseModel.fromJson(String jsonStr) {
    final jsonData = json.decode(jsonStr);
    return ResponseModel(choices: jsonData['choices']);
  }
}
