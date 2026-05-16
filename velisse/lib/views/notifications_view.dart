import 'package:flutter/material.dart';

class NotificationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones'),
      ),
      body: Center(
        child: Text('Aquí va el contenido de las notificaciones'),
      ),
    );
  }
}