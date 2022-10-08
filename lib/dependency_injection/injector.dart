import 'package:kiwi/kiwi.dart';
import 'package:university_test/features/data/datasource/university_data_source.dart';
import 'package:university_test/features/data/respositories/university_repository_impl.dart';
import 'package:university_test/features/domain/repositories/university_repository.dart';
import 'package:university_test/features/domain/usecases/get_universities_information.dart';
part 'injector.g.dart';

abstract class Injector {
  static KiwiContainer container = KiwiContainer();
  static void setup() {
    //  final KiwiContainer container = KiwiContainer();
    var injector = _$Injector();
    injector._configure();
  }

  static final resolve = container.resolve;

  void _configure() {
    _configureUniversitiesModule();
  }

  void _configureUniversitiesModule() {
    _configureUniversitiesFactories();
  }

  @Register.factory(UniversityRepository, from: UniversityRepositoryImpl)
  @Register.factory(GetUniversitiesInformation)
  @Register.factory(UniversityDataSource, from: UniversityDataSourceImpl)
  void _configureUniversitiesFactories();
}
