import 'package:flutter/material.dart';

class CodexView extends StatefulWidget {
  const CodexView({Key? key}) : super(key: key);

  @override
  State<CodexView> createState() => _CodexViewState();
}

class _CodexViewState extends State<CodexView> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Text(
                "Informations get by analyzer"
            )
        )

    );
  }

}