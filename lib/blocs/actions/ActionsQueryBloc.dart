import 'package:junior_test/blocs/base/BaseBloc.dart';
import 'package:junior_test/model/RootResponse.dart';
import 'package:junior_test/resources/api/repository.dart';
import 'package:rxdart/rxdart.dart';

class ActionsQueryBloc extends BaseBloc {
  final _controller = BehaviorSubject<RootResponse>();
  final _client = Repository();

  Stream<RootResponse> get shopListContentStream => _controller.stream;

  void loadActions(int page, int itemsOnPage) async {
    final results = await _client.fetchActions(page, itemsOnPage);
    addResultToController(_controller, results);
  }

  @override
  void dispose() {
    _controller.close();
  }

  BehaviorSubject<Object> getController() {
    return _controller;
  }
}