package org.javacore.concurrent;

import java.util.Date;

public class InterruptTest2 {

    public static void main(String[] args) {
        Object lock = new Object();

        Thread t1 = new Thread(()->{
            try {
                System.out.println("sleep 1 s");
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            synchronized (lock){
                System.out.println(Thread.currentThread().getName()+" get lock now hold it for 30s");
                try {
                    Thread.sleep(10000);
                } catch (InterruptedException e) {
                    System.out.println(new Date());
                    e.printStackTrace();
                }
            }
        });
        t1.start();


        Thread t2 = new Thread(()->{
            //必须在t2重新获取锁后才会被打断
            synchronized (lock){
                System.out.println(Thread.currentThread().getName()+" get lock now hold it for 5s");
                try {
                    lock.wait(5000);
                } catch (InterruptedException e) {
                    System.out.println(new Date());
                    e.printStackTrace();
                }
            }
        });

        t2.start();
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        t2.interrupt();

    }
}
