import 'iscrollbar.dart';
import 'iwindow.dart';

abstract class WidgetFactory {
  Scrollbar createScrollbar();
  Window createWindow();
}

class PMWidgetFactory implements WidgetFactory {
  @override
  Scrollbar createScrollbar() {
    return PMScrollbar();
  }

  @override
  Window createWindow() {
    return PMWindow();
  }
}

class MotifWidgetFactory implements WidgetFactory {
  @override
  Scrollbar createScrollbar() {
    return MotifScrollbar();
  }

  @override
  Window createWindow() {
    return MotifWindow();
  }
}
