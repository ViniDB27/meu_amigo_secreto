abstract class IAccountDatasource {
  Future<Map> login({
    required String email,
    required String password,
  });
}
