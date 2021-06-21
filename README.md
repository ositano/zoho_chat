# zoho_chat

A flutter implementation of Zoho SaleIQ Live Chat Implementation. You need zoho salesiq widget code to use this plugin

## Getting Started
copy the widget code (a bunch of hexa decimal value) from the generated code gotten from zoho salesiq dashboard

This plugin is depended on [InappWebView!](https://pub.dev/packages/flutter_inappwebview) so you'll need to set the necessary permissions 

For Android, in your Manifest.xml add :
```
<uses-permission android:name="android.permission.INTERNET"/>
```

```
<application
        android:label="zoho_chat_example"
        android:icon="@mipmap/ic_launcher"
        android:usesCleartextTraffic="true"> //add this line
```



For iOS, in your Info.plist add:

```
<key>NSAppTransportSecurity</key>
    <dict>
      <key>NSAllowsArbitraryLoads</key>
      <true/>
      <key>NSAllowsArbitraryLoadsInWebContent</key>
      <true/>
    </dict>
    <key>NSAllowsLocalNetworking</key>
    <true/>
    <key>NSAllowsArbitraryLoadsInWebContent</key>
    <true/>
```


From the zoho salesiq live chat code
```
      var $zoho = $zoho || {};
      $zoho.salesiq = $zoho.salesiq || {
        widgetcode:
          "xxxxx",
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
      d.write("<div id='zsiqwidget'></div>");
```
Assuming the widget code here is ** xxxxx **, copy it and use zoho chat this way

```
        ZohoChat(
          zohoWidgetCode: "xxxxx", //zoho salesiq chat widget code
          chatPreloaderSize: 100.0, //preloader size
          chatPreloaderWidth: 3, //preloader border size
          chatPreloaderColorHexString: "#2196f3", //preloader color code
          showMinimizeChatWidget: true, //either to show or hide the minimize widget
        )

```