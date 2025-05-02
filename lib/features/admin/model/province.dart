import 'dart:convert';

Map<String, int> provincesFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, int>(k, v));

String provincesToJson(Map<String, int> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v)));
