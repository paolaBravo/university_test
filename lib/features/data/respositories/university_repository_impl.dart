import 'package:university_test/features/data/datasource/university_data_source.dart';
import 'package:university_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/domain/repositories/university_repository.dart';

class UniversityRepositoryImpl implements UniversityRepository {
  final UniversityDataSource dataSource;

  UniversityRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<UniversityEntity>>>
      getUniversitiesInformation() async {
    try {
      final response = await dataSource.getUniversitiesInformation();
      return Right(response);
    } on Exception catch (e) {
      return Left(GeneralFailure(e.toString()));
    }
  }
}
