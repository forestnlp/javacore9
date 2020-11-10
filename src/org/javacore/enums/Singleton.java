package org.javacore.enums;

public enum Singleton {

    instance();

    private int msg;

    private Singleton(){
        doInit();
    }

    private void doInit(){
        msg = 1000;
    }

    public void getmsg() {
        System.out.println(msg);
    }
}
