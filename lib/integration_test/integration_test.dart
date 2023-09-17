
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vistas_amatista/resources/custom_widgets/msos_wizard_textbox.dart';


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Test de Validaciones de Contraseñas', () {
    test('Rechazo de contraseñas con menos de 8 caractéres', (){
      const textBoxCustomWidget = MSosWizardTextBox(label: "test");

      var testResult = textBoxCustomWidget.passwordValidation("passwd1");
    
      expect (testResult, 'Debe tener mínimo 8 caracteres!');
      
    });

    test('Rechazo de contraseñas vacías', (){
      const textBoxCustomWidget = MSosWizardTextBox(label: "test");

      var testResult = textBoxCustomWidget.passwordValidation("");
      
      expect (testResult, 'Defina una contraseña!');
    });

    test('Rechazo de contraseñas con espacios', (){
      const textBoxCustomWidget = MSosWizardTextBox(label: "test");

      var testResult = textBoxCustomWidget.passwordValidation("Hello World1!");
      
      expect (testResult, 'No debe incluir espacios!');
    });

    test('Rechazo de contraseñas sin al menos un número', (){
      const textBoxCustomWidget = MSosWizardTextBox(label: "test");

      var testResult = textBoxCustomWidget.passwordValidation("MyPassword");
      
      expect (testResult, 'Debe tener al menos un número!');
    });

    test('Rechazo de contraseñas sin al menos una letra', (){
      const textBoxCustomWidget = MSosWizardTextBox(label: "test");

      var testResult = textBoxCustomWidget.passwordValidation("12345678");
      
      expect (testResult, 'Debe tener al menos una letra!');
    });

    // testWidgets("An Internet Connection Hasn't Been Detected Message", (widgetTester) async{
      
    //   await widgetTester.pumpWidget(const TriggerTestScreen());
      
    //   // Crea nuestros Finders
    //   final titleFinder = find.byIcon(Icons.cancel);
    //   // Use el matcher `findsOneWidget` proporcionado por flutter_test para verificar que
    //   // nuestros Text Widgets aparezcan exactamente una vez en el Widget tree
    //   expect(titleFinder, findsOneWidget);
    // });

    // testWidgets('An Internet Connection Has Been Detected Message', (widgetTester) async{
      
    //   await widgetTester.pumpWidget( const TriggerTestScreen() );

    //   var connectedIcon = find.byKey(const Key("SuccessIcon"));

    //   expect(connectedIcon, findsOneWidget);
    // });
    
  });
}