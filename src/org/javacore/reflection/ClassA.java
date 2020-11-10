package org.javacore.reflection;

public class ClassA implements Comparable<ClassA> {

    private int instanceV;

    private static int staticV;

    private void instanceMethod(int param1,int param2) {

    }

    private  static void staticMethod(int param1,int param2) {

    }

    @Override
    public int compareTo(ClassA o) {
        return 0;
    }
}
