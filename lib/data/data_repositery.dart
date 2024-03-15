import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/data/data_provider.dart';

class Datarepositery {
  getdata() async {
    final response = await Dataprovider().getdata();
    if (response.statusCode == 200) {
      final body = response.body;
      final jsonbody = jsonDecode(body);
      return jsonbody['items'];
    }
  }

  Future<String> datasubmiting(String title, String description) async {
    final body = Dataprovider().submitdata(title, description);
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return 'success';
    } else {
      return 'failure';
    }
  }

  datadeleting() {}
}
