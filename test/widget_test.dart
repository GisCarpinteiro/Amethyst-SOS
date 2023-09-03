// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vistas_amatista/custom_widgets/labeled_textbox_custom.dart';
import 'package:vistas_amatista/screens/triggers/trigger_tests.dart';

void main() {

  // ---------------------- PASSWORD UNIT TESTS -------------------------------
  test('Rechazo de contraseñas con menos de 8 caractéres', (){
    const textBoxCustomWidget = LabeledTextBoxCustomWidget(label: "test");

    var testResult = textBoxCustomWidget.passwordValidation("passwd1");
  
    expect (testResult, 'Debe tener mínimo 8 caracteres!');
    
  });

  test('Rechazo de contraseñas vacías', (){
    const textBoxCustomWidget = LabeledTextBoxCustomWidget(label: "test");

    var testResult = textBoxCustomWidget.passwordValidation("");
    
    expect (testResult, 'Defina una contraseña!');
  });

  test('Rechazo de contraseñas con espacios', (){
    const textBoxCustomWidget = LabeledTextBoxCustomWidget(label: "test");

    var testResult = textBoxCustomWidget.passwordValidation("Hello World1!");
    
    expect (testResult, 'No debe incluir espacios!');
  });

  test('Rechazo de contraseñas sin al menos un número', (){
    const textBoxCustomWidget = LabeledTextBoxCustomWidget(label: "test");

    var testResult = textBoxCustomWidget.passwordValidation("MyPassword");
    
    expect (testResult, 'Debe tener al menos un número!');
  });

  test('Rechazo de contraseñas sin al menos una letra', (){
    const textBoxCustomWidget = LabeledTextBoxCustomWidget(label: "test");

    var testResult = textBoxCustomWidget.passwordValidation("12345678");
    
    expect (testResult, 'Debe tener al menos una letra!');
  });

  // testWidgets("An Internet Connection Hasn't Been Detected Message", (widgetTester) async{
    
  //   await widgetTester.pumpWidget(const TriggerTestScreen());
    
  //   // Crea nuestros Finders
  //   final titleFinder = find.byIcon(Icons.cancel);
  //   // Use el matcher `findsOneWidget` proporcionado por flutter_test para verificar que
  //   // nuestros Text Widgets aparezcan exactamente una vez en el Widget tree
  //   expect(await titleFinder, findsOneWidget);
  // });

  // testWidgets('An Internet Connection Has Been Detected Message', (widgetTester) async{
    
  //   await widgetTester.pumpWidget( const TriggerTestScreen() );

  //   var connectedIcon = find.byKey(const Key("SuccessIcon"));

  //   expect(connectedIcon, findsOneWidget);
  // });

  
}
