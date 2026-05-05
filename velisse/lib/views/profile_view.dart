import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Text('Aquí va el contenido del perfil'),
      ),
    );
  }
}