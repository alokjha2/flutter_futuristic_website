import 'package:flutter/material.dart';

class CodeSnippetComponent extends StatefulWidget {
  @override
  _CodeSnippetComponentState createState() => _CodeSnippetComponentState();
}

class _CodeSnippetComponentState extends State<CodeSnippetComponent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for code snippets
  final Map<String, String> codeSnippets = {
    "Python": """
import requests

def get_data(api_url):
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.json()
    return None
""",
    "Node.js": """
const axios = require('axios');

async function getData(apiUrl) {
    try {
        const response = await axios.get(apiUrl);
        return response.data;
    } catch (error) {
        console.error(error);
    }
}
""",
    "Flutter": """
import 'package:http/http.dart' as http;

Future<void> getData(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
        print(response.body);
    } else {
        print('Failed to load data');
    }
}
"""
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: codeSnippets.keys.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      
      child: Column(
        children: [
          TabBar(
          controller: _tabController,
          tabs: codeSnippets.keys
              .map((language) => GestureDetector(
                onTap: (){},
                child: Tab(text: language)))
              .toList(),
        ),
          TabBarView(
            controller: _tabController,
            children: codeSnippets.entries.map((entry) {
              return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: SelectableText(
                  entry.value,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14.0,
                    color: Colors.black87,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}