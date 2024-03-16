import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_bloc/data/data_provider.dart';

class Datarepositery {
  Future<List<dynamic>> getdata() async {
    try {
      final respone = await Dataprovider().getdata();
      if (respone.statusCode == 200) {
        final body = respone.body;
        final json = jsonDecode(body);
        return json['items'];
      }
      return [];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  datasubmiting(String title, String description) async {
    final body = Dataprovider().submitdata(title, description);
    const url = 'https://api.nstack.in/v1/todos';

    final uri = Uri.parse(url);
    try {
      final response = await http.post(uri,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 201) {
        return "success";
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  deletingdata(String id) async {
    try {
      final response = await Dataprovider().datadeleting(id);
      if (response.statusCode == 200) {
        return 'success';
      }
    } catch (e) {
      return 'failure';
    }
  }

  updateData(String id, String title, String description) async {
    try {
      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final body = Dataprovider().dataediting(title, description);
      final response = await http.put(uri,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return "success";
      }
    } catch (e) {
      return "failure";
    }
  }
}
