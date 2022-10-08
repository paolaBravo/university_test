// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// KiwiInjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  @override
  void _configureUniversitiesFactories() {
    final KiwiContainer container = KiwiContainer();
    container
      ..registerFactory<UniversityRepository>((c) =>
          UniversityRepositoryImpl(dataSource: c<UniversityDataSource>()))
      ..registerFactory((c) =>
          GetUniversitiesInformation(repository: c<UniversityRepository>()))
      ..registerFactory<UniversityDataSource>(
          (c) => UniversityDataSourceImpl());
  }
}
