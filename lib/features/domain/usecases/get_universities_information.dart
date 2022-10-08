import 'package:university_test/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university_test/core/utility/usecase.dart';
import 'package:university_test/features/domain/entities/university_entity.dart';
import 'package:university_test/features/domain/repositories/university_repository.dart';

class GetUniversitiesInformation implements UseCase<List<UniversityEntity>> {
  final UniversityRepository repository;

  GetUniversitiesInformation({required this.repository});

  @override
  Future<Either<Failure, List<UniversityEntity>>> call() {
    return repository.getUniversitiesInformation();
  }
}
