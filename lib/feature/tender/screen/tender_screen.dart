import 'package:flutter/material.dart';

class TenderScreen extends StatefulWidget {
  const TenderScreen({super.key});

  @override
  State<TenderScreen> createState() => _TenderScreenState();
}

class _TenderScreenState extends State<TenderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tender'),
    );
  }
}
