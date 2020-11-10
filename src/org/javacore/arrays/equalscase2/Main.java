package org.javacore.arrays.equalscase2;

public class Main {

    public static void main(String[] args) {
        Person p = new Person(1);
        Manager q = new Manager(1);
        System.out.println(p.equals(q));
        System.out.println(q.equals(p));
    }
}
