abstract class LoginStates{}

class InitialState extends LoginStates{}

class ChangeVisibility extends LoginStates{}

class LoadingLogin extends LoginStates{}
class SuccessLogin extends LoginStates{}
class ErrorLogin extends LoginStates{}

class LoadingForgotPassword extends LoginStates{}
class SuccessForgotPassword extends LoginStates{}
class ErrorForgotPassword extends LoginStates{}
