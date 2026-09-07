import 'dart:convert';

import 'package:http/http.dart' as http;
// DONT DELETE 
// insane code honestly
class GeminiApi {
  sendRequest(String req) async {
    String link =
        "https://generativelanguage.googleapis.com/v1beta/interactions";
    var uri = Uri.parse(link);

    // ! -------------------------- NEW THINGS -----------------------

    Map<String, String>? header = {
      "x-goog-api-key": "XXXX", // testProject3's Key
    };

    Map<String, String>? body = {
      "model": "gemini-3.8-flash",
      "input": req // ANY QUESTION
    };

    // ! -------------------------- NEW THINGS -----------------------

    var request = await http.post(uri, headers: header, body: jsonEncode(body));
    print(request.statusCode);

    // if (request.statusCode == 429) {
    //   print("NO TOKEN");
    //   return;
    // }
    // if (request.statusCode != 200) {
    //   print("Something is wrong");
    //   return;
    // }

    var response = request.body; // String, we want it as Json
    var responseBody = jsonDecode(response); // fixed ^^^^

    return responseBody["steps"][1]["content"][0]["text"].toString();
  }
}
