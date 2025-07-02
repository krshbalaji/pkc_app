import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForUpdate();
    });
  }

  Future<void> _checkForUpdate() async {
    try final response = await http.get(Uri.parse(
  'https://krshbalaji.github.io/pkc_app/version.json'));

if (response.statusCode == 200) {
  final versionData = json.decode(response.body);
  final latestVersion = versionData['version'];
  final apkUrl = versionData['apk_url'];
  // Check version and show update prompt
} catch (e) {
      debugPrint('Version check failed: $e');
    }
  }

  void _showUpdateDialog(String ver, String change, String apkUrl) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Update Available'),
        content: Text('Version $ver is available.\n\n$change'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Later')),
          ElevatedButton(onPressed: () {
            Navigator.pop(c);
            launchUrl(Uri.parse(apkUrl), mode: LaunchMode.externalApplication);
          }, child: const Text('Update Now')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Welcome to PKC App – Build 7 ✅',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

