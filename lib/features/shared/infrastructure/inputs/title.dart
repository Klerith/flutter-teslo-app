import 'package:formz/formz.dart';

// Define input validation errors
enum TitleError { empty }

// Extend FormzInput and provide the input type and error type.
class Title extends FormzInput<String, TitleError> {


  // Call super.pure to represent an unmodified form input.
  const Title.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Title.dirty( String value ) : super.dirty(value);



  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == TitleError.empty ) return 'El campo es requerido';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TitleError? validator(String value) {
    
    if ( value.isEmpty || value.trim().isEmpty ) return TitleError.empty;

    return null;
  }
}