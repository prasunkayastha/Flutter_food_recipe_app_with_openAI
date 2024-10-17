import 'package:food_recipe_app/responsemodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class HomepageRepository {
  Future<dynamic> askAI(String prompt);
}

class HomePageRepo extends HomepageRepository {
  late ResponseModel _responseModel;
  @override
  Future<dynamic> askAI(String prompt) async {
    try {
      final response = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${dotenv.env['token']}'
          },
          body: {
            "model": 'text-davinci-003',
            "prompt": "Create a recipe from a list of ingridents: \n$prompt",
            "max_tokens": 250,
            "temperature": 0,
            "top_p": 1,
          });
      print(response.body);
      _responseModel = ResponseModel.fromJson(response.body);
      return _responseModel.choices[0]['text'];
    } catch (e) {
      return e.toString();
    }
  }
}
