/*
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:web_socket_channel/io.dart';

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  final _channel = IOWebSocketChannel.connect('wss://your-websocket-url');
  List<String> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  void _fetchNotifications() {
    _channel.stream.listen((data) {
      setState(() {
        notifications.add(data);
        isLoading = false;
      });
    }, onError: (error) {
      print("Error fetching notifications: $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          Badge(
            badgeContent: Text(
              notifications.length.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(notifications[index]),
              leading: Icon(Icons.notification_important),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

void main() => runApp(MaterialApp(
  home: NotificationWidget(),
));
*/
