import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class RSS_Page2 extends StatefulWidget {
  final url;
  const RSS_Page2(this.url);
  @override
  createState() => _RSS_Page2State(this.url);
}
class _RSS_Page2State extends State<RSS_Page2> {
  var _url;
  final _key = UniqueKey();
  _RSS_Page2State(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Doc bao"),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: _url)
            )
          ],
        ),
    );
  }
}
