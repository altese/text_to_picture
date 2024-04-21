import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_to_picture_app/home/data/data_sources/texfie_data_source.dart';
import 'package:text_to_picture_app/home/domain/repositories/texfie_repository.dart';

final texfieLocalDataSource = Provider((ref) {
  return TexFieLocalDataSource();
});

final texFieLocalRepository = Provider((ref) {
  final dataSource = ref.watch(texfieLocalDataSource);

  return TexFieLocalRepository(dataSource: dataSource);
});
