package org.javacore.passvalue;

public class PrimitiveValPassMain {

    int increase(int a){
        a = a+10;
        return a;
    }

    public static void main(String[] args) {
        PrimitiveValPassMain cases = new PrimitiveValPassMain();
        int a = 20;
        int b = cases.increase(a);
        System.out.println(b+","+a);
    }
}
