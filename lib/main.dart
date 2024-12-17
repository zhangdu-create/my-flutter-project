import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _scrollOffset = 0.0;
  void _incrementCounter() async {
    String message = "https://www.baidu.com/abc/dsfddfdfgd/fffffffffff?id=9";
    String key = Platform.isAndroid ? "?" : "&";
    // // final Uri smsUri = Uri.parse('sms:${key}body=$message');
    var encodeComponent = Uri.encodeComponent(message);
    String smsUri = 'sms:${key}body=$encodeComponent';
    // String thsss="https://www.facebook.com/groups/saigondiningguide/";
    var bool = await canLaunchUrlString(smsUri);
    if (bool) {
      await launchUrl(Uri.parse(smsUri));
    } else {
      debugPrint("----无法启动--");
    }
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });

    // List<String> dateList=[];
    // await initializeDateFormatting('zh_CN',null);
    // var now = DateTime.now();
    // var dateFormat = DateFormat('EE,M-d,y','zh_CN');
    // for(int i=0;i<8;i++){
    //   var add = now.add(Duration(days: i));
    //   var format = dateFormat.format(add);
    //   if(i==0){
    //     var split = format.split(",");
    //     format=format.replaceAll(split.first, "今天");
    //   }
    //   if(i==1){
    //     var split = format.split(",");
    //     format=format.replaceAll(split.first, "明天");
    //   }
    //   dateList.add(format);
    // }
    //
    // debugPrint("日期-----${dateList}");
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification.metrics.axis == Axis.vertical) {
            setState(() {
              _scrollOffset = notification.metrics.pixels;
            });
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0, // 展开高度
              pinned: true, // 悬浮在顶部
              backgroundColor: _getAppBarBackgroundColor(), // 动态背景颜色
              flexibleSpace: FlexibleSpaceBar(
                title: Text("SliverAppBar 悬浮背景颜色"),
                background: Image.network(
                  "https://via.placeholder.com/400x200",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
                childCount: 50,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // 动态设置 AppBar 的背景颜色
  Color _getAppBarBackgroundColor() {
    // 设置滚动范围，控制颜色变化的渐变
    double opacity = (_scrollOffset / 100).clamp(0.0, 1.0); // 透明度在 0 到 1 之间
    return Color.lerp(Colors.transparent, Colors.blue, opacity)!;
  }

}
