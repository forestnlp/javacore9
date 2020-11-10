package org.javacore.generic;

public class Pair<T> {

    public Pair(T firstInstance, T secondInstance) {
        this.firstInstance = firstInstance;
        this.secondInstance = secondInstance;
    }

    private T firstInstance;
    private T secondInstance;

    public void println(){
        System.out.println(firstInstance+","+secondInstance);
    }
}
