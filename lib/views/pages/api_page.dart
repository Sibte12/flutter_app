import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  void fetchData() async {
    var url = Uri.https('bored-api.appbrewery.com', '/random', {
      'q': '{http}',
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['activity'];
      print(itemCount);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Api Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FilledButton(onPressed: fetchData, child: Text('Get Api Data')),
          ),
        ],
      ),
    );
  }
}
