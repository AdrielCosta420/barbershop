import 'dart:developer';

import 'package:flutter/material.dart';

class BarbershopRegisterPage extends StatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  State<BarbershopRegisterPage> createState() => _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState extends State<BarbershopRegisterPage> {
  @override
  void initState() {
        log('chegou na pagina de barbearia');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    log('chegou na pagina de barbearia');
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
