import 'package:hive/hive.dart';
import 'package:text_to_picture_app/common/model/texfie.dart';

abstract class TexFieDataSource {
  Future<void> add(TexFie texFie);
}

class TexFieLocalDataSource extends TexFieDataSource {
  final Box<TexFie> box = Hive.box<TexFie>('texfie');

  @override
  Future<void> add(TexFie texFie) async {
    await box.add(texFie);
  }
}
