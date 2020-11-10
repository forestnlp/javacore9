package org.javacore.passvalue;

public class ReferencePassMain {

    static class Cat {
        private int id;
        private String name;

        public Cat(int id, String name) {
            this.id = id;
            this.name = name;
        }

        @Override
        public String toString() {
            return "Cat{" +
                    "id=" + id +
                    ", name='" + name + '\'' +
                    '}';
        }
    }

    public void swap(Cat a,Cat b){
        System.out.println("in method before swap a:"+a);
        System.out.println("in method before swap b:"+b);
        Cat tmp = b;
        b = a;
        a = tmp;
        System.out.println("in method after swap a:"+a);
        System.out.println("in method after swap b:"+b);
    }

    public static void main(String[] args) {
        Cat mimi = new Cat(1,"mimi");
        Cat miaomiao = new Cat(2,"miaom");
        ReferencePassMain main = new ReferencePassMain();
        main.swap(mimi,miaomiao);

        System.out.println("outside method mimi:"+mimi);
        System.out.println("outside method miaomiao:"+miaomiao);
    }
}
