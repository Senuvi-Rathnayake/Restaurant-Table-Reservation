package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@WebServlet("/reservations/*")
public class ReservationServlet extends HttpServlet {
    private final ReservationService reservationService = ReservationService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        try {
            if (pathInfo == null || "/".equals(pathInfo)) {
                Reservation[] reservations = reservationService.getAllReservations();
                request.setAttribute("reservations", reservations != null ? reservations : new Reservation[0]);
                request.getRequestDispatcher("/WEB-INF/views/reservations.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit")) {
                String indexStr = request.getParameter("index");
                if (indexStr == null || indexStr.trim().isEmpty()) {
                    System.err.println("Edit request failed: Missing index parameter");
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing index parameter");
                    return;
                }
                try {
                    int index = Integer.parseInt(indexStr);
                    Reservation[] reservations = reservationService.getAllReservations();
                    if (reservations == null || index < 0 || index >= reservations.length || reservations[index] == null) {
                        System.err.println("Edit request failed: Invalid index " + index + ", reservations length: " + (reservations != null ? reservations.length : 0));
                        response.sendRedirect(request.getContextPath() + "/admin");
                        return;
                    }
                    request.setAttribute("reservation", reservations[index]);
                    request.setAttribute("index", index);
                    System.out.println("Redirecting to edit.jsp for index: " + index);
                    request.getRequestDispatcher("/WEB-INF/views/edit.jsp").forward(request, response);
                } catch (NumberFormatException e) {
                    System.err.println("Edit request failed: Invalid index format - " + indexStr);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid index format");
                }
            } else if (pathInfo.startsWith("/delete")) {
                String indexStr = request.getParameter("index");
                if (indexStr == null || indexStr.trim().isEmpty()) {
                    System.err.println("Delete request failed: Missing index parameter");
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing index parameter");
                    return;
                }
                try {
                    int index = Integer.parseInt(indexStr);
                    Reservation[] reservations = reservationService.getAllReservations();
                    if (reservations == null || index < 0 || index >= reservations.length || reservations[index] == null) {
                        System.err.println("Delete request failed: Invalid index " + index + ", reservations length: " + (reservations != null ? reservations.length : 0));
                        response.sendRedirect(request.getContextPath() + "/admin");
                        return;
                    }
                    reservationService.deleteReservation(index);
                    System.out.println("Reservation deleted at index: " + index);
                    response.sendRedirect(request.getContextPath() + "/admin");
                } catch (NumberFormatException e) {
                    System.err.println("Delete request failed: Invalid index format - " + indexStr);
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid index format");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid path");
            }
        } catch (Exception e) {
            System.err.println("Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            try {
                // Get form parameters
                String name = request.getParameter("name");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                String partySizeStr = request.getParameter("partySize");

                // Validate parameters
                if (name == null || date == null || time == null || partySizeStr == null) {
                    request.setAttribute("error", "Missing required parameters");
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                    return;
                }

                // Parse and validate party size
                int partySize;
                try {
                    partySize = Integer.parseInt(partySizeStr);
                    if (partySize < 1) {
                        request.setAttribute("error", "Party size must be at least 1");
                        request.getRequestDispatcher("/index.jsp").forward(request, response);
                        return;
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid party size format");
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                    return;
                }

                // Normalize the time format to 24-hour format (e.g., "14:30 PM" to "14:30")
                String normalizedTime;
                try {
                    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("HH:mm a");
                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("HH:mm"); // 24-hour format
                    LocalTime localTime = LocalTime.parse(time, inputFormatter);
                    normalizedTime = localTime.format(outputFormatter);
                } catch (DateTimeParseException e) {
                    request.setAttribute("error", "Invalid time format: " + time);
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                    return;
                }

                // Create and save reservation
                Reservation reservation = new Reservation(name, date, normalizedTime, partySize);
                reservationService.addReservation(reservation);

                // Set success message and redirect back to index.jsp
                request.setAttribute("success", "true");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            } catch (Exception e) {
                System.err.println("Error in ReservationServlet doPost: " + e.getMessage());
                e.printStackTrace();
                request.setAttribute("error", "Server error: " + e.getMessage());
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } else if (pathInfo.startsWith("/edit")) {
            try {
                String indexStr = request.getParameter("index");
                String name = request.getParameter("name");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                String partySizeStr = request.getParameter("partySize");

                if (indexStr == null || name == null || date == null || time == null || partySizeStr == null) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                    return;
                }

                // Parse and validate party size and index
                int index;
                int partySize;
                try {
                    index = Integer.parseInt(indexStr);
                    partySize = Integer.parseInt(partySizeStr);
                    if (partySize < 1) {
                        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Party size must be at least 1");
                        return;
                    }
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid index or party size format");
                    return;
                }

                // Validate index
                Reservation[] reservations = reservationService.getAllReservations();
                if (reservations == null || index < 0 || index >= reservations.length) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid index");
                    return;
                }

                // Normalize the time format to 24-hour format (e.g., "14:30 PM" to "14:30")
                String normalizedTime;
                try {
                    DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("HH:mm a");
                    DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("HH:mm"); // 24-hour format
                    LocalTime localTime = LocalTime.parse(time, inputFormatter);
                    normalizedTime = localTime.format(outputFormatter);
                } catch (DateTimeParseException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid time format: " + time);
                    return;
                }

                // Create and update reservation
                Reservation updatedReservation = new Reservation(name, date, normalizedTime, partySize);
                reservationService.updateReservation(index, updatedReservation);

                // Redirect to admin page
                response.sendRedirect(request.getContextPath() + "/admin");
            } catch (Exception e) {
                System.err.println("Error in ReservationServlet doPost /edit: " + e.getMessage());
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage());
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid path");
        }
    }
}