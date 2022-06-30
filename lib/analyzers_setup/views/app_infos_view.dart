import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../global/utilities/theme.dart';

class AppInfosView extends StatelessWidget {
  const AppInfosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: PageView(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                    child: Column(
                      children: [
                        Text("Bienvenue sur l'application SoulPot ! "),
                        Text(
                            "Cette application vous permet de communiquer avec votre (ou vos) Analyzers, pour connaitre l'état de votre plante"),
                        Text(
                            "Dans ce guide, on parlera d'un seul Analyzer, mais l'application est utilisable avec jusqu'à 5 Analyzers."),
                        Text(
                            "Cette application n'a pas lieu d'être sans un Analyzer, elle ne vous servirait à rien."),
                        Text(
                            "La première étape est l'apairage de votre Analyzer :"),
                        Text(
                            "Pour cela, assurez vous que votre bluetooth ainsi que votre Wifi sont activés. Sélectionnez ensuite l'Analyzer que vous souhaitez apairer"),
                        Text(
                            "Appuyez sur le bouton d'appairage, puis une fois le chargement fini, sélectionnez le réseau wifi sur lequel vous voulez connecter votre Analyzer (l'Analyzer a besoin d'une connexion internet pour pouvoir vous remonter régulièrement les informations de votre plante)"),
                        Text(
                            "Sélectionner ensuite la plante correspondant à l'Analyzer dans la liste disponible."),
                        Text(
                            "Vous pouvez maintenant créer un compte sur l'application ou vous connecter si vous en avez déjà un."),
                        Text("Tips : Vous pouvez renommer votre Analyzer pour l'identifier plus facilement, comme avec le nom de votre plante ou la pièce dans laquelle il se trouve !"),
                        Text("Le paramétrage est terminé !"),
                        ],
                    ),
                  ),
                  Column(
                    children: [
                      Text("Infos sur les stats"),
                      Text(
                          "Le principe d'un Analyzer est simple, une fois que vous lui avez indiqué une plante, vous avez une page qui regroupe les informations de votre plante ainsi que si elles respectent ces recommandations."),
                      Text("Image d'une page Analyzer"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Paramètres Analyzers"),
                      Text("A tout moment, vous pouvez intervenir sur le paramétrage de vos Analyzers, par exemple si vous souhaitez changer le wifi sur lequel il est connecté, ou encore si vous souhaitez changer de plante"),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Infos supp"),
                      Text("Vous avez un Codex à disposition avec de nombreuses informations sur votre plante, mais aussi sur toutes les plantes disponibles dans l'application"),
                      Text("De plus, vous trouverez des objectifs à accomplir afin de rendre plus ludique la vie de votre plante !"),
                    ],
                  ),
                ],
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    color: SoulPotTheme.spGreen,
                    size: 10.w,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
