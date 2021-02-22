import 'package:fonibo/back/fonibo_api.dart';
import 'package:fonibo/get_it/locator.dart';
import 'package:fonibo/models/Fonibo.dart';

class FoniboRepository {
  FoniboApi api = locator<FoniboApi>();
  Future<List<Fonibo>> getData() async {
    return await api.getData();
  }
}
