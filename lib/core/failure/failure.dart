class FailureApp {
  final String message;

  FailureApp(
      [this.message =
          "sorry, an unexpected error occurred. Please try again later"]);

  @override
  String toString() {
    // TODO: implement toString
    return "appFailuer $message";
  }
}
