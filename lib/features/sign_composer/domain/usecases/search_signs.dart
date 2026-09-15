import '../entities/sign_asset.dart';
import '../repositories/sign_repository.dart';

class SearchSigns {
  const SearchSigns(this._repository);

  final SignRepository _repository;

  Future<List<SignAsset>> call(String query) => _repository.searchSigns(query);
}
