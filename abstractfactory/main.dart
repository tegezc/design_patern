import 'abstractfactory.dart';
import 'client.dart';

main() {
  print("abstract factory");

  Client clientMotif = Client(MotifWidgetFactory());
  print(clientMotif);
  Client clientpm = Client(PMWidgetFactory());
  print(clientpm);
}
