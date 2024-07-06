abstract class BaseUseCase<Type, Params> {
  Future<Type> call({Params params});
}


// abstract class BaseUseCase<In, Out> {
//   Future<Either<Failure, Out>> execute(In input);
// }