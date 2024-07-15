abstract class BaseUseCase<Type, Params> {
  Future<Type> call({required Params data});
}


// abstract class BaseUseCase<In, Out> {
//   Future<Either<Failure, Out>> execute(In input);
// }