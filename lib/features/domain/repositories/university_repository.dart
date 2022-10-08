import 'package:university_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';

abstract class UniversityRepository {
  Future<Either<Failure, List<UniversityEntity>>> getUniversitiesInformation();
}
