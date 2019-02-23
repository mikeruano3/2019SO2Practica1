package dustin.examples;

import static java.lang.System.out;

public class Main

{

   private final Parent parent = new Parent();

   private final Child child = new Child();

   public static void main(final String[] arguments)

   {

      final Main instance = new Main();

      out.println(instance.parent);

      out.println(instance.child);

   }

}
