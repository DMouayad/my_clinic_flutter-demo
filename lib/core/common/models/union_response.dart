// abstract class CustomResponse<T> {
//   const CustomResponse();
//   factory CustomResponse.noResultSuccess() = NoResultSuccessResponse;
//   factory CustomResponse.successWithResult(T result) =
//       SuccessWithResultResponse;
//   factory CustomResponse.failure() = FailureResponse;

//   void when({
//     required void Function(NoResultSuccessResponse) noResultSuccess,
//     required void Function(SuccessWithResultResponse) successWithResult,
//     required void Function(FailureResponse) failure,
//   }) {
//     if (this is NoResultSuccessResponse) {
//       noResultSuccess.call(this as NoResultSuccessResponse);
//     }

//     if (this is SuccessWithResultResponse) {
//       successWithResult.call(this as SuccessWithResultResponse);
//     }

//     if (this is FailureResponse) {
//       failure.call(this as FailureResponse);
//     }

//     noResultSuccess.call(this as NoResultSuccessResponse);
//   }

//   R map<R>({
//     required R Function(NoResultSuccessResponse) noResultSuccess,
//     required R Function(SuccessWithResultResponse) successWithResult,
//     required R Function(FailureResponse) failure,
//   }) {
//     if (this is NoResultSuccessResponse) {
//       return noResultSuccess.call(this as NoResultSuccessResponse);
//     }

//     if (this is SuccessWithResultResponse) {
//       return successWithResult.call(this as SuccessWithResultResponse);
//     }

//     if (this is FailureResponse) {
//       return failure.call(this as FailureResponse);
//     }

//     return noResultSuccess.call(this as NoResultSuccessResponse);
//   }

//   void maybeWhen({
//     void Function(NoResultSuccessResponse)? noResultSuccess,
//     void Function(SuccessWithResultResponse)? successWithResult,
//     void Function(FailureResponse)? failure,
//     required void Function() orElse,
//   }) {
//     if (this is NoResultSuccessResponse && noResultSuccess != null) {
//       noResultSuccess.call(this as NoResultSuccessResponse);
//     }

//     if (this is SuccessWithResultResponse && successWithResult != null) {
//       successWithResult.call(this as SuccessWithResultResponse);
//     }

//     if (this is FailureResponse && failure != null) {
//       failure.call(this as FailureResponse);
//     }

//     orElse.call();
//   }

//   R maybeMap<R>({
//     R Function(NoResultSuccessResponse)? noResultSuccess,
//     R Function(SuccessWithResultResponse)? successWithResult,
//     R Function(FailureResponse)? failure,
//     required R Function() orElse,
//   }) {
//     if (this is NoResultSuccessResponse && noResultSuccess != null) {
//       return noResultSuccess.call(this as NoResultSuccessResponse);
//     }

//     if (this is SuccessWithResultResponse && successWithResult != null) {
//       return successWithResult.call(this as SuccessWithResultResponse);
//     }

//     if (this is FailureResponse && failure != null) {
//       return failure.call(this as FailureResponse);
//     }

//     return orElse.call();
//   }

//   factory CustomResponse.fromString(String value) {
//     if (value == 'noResultSuccess') {
//       return CustomResponse.noResultSuccess();
//     }

//     if (value == 'failure') {
//       return CustomResponse.failure();
//     }

//     return CustomResponse.noResultSuccess();
//   }

//   @override
//   String toString() {
//     if (this is NoResultSuccessResponse) {
//       return 'noResultSuccess';
//     }

//     if (this is SuccessWithResultResponse) {
//       return 'successWithResult';
//     }

//     if (this is FailureResponse) {
//       return 'failure';
//     }

//     return 'noResultSuccess';
//   }
// }

// class NoResultSuccessResponse<NoResults> extends CustomResponse<T> {}

// class SuccessWithResultResponse<T> extends CustomResponse<T> {
//   final T result;

//   SuccessWithResultResponse(this.result);
// }

// class FailureResponse<T> extends CustomResponse<T> {}
