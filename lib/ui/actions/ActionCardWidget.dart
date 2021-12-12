import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/resources/api/mall_api_provider.dart';
import 'package:junior_test/tools/MyColors.dart';
import 'package:junior_test/tools/MyDimens.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';

class ActionCardWIdget extends StatelessWidget {
  final String name;
  final String shop;
  final String thumbnailUrl;
  final int id;
  final VoidCallback onTap;

  const ActionCardWIdget(
      {@required this.id,
        @required this.name,
        @required this.shop,
        @required this.thumbnailUrl,
        @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: GridTile(
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: <Widget>[
              Image.network(
                '${MallApiProvider.baseImageUrl}$thumbnailUrl',
                fit: BoxFit.cover,
                //height: 200,
              ),
              Positioned(
                left: 15,
                right: 15,
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: MyDimens.titleBig, color: MyColors.white,),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Text(
                  shop,
                  style: TextStyle(
                      fontSize: MyDimens.titleSmall, color: MyColors.white),
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
