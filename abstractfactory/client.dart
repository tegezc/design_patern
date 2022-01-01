import 'abstractfactory.dart';
import 'iscrollbar.dart';
import 'iwindow.dart';

class Client {
  Scrollbar? scrollbar;
  Window? window;
  Client(WidgetFactory widgetFactory) {
    this.scrollbar = widgetFactory.createScrollbar();
    this.window = widgetFactory.createWindow();
  }

  @override
  String toString() => 'Client(scrollbar: $scrollbar, window: $window)';
}
