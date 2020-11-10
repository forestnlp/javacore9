package org.javacore.reflection;

import java.util.Date;

public class MainClassLoader {
    public static void main(String[] args) throws IllegalAccessException, InstantiationException, ClassNotFoundException {
        String className = "java.util.Date";
        Class<?> aClass = Class.forName(className);
        Object o = aClass.newInstance();
        System.out.println(o);

        Class<Date> dateClass = (Class<Date>) Class.forName(className);
        Date date = dateClass.newInstance();
        System.out.println(date);
    }
}
