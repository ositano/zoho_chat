import 'dart:collection';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ZohoChat extends StatefulWidget {

  ///the generated widget code copied from the zoho chat script.
  final String zohoWidgetCode;

  ///color code for the preloader in hex. Default is #000000.
  final String? chatPreloaderColorHexString;

  ///Border size of the preloader. default value = 10.0.
  final double? chatPreloaderWidth;

  ///size of preloader. Default value is 120.0
  final double? chatPreloaderSize;

  ///allow you to either hide or show minimize widget on the zoho chat. Default is false
  final bool? showMinimizeChatWidget;

  const ZohoChat(
      {required this.zohoWidgetCode,
      this.chatPreloaderColorHexString = "#000000",
      this.chatPreloaderWidth = 10.0,
      this.chatPreloaderSize = 120.0,
      this.showMinimizeChatWidget = false});

  @override
  _ZohoChatState createState() {
    return _ZohoChatState(zohoWidgetCode,
        loaderColorHexString: chatPreloaderColorHexString,
        loaderWidth: chatPreloaderWidth,
        loaderSize: chatPreloaderSize,
        showMinimizeChatWidget: showMinimizeChatWidget);
  }
}

class _ZohoChatState extends State<ZohoChat> {
  final String chatWidgetCode;
  final String? loaderColorHexString;
  final double? loaderWidth;
  final double? loaderSize;
  final bool? showMinimizeChatWidget;

  _ZohoChatState(this.chatWidgetCode,
      {this.loaderColorHexString,
      this.loaderWidth,
      this.loaderSize,
      this.showMinimizeChatWidget});

  final InAppLocalhostServer localhostServer =
  new InAppLocalhostServer(port: 2021);

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          javaScriptEnabled: true,
          clearCache: true,
          preferredContentMode: UserPreferredContentMode.MOBILE,
          mediaPlaybackRequiresUserGesture: true,
      ),
      ios: IOSInAppWebViewOptions());

  bool showErrorPage = false;
  String errorMessage = '';
  bool startedServer = false;

  void init() async {
    await localhostServer.start();
    setState(() {
      startedServer = true;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    if (localhostServer.isRunning()) localhostServer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final String functionBody = """
   
    var stylesheet = document.styleSheets[1]
    stylesheet.insertRule("#siqcht { margin-top: ${showMinimizeChatWidget! ? 0.0 : -4.5}rem;}", 0);

    var loader = document.getElementsByClassName('loader')
    for(i = 0; i < loader.length; i++) {
      loader[i].style.border = '${loaderWidth}px solid #f3f3f3';
      loader[i].style.borderTop = '${loaderWidth}px solid $loaderColorHexString';
      loader[i].style.width = '${loaderSize}px';
      loader[i].style.height = '${loaderSize}px';
    }
    
    
var \$zoho = \$zoho || {};
      \$zoho.salesiq = \$zoho.salesiq || {
        widgetcode:
          "$chatWidgetCode",
        values: {},
        ready: function () {},
      };
      var d = document;
      s = d.createElement("script");
      s.type = "text/javascript";
      s.id = "zsiqscript";
      s.defer = true;
      s.src = "https://salesiq.zoho.com/widget";
      
      var t = d.getElementsByTagName("script")[0];
      t.parentNode.insertBefore(s, t);
      //d.write("<div id='zsiqwidget'></div>");
      //
      \$zoho.salesiq.afterReady = function (visitorgeoinfo) {
        \$zoho.salesiq.floatwindow.visible("1");
        setTimeout(function(){ 
          loader[0].style.display = 'none';
        }, 10000); //hide preloader after 10secs
        
      };
""";

    return Container(
        child: Stack(
      children: <Widget>[
        Column(children: <Widget>[
          startedServer
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: InAppWebView(
                    key: webViewKey,
                    initialOptions: options,
                    initialUrlRequest: URLRequest(
                        url: Platform.isAndroid
                            ? Uri.parse(
                                "http://localhost:2021/packages/zoho_chat/assets/index.html")
                            : Uri.parse(
                                "http://localhost:2021/packages/zoho_chat/assets/index2.html")),
                    initialUserScripts: UnmodifiableListView<UserScript>([
                      UserScript(
                          source: functionBody,
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_START,
                          iosForMainFrameOnly: true),
                    ]),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (controller, url) {},
                    onLoadStop: (controller, url) async {},
                    onLoadError: (controller, url, code, message) async {
                      showError(message);
                    },
                    onConsoleMessage: (controller, message) {
                      //print("console message: $message");
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator())
        ]),
        showErrorPage
            ? Center(
                child: Text("$errorMessage"),
              )
            : Container(),
      ],
    ));
  }

  void showError(String error) {
    setState(() {
      errorMessage = error;
      showErrorPage = true;
    });
  }

  void hideError() {
    setState(() {
      errorMessage = '';
      showErrorPage = false;
    });
  }

  void reload() {
    webViewController?.reload();
  }
}
