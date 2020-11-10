package org.javacore.reflection;

import java.util.Arrays;

public class Main {

    public static void main(String[] args) {

        Object o = new ClassA();

        Class clazz = o.getClass();

        System.out.println(clazz.getName());

        System.out.println(Arrays.toString(clazz.getInterfaces()));

    }

}
