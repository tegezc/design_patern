
# Abstract Factory
## Intent
Provide an interface for creating families of related or dependent objects without
specifying their concrete classes.

## Also Knows As
Kit

## Motivation
Consider a user interface toolkit that supports multiple look-and-feel standards, such as
Motif and Presentation Manager. Different look-and-feels define different appearances
and behaviors for user interface "widgets" like scroll bars, windows, and buttons. To be
portable across look-and-feel standards, an application should not hard-code its widgets
for a particular look and feel. Instantiating look-and-feel-specific classes of widgets
throughout the application makes it hard to change the look and feel later.
We can solve this problem by defining an abstract WidgetFactory class that declares an
interface for creating each basic kind of widget. There's also an abstract class for each
kind of widget, and concrete subclasses implement widgets for specific look-and-feel
standards. WidgetFactory's interface has an operation that returns a new widget object
for each abstract widget class. Clients call these operations to obtain widget instances,
but clients aren't aware of the concrete classes they're using. Thus clients stay
independent of the prevailing look and feel.

There is a concrete subclass of WidgetFactory for each look-and-feel standard. Each
subclass implements the operations to create the appropriate widget for the look and
feel. For example, the CreateScrollBar operation on the MotifWidgetFactory
instantiates and returns a Motif scroll bar, while the corresponding operation on the
PMWidgetFactory returns a scroll bar for Presentation Manager. Clients create widgets
solely through the WidgetFactory interface and have no knowledge of the classes that
88
implement widgets for a particular look and feel. In other words, clients only have to
commit to an interface defined by an abstract class, not a particular concrete class.
A WidgetFactory also enforces dependencies between the concrete widget classes. A
Motif scroll bar should be used with a Motif button and a Motif text editor, and that
constraint is enforced automatically as a consequence of using a MotifWidgetFactory.

## Applicability
Use the Abstract Factory pattern when
- a system should be independent of how its products are created, composed, and
represented.
- a system should be configured with one of multiple families of products.
- a family of related product objects is designed to be used together, and you need
to enforce this constraint.
- you want to provide a class library of products, and you want to reveal just their
interfaces, not their implementations.


## Participants
1 AbstractFactory (WidgetFactory)
* declares an interface for operations that create abstract product objects.
2 ConcreteFactory (MotifWidgetFactory, PMWidgetFactory)
* implements the operations to create concrete product objects.
3 AbstractProduct (Window, ScrollBar)
* declares an interface for a type of product object.
4 ConcreteProduct (MotifWindow, MotifScrollBar)
* defines a product object to be created by the corresponding concrete
factory.
* implements the AbstractProduct interface.
5 Client
* uses only interfaces declared by AbstractFactory and AbstractProduct
classes.

## Collaborations
- Normally a single instance of a ConcreteFactory class is created at run-time.
This concrete factory creates product objects having a particular implementation.
To create different product objects, clients should use a different concrete
factory.
- AbstractFactory defers creation of product objects to its ConcreteFactory
subclass.

## Consequences
The Abstract Factory pattern has the following benefits and liabilities:
1. It isolates concrete classes. The Abstract Factory pattern helps you control the
classes of objects that an application creates. Because a factory encapsulates the
responsibility and the process of creating product objects, it isolates clients from
implementation classes. Clients manipulate instances through their abstract
interfaces. Product class names are isolated in the implementation of the
concrete factory; they do not appear in client code.
2. It makes exchanging product families easy. The class of a concrete factory
appears only once in an application—that is, where it's instantiated. This makes
it easy to change the concrete factory an application uses. It can use different
product configurations simply by changing the concrete factory. Because an
abstract factory creates a complete family of products, the whole product family
changes at once. In our user interface example, we can switch from Motif
widgets to Presentation Manager widgets simply by switching the corresponding
factory objects and recreating the interface.
3. It promotes consistency among products. When product objects in a family are
designed to work together, it's important that an application use objects from
only one family at a time. AbstractFactory makes this easy to enforce.
4. Supporting new kinds of products is difficult. Extending abstract factories to
produce new kinds of Products isn't easy. That's because the AbstractFactory
interface fixes the set of products that can be created. Supporting new kinds of
products requires extending the factory interface, which involves changing the
AbstractFactory class and all of its subclasses. We discuss one solution to this
problem in the Implementation section.

## Implementation

Here are some useful techniques for implementing the Abstract Factory pattern.
1. Factories as singletons. An application typically needs only one instance of a
ConcreteFactory per product family. So it's usually best implemented as a
Singleton (127).
2. Creating the products. AbstractFactory only declares an interface for creating
products. It's up to ConcreteProduct subclasses to actually create them. The most
common way to do this is to define a factory method (see Factory Method (107))

for each product. A concrete factory will specify its products by overriding the
factory method for each. While this implementation is simple, it requires a new
concrete factory subclass for each product family, even if the product families
differ only slightly.
If many product families are possible, the concrete factory can be implemented
using the Prototype (117) pattern. The concrete factory is initialized with a
prototypical instance of each product in the family, and it creates a new product
by cloning its prototype. The Prototype-based approach eliminates the need for a
new concrete factory class for each new product family.
Here's a way to implement a Prototype-based factory in Smalltalk. The concrete
factory stores the prototypes to be cloned in a dictionary called partCatalog.
The method make: retrieves the prototype and clones it:
>make: partName
>  ^ (partCatalog at: partName) copy