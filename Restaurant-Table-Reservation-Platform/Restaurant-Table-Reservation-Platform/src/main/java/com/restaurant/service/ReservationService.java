package com.restaurant.service;

import com.restaurant.model.Reservation;

import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ReservationService {
    private static final String FILE_PATH = "/Users/mac/Documents/Y1S2/OOP/RestaurantTableReservationPlatform/data/reservations.txt";
    private final CircularQueue reservationQueue;
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private static ReservationService instance;

    private ReservationService() {
        reservationQueue = new CircularQueue(100);
        File file = new File(FILE_PATH);
        try {
            String absolutePath = file.getAbsolutePath();
            System.out.println("Resolved absolute file path: " + absolutePath);
            if (!file.exists()) {
                file.getParentFile().mkdirs();
                file.createNewFile();
                System.out.println("Created new file at: " + absolutePath);
            } else {
                System.out.println("File already exists at: " + absolutePath);
                loadReservationsFromFile();
            }
        } catch (IOException e) {
            System.err.println("Failed to create or access file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static synchronized ReservationService getInstance() {
        if (instance == null) {
            instance = new ReservationService();
        }
        return instance;
    }

    // Circular Queue
    private class CircularQueue {
        private int maxSize;
        private Reservation[] circularQueue;
        private int front;
        private int rear;
        private int nItems;

        public CircularQueue(int size) {
            maxSize = size;
            circularQueue = new Reservation[maxSize];
            front = 0;
            rear = -1;
            nItems = 0;
        }

        public void insert(Reservation reservation) {
            if (nItems == maxSize) {
                System.out.println("Queue is Full");
            } else {
                if (rear == maxSize - 1) {
                    rear = -1; // Wrap around
                }
                circularQueue[++rear] = reservation;
                nItems++;
                System.out.println("Enqueued: " + reservation);
            }
        }

        public Reservation remove() {
            if (nItems == 0) {
                System.out.println("Queue is Empty");
                return null;
            } else {
                Reservation temp = circularQueue[front++];
                if (front == maxSize) {
                    front = 0; // Wrap around
                }
                nItems--;
                System.out.println("Dequeued: " + temp);
                return temp;
            }
        }

        public Reservation peekFront() {
            if (nItems == 0) {
                System.out.println("Queue is Empty");
                return null;
            } else {
                return circularQueue[front];
            }
        }

        public boolean isEmpty() {
            return nItems == 0;
        }

        public boolean isFull() {
            return nItems == maxSize;
        }

        public int size() {
            return nItems;
        }

        public Reservation[] toArray() {
            Reservation[] result = new Reservation[nItems];
            int index = 0;
            int current = front;
            for (int i = 0; i < nItems; i++) {
                result[index++] = circularQueue[current];
                current = (current + 1) % maxSize;
            }
            return result;
        }

        public void refill(Reservation[] sortedArray) {
            front = 0;
            rear = -1;
            nItems = 0;
            for (Reservation res : sortedArray) {
                if (res != null) {
                    insert(res);
                }
            }
        }

        public void update(int index, Reservation updatedReservation) {
            if (index < 0 || index >= nItems) {
                throw new IndexOutOfBoundsException("Invalid index: " + index);
            }
            int target = (front + index) % maxSize;
            circularQueue[target] = updatedReservation;
        }

        public void removeAtIndex(int index) {
            if (index < 0 || index >= nItems) {
                throw new IndexOutOfBoundsException("Invalid index: " + index);
            }
            int current = (front + index) % maxSize;
            for (int i = index; i < nItems - 1; i++) {
                int next = (front + i + 1) % maxSize;
                circularQueue[(front + i) % maxSize] = circularQueue[next];
            }
            circularQueue[(front + nItems - 1) % maxSize] = null;
            rear = (rear - 1 + maxSize) % maxSize;
            nItems--;
        }
    }

    private void loadReservationsFromFile() {
        try (BufferedReader reader = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    Reservation reservation = Reservation.fromString(line);
                    if (reservation != null) {
                        reservationQueue.insert(reservation);
                    }
                }
            }
            System.out.println("Loaded reservations into queue");
        } catch (IOException e) {
            System.err.println("Failed to read from file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public Reservation[] getAllReservations() {
        Reservation[] reservations = reservationQueue.toArray();
        if (reservations.length <= 1) return reservations;
        return mergeSort(reservations); // Sort only when retrieving
    }

    public void addReservation(Reservation reservation) {
        reservationQueue.insert(reservation);
        // Sort and re enqueue
        Reservation[] sortedReservations = getAllReservations();
        reservationQueue.refill(sortedReservations);
        rewriteFile(); // Update file
    }

    public void updateReservation(int index, Reservation updatedReservation) {
        reservationQueue.update(index, updatedReservation);
        // Sort and re enqueue
        Reservation[] sortedReservations = getAllReservations();
        reservationQueue.refill(sortedReservations);
        rewriteFile(); // Update file
    }

    public void deleteReservation(int index) {
        reservationQueue.removeAtIndex(index);
        // Sort and re enqueue
        Reservation[] sortedReservations = getAllReservations();
        reservationQueue.refill(sortedReservations);
        rewriteFile(); // Update file
    }

    private void rewriteFile() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, false))) {
            Reservation[] reservations = reservationQueue.toArray();
            for (Reservation reservation : reservations) {
                if (reservation != null) {
                    writer.write(reservation.toString());
                    writer.newLine();
                }
            }
            System.out.println("Rewrote file with queue contents");
        } catch (IOException e) {
            System.err.println("Failed to rewrite file: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public Reservation dequeueReservation() {
        Reservation reservation = reservationQueue.remove();
        if (reservation != null) {
            // Sort and re-enqueue remaining reservations
            Reservation[] sortedReservations = getAllReservations();
            reservationQueue.refill(sortedReservations);
            rewriteFile(); // Update file
        }
        return reservation;
    }

    public Reservation peekReservation() {
        return reservationQueue.peekFront();
    }

    public boolean isEmpty() {
        return reservationQueue.isEmpty();
    }

    public int size() {
        return reservationQueue.size();
    }

    private Reservation[] mergeSort(Reservation[] array) {
        if (array.length <= 1) return array;

        int mid = array.length / 2;
        Reservation[] left = new Reservation[mid];
        Reservation[] right = new Reservation[array.length - mid];

        System.arraycopy(array, 0, left, 0, mid);
        System.arraycopy(array, mid, right, 0, array.length - mid);

        left = mergeSort(left);
        right = mergeSort(right);

        return merge(left, right);
    }

    private Reservation[] merge(Reservation[] left, Reservation[] right) {
        Reservation[] result = new Reservation[left.length + right.length];
        int i = 0, j = 0, k = 0;

        while (i < left.length && j < right.length) {
            if (compareReservations(left[i], right[j]) <= 0) {
                result[k++] = left[i++];
            } else {
                result[k++] = right[j++];
            }
        }

        while (i < left.length) {
            result[k++] = left[i++];
        }
        while (j < right.length) {
            result[k++] = right[j++];
        }

        return result;
    }

    private int compareReservations(Reservation r1, Reservation r2) {
        if (r1 == null || r2 == null) return 0;
        String dateTime1 = r1.getDate() + " " + r1.getTime();
        String dateTime2 = r2.getDate() + " " + r2.getTime();
        LocalDateTime dt1 = LocalDateTime.parse(dateTime1, DATE_TIME_FORMATTER);
        LocalDateTime dt2 = LocalDateTime.parse(dateTime2, DATE_TIME_FORMATTER);
        return dt1.compareTo(dt2); // Ascending order by date and time
    }
}