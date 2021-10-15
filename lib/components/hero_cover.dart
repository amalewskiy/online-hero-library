import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:library_online/components/on_hover_button.dart';

class ExampleHero {
  late String name;
  late String birthYear;
  late String gender;
  late String eyeColor;
  late String skinColor;
  late String height;

  ExampleHero.fromList(Map<String, dynamic> heroes) {
    name = heroes['name'];
    birthYear = heroes['birth_year'];
    gender = heroes['gender'];
    eyeColor = heroes['eye_color'];
    skinColor = heroes['skin_color'];
    height = heroes['height'];
  }

  Widget _getText(String characteristics, String key) {
    return RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 15),
            children: <TextSpan>[
              TextSpan(
                  text: '$characteristics: ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: key)
            ]));
  }

  Widget getHeroCard(BuildContext context) {
    return OnHoverButton(
      child: GestureDetector(
        onTap: () {
          AwesomeDialog(
            context: context,
            width: MediaQuery.of(context).size.width * 0.25,
            dialogType: DialogType.INFO,
            animType: AnimType.BOTTOMSLIDE,
            title: name,
            desc:
                'Birth Year: $birthYear\nGender: $gender\nEye Color: $eyeColor',
            btnOkOnPress: () {},
          ).show();
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: const Color(0xfff1faee),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getText('Name', name),
              _getText('Birth Year', birthYear),
              _getText('Gender', gender),
              _getText('Eye color', eyeColor),
              _getText('Skin color', skinColor),
              _getText('Height', height)
            ],
          ),
        ),
      ),
    );
  }
}
