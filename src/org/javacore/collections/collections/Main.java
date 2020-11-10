package org.javacore.collections.collections;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class Main {

    static class Card implements Comparable<Card>{
        private int id;

        public Card(int id) {
            this.id = id;
        }

        @Override
        public int compareTo(Card o) {
            return this.id-o.id;
        }

        @Override
        public String toString() {
            return "Card{" +
                    "id=" + id +
                    '}';
        }
    }

    public static void main(String[] args) {

        List<Card> cards = new ArrayList<>();

        cards.add(new Card(1));
        cards.add(new Card(3));
        cards.add(new Card(4));
        cards.add(new Card(2));

        Collections.sort(cards);

        System.out.println(cards);
    }
}
