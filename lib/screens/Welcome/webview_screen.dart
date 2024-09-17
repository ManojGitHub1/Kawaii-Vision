// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {

  final url;
  WebviewScreen(this.url);

  @override
  State<WebviewScreen> createState() => _WebviewScreenState(this.url);
}

class _WebviewScreenState extends State<WebviewScreen> {

  var _url;
  late final WebViewController _controller;
  final _key = UniqueKey();

  _WebviewScreenState(this._url);

  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _controller.runJavaScript(
                _isDarkTheme
                    ? "document.body.style.backgroundColor = 'black'; document.body.style.color = 'white';"
                    : "document.body.style.backgroundColor = 'white'; document.body.style.color = 'black';"
            );
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${_url}'));

    _controller = controller;
  }

  bool _isDarkTheme = false;
  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
      _controller.runJavaScript(
          _isDarkTheme
              ? "document.body.style.backgroundColor = 'black'; document.body.style.color = 'white';"
              : "document.body.style.backgroundColor = 'white'; document.body.style.color = 'black';"
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkTheme ? ThemeData.dark(): ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Know More!'),),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context); // This will take the user back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: Icon(_isDarkTheme ? Icons.dark_mode : Icons.light_mode),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: _controller,
                key: _key,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
