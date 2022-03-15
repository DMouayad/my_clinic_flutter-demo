abstract class CustomResponse<T> {
  const CustomResponse();
  factory CustomResponse.success({T? result}) = SuccessCustomResponse;

  void when({
    required void Function(SuccessCustomResponse) success,
  }) {
    if (this is SuccessCustomResponse) {
      success.call(this as SuccessCustomResponse);
    }

    success.call(this as SuccessCustomResponse);
  }

  R map<R>({
    required R Function(SuccessCustomResponse) success,
  }) {
    if (this is SuccessCustomResponse) {
      return success.call(this as SuccessCustomResponse);
    }

    return success.call(this as SuccessCustomResponse);
  }

  void maybeWhen({
    void Function(SuccessCustomResponse)? success,
    required void Function() orElse,
  }) {
    if (this is SuccessCustomResponse && success != null) {
      success.call(this as SuccessCustomResponse);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(SuccessCustomResponse)? success,
    required R Function() orElse,
  }) {
    if (this is SuccessCustomResponse && success != null) {
      return success.call(this as SuccessCustomResponse);
    }

    return orElse.call();
  }

  factory CustomResponse.fromString(String value) {
    if (value == 'success') {
      return CustomResponse.success();
    }

    return CustomResponse.success();
  }

  @override
  String toString() {
    if (this is SuccessCustomResponse) {
      return 'success';
    }

    return 'success';
  }
}

class SuccessCustomResponse<T> extends CustomResponse<T> {
  final T? result;

  SuccessCustomResponse({this.result});
}
