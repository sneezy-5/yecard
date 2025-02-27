import 'dart:async';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import '../../../services/user_preference.dart';
import '../../../widgets/popup_widgets.dart';

class NotificationWidget extends StatefulWidget {
  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  IOWebSocketChannel? _channel;
  List<dynamic> notifications = [];
  bool isLoading = true;
  int unreadNotifCount = 0;
  String? token;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  void _fetchToken() async {
    token = await UserPreferences.getUserToken();
    if (mounted) {
      setState(() {
        _channel = IOWebSocketChannel.connect(
          'wss://yecard.pro/wss/notification/?token=$token',
        );
        _channel?.stream.listen(
          _handleSocketMessage,
          onError: (error) {
            print("Error fetching notifications: $error");
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onDone: () {
            print("WebSocket closed. Reconnecting...");
            _reconnectWebSocket();
          },
        );
        _fetchNotifications();
        _startGeneralNotificationService();
      });
    }
  }

  void _fetchNotifications() {
    _channel?.sink.add(
      '{"command": "get_general_notifications", "page_number": 1}',
    );
  }

  void _fetchUnreadNotificationsCount() {
    _channel?.sink.add(
      '{"command": "get_unread_general_notifications_count"}',
    );
  }

  void _startGeneralNotificationService() {
    const interval = Duration(seconds: 4);
    _timer = Timer.periodic(interval, (Timer timer) {
      _fetchUnreadNotificationsCount();
      _fetchNotifications();
    });
  }

  void _handleSocketMessage(dynamic message) {
    final response = json.decode(message);
    switch (response['general_msg_type']) {
      case 4:
        if (mounted) {
          setState(() {
            unreadNotifCount = response['count'];
          });
        }
        break;
      case 2:
      case 1:
      case 0:
        if (mounted) {
          setState(() {
            if (response['notifications'] != null && response['notifications'] is List) {
              notifications = response['notifications'];
            } else {
              notifications = [];
            }
            isLoading = false;
          });
        }
        break;
      default:
        print('Unknown message type: $response');
    }
  }

  void _reconnectWebSocket() {
    Future.delayed(Duration(seconds: 4), () {
      if (_channel?.sink != null) {
        _channel?.sink.close();
      }
      _fetchToken();
    });
  }

  void _setNotificationsAsRead() {
    _channel?.sink.add(
      '{"command": "mark_notifications_read"}',
    );
    _fetchUnreadNotificationsCount();
  }

  void _setNotificationAsOpen(int notifId) {
    _channel?.sink.add(
      '{"command": "mark_notifications_open", "notif_id": $notifId}',
    );
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
            margin: EdgeInsets.all(0),
            child: ListTile(
              leading: Image.network(notification['from']['image_url']),
              title: Text(notification['verb']),
              subtitle: Text(notification['natural_timestamp']),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _channel?.sink.close();
    super.dispose();
  }
}
