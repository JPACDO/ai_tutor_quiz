abstract class BaseUseCase<Type, Params> {
  Future<Type> call({Params prompt});
}


// abstract class BaseUseCase<In, Out> {
//   Future<Either<Failure, Out>> execute(In input);
// }