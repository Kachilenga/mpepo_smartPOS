import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

Future<void> saveTransaction(Map<String, dynamic> tx) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> queue = prefs.getStringList('offlineQueue') ?? [];
  queue.add(jsonEncode(tx));
  await prefs.setStringList('offlineQueue', queue);
}

Future<void> retryTransactions() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> queue = prefs.getStringList('offlineQueue') ?? [];

  final connectivity = await Connectivity().checkConnectivity();
  if (connectivity != ConnectivityResult.none) {
    for (String tx in queue) {
      await http.post(Uri.parse('http://10.0.2.2:8000/transactions'), body: tx);
    }
    await prefs.remove('offlineQueue');
  }
}