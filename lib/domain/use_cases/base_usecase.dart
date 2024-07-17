/// Abstract class that represents a use case.
///
/// This class is the base class for all use cases. It defines the common
/// interface for all use cases.
///
/// This class is designed to be extended by concrete use cases. Each
/// concrete use case must provide the implementation for the [call]
/// method.
///
/// The [call] method takes a [Params] object as input and returns a
/// [Future] that completes with a [Type] object.
///
/// The [Params] object represents the input parameters for the use case.
/// The [Type] object represents the output of the use case.
abstract class BaseUseCase<Type, Params> {
  /// Calls the use case with the given [data].
  ///
  /// This method takes a [Params] object as input and returns a
  /// [Future] that completes with a [Type] object.
  Future<Type> call({required Params data});
}


// abstract class BaseUseCase<In, Out> {
//   Future<Either<Failure, Out>> execute(In input);
// }