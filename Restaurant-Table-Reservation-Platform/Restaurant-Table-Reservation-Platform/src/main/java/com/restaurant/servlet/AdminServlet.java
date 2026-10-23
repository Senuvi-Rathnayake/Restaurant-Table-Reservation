package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private final ReservationService reservationService = ReservationService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            Reservation[] reservations = reservationService.getAllReservations();
            request.setAttribute("reservations", reservations != null ? reservations : new Reservation[0]);
            request.getRequestDispatcher("/WEB-INF/views/admin.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid admin path");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.startsWith("/add-table")) {
            response.sendRedirect(request.getContextPath() + "/admin");
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Invalid admin POST path");
        }
    }
}