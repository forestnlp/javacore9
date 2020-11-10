package org.javacore.arrays.equalscase1;

public class Main {

    public static void main(String[] args) {
        Person p = new Manager(1);
        Manager q = new Manager(1);
        System.out.println(p.equals(q));
    }
}
