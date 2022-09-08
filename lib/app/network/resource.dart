/// this class is to be used only where it is required
/// to show offline-first data
abstract class Resource<T> {
  final T? data;
  final String? error;

  Resource({this.data, this.error});
}

class Loaded<T> extends Resource<T> {
  final T data;

  Loaded({required this.data}) : super(data: data);
}

class Failure<T> extends Resource<T> {
  final T? data;
  final String error;

  Failure({required this.error, this.data}) : super(data: data, error: error);
}