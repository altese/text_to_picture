import 'package:text_to_picture_app/common/model/texfie.dart';
import 'package:text_to_picture_app/home/data/data_sources/texfie_data_source.dart';

abstract class TexFieRepository {
  Future<void> add(TexFie texFie);
}

class TexFieLocalRepository extends TexFieRepository {
  final TexFieDataSource dataSource;

  TexFieLocalRepository({required this.dataSource});
  @override
  Future<void> add(TexFie texFie) async {
    await dataSource.add(texFie);
  }
}
