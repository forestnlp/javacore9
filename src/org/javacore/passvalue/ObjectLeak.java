package org.javacore.passvalue;

public class ObjectLeak {

    static class Cat {

        public Cat(String name) {
            this.name = name;
        }

        private String name;

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        @Override
        public String toString() {
            return "Cat{" +
                    "name='" + name + '\'' +
                    '}';
        }

        private static Cat cat = new Cat("mimi");

        public static Cat getInstance(){
            return cat;
        }
    }

    public static void main(String[] args) {
        Cat c = Cat.getInstance();
        System.out.println(c);
        c.setName("tom");
        Cat c2 = Cat.getInstance();
        System.out.println(c2);
    }
}
