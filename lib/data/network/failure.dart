class Failure {
  int code; //! 200,201,400,401 ,500 and so on ...
  String message; //! error message
  Failure(this.code, this.message);
}
