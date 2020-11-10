package org.javacore.collections.wrapper;

import java.util.Arrays;
import java.util.List;

public class ListWrapper {

    class Card{

    }

    public static void main(String[] args) {

        Card[] cards = new Card[52];

        List<Card> cards1 = Arrays.asList(cards);

        System.out.println(cards1);
    }
}
