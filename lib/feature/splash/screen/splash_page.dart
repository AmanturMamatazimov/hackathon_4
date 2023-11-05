import 'package:flutter/material.dart';

import '../../tender/bloc/tender_stream.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async{
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const TenderStream()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF051D40),
      body: Center(
        child: Image.asset('assets/img/logo.png',height: 228,width: 228,),
      ),
    );
  }
}
