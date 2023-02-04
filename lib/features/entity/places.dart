import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_esting_task/assets/colors/colors.dart';

/// описание места
class Place {
  final String title;

  Place(this.title);

  Widget getListTile(){
    return Text(title);
  }
}

/// описание места с строковом лидингом
class StringLeadingPlaces extends Place {
  @override
  String title;

  List<String> leading;

  StringLeadingPlaces(
    this.title,
    this.leading,
  ) : super('');

  @override
  Widget getListTile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 132,
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (final text in leading)
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Montserrat',
                    color: ProjectColors.mainDark,
                  ),
                ),
            ],
            // crossAxisAlignment: WrapCrossAlignment.start,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Montserrat',
              color: ProjectColors.mainDark,
            ),
          ),
        ),
        const SizedBox(
          width: 100,
        ),
      ],
    );
  }
}

/// описание места с иконочным лидингом
class ImageLeadingPlaces extends Place {
  @override
  String title;

  List<String> leading;

  ImageLeadingPlaces(
    this.title,
    this.leading,
  ) : super('');

  @override
  Widget getListTile() {
    return Row(
      children: [
        SizedBox(
          width: 132,
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              for (final text in leading) SvgPicture.asset(text),
            ],
            // crossAxisAlignment: WrapCrossAlignment.start,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded (
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Montserrat',
              color: ProjectColors.mainDark,
            ),
          ),
        ),
        const SizedBox(
          width: 139,
        ),
      ],
    );
  }
}
