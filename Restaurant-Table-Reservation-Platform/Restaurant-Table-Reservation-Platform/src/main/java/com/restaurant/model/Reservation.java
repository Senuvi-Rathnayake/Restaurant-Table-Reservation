package com.restaurant.model;

public class Reservation {
    private String name;
    private String date;
    private String time;
    private int partySize;

    public Reservation() {}

    public Reservation(String name, String date, String time, int partySize) {
        this.name = name;
        this.date = date;
        this.time = time;
        this.partySize = partySize;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getPartySize() {
        return partySize;
    }

    public void setPartySize(int partySize) {
        this.partySize = partySize;
    }

    @Override
    public String toString() {
        return name + "," + date + "," + time + "," + partySize;
    }

    public static Reservation fromString(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length != 4) {
                throw new IllegalArgumentException("Invalid reservation format: " + line);
            }
            String name = parts[0].trim();
            String date = parts[1].trim();
            String time = parts[2].trim();
            int partySize = Integer.parseInt(parts[3].trim());
            if (name.isEmpty() || date.isEmpty() || time.isEmpty()) {
                throw new IllegalArgumentException("Reservation fields cannot be empty: " + line);
            }
            return new Reservation(name, date, time, partySize);
        } catch (Exception e) {
            System.err.println("Error parsing reservation: " + e.getMessage());
            return null; // Skip invalid entries
        }
    }
}