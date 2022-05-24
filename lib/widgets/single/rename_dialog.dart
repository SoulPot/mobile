import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soulpot/theme.dart';

import '../../models/Analyzer.dart';

class RenameDialog extends StatefulWidget {
  const RenameDialog({Key? key, required Analyzer analyzer})
      : _analyzer = analyzer,
        super(key: key);

  final Analyzer _analyzer;
  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  TextEditingController _analyzerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                'Comment souhaitez-vous renommer ${widget._analyzer.name} ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: SoulPotTheme.SPBlack,
                    fontSize: 20,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _analyzerNameController,
                decoration: InputDecoration(
                  hintText: widget._analyzer.name,
                  hintStyle: TextStyle(
                    color: SoulPotTheme.SPBlack,
                    fontSize: 18,
                    fontFamily: 'Greenhouse',
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                style: TextStyle(
                  color: SoulPotTheme.SPBlack,
                  fontSize: 18,
                  fontFamily: 'Greenhouse',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Annuler",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: SoulPotTheme.SPBlack),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.SPPaleRed,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if(_analyzerNameController.text.isNotEmpty) {
                        widget._analyzer.name = _analyzerNameController.text;
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Valider",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: SoulPotTheme.SPBlack),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: SoulPotTheme.SPPaleGreen,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      textStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
