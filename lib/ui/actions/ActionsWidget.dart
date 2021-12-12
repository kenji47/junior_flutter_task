// ignore: file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:junior_test/blocs/actions/ActionsQueryBloc.dart';
import 'package:junior_test/blocs/base/bloc_provider.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/model/actions/PromoItem.dart';
import 'package:junior_test/resources/api/RootType.dart';
import 'package:junior_test/resources/api/mall_api_provider.dart';
import 'package:junior_test/tools/Strings.dart';
import 'package:junior_test/tools/Tools.dart';
import 'package:junior_test/ui/actions/ActionCardWidget.dart';
import 'package:junior_test/ui/actions/item/ActionsItemArguments.dart';
import 'package:junior_test/ui/actions/item/ActionsItemWidget.dart';
import 'package:junior_test/ui/base/NewBasePageState.dart';

class ActionsWidget extends StatefulWidget {
  @override
  State<ActionsWidget> createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends NewBasePageState<ActionsWidget> {
  ActionsQueryBloc bloc;

  int currentPage = 1;
  int itemsOnPage = 4;
  int pagesTotal;
  int itemsTotal;
  bool isLoading = false;

  List<PromoItem> actionListInfo = [];

  _ActionsWidgetState() {
    print('ActionsWidget Constructor');
    bloc = ActionsQueryBloc();
  }

  void runOnWidgetInit() {
    print('ActionsWidget runOnWidgetInit');
    //initial loading
    if (!isLoading) {
      print('start loading');
      bloc.loadActions(currentPage, itemsOnPage);
      isLoading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('ActionsWidget build');
    return BlocProvider<ActionsQueryBloc>(
        bloc: bloc, child: getBaseQueryStream(bloc.shopListContentStream));
  }

  @override
  Widget onSuccess(RootTypes event, RootResponse response) {
    print('ActionsWidget onSuccess');

    var actionPageInfo = response.serverResponse.body.promo.page;
    actionListInfo.addAll(response.serverResponse.body.promo.list);
    pagesTotal = actionPageInfo.totalPageCount;
    isLoading = false;

    return getNetworkAppBar(null, _getBody(), Strings.actions,
        brightness: Brightness.light);
  }

  Widget _getBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (currentPage == pagesTotal) return;
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                bloc.loadActions(++currentPage, itemsOnPage);
                isLoading = true;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: StaggeredGridView.builder(
                itemCount: currentPage == pagesTotal
                    ? actionListInfo.length
                    : actionListInfo.length + 1,
                gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                  staggeredTileCount: currentPage == pagesTotal
                      ? actionListInfo.length
                      : actionListInfo.length + 1,
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                  },
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (BuildContext context, int index) =>
                index >= actionListInfo.length
                    ? Center(
                  child: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(strokeWidth: 1.5),
                  ),
                )
                    : ActionCardWIdget(
                  id: actionListInfo[index].id,
                  name: actionListInfo[index].name,
                  shop: actionListInfo[index].shop,
                  thumbnailUrl: actionListInfo[index].imgThumb,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => ActionsItemWidget(),
                          settings: RouteSettings(
                            arguments: ActionsItemArguments(
                                actionListInfo[index].id),
                          )),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
