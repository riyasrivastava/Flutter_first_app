abstract class SignInEvent{
}
class SignInSubmitEvent extends SignInEvent{
  final String email;
  final String password;
  SignInSubmitEvent(this.email,this.password);
}