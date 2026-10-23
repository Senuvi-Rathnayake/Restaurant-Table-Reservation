<div align="center">

# 🍗 Los Pollos Hermanos
### Restaurant Table Reservation Platform

A Java-based web application for managing restaurant reservations, built with **Jakarta Servlets, JSP, and a file-based storage system**.

![Java](https://img.shields.io/badge/Java-17-orange?style=for-the-badge&logo=openjdk&logoColor=white)
![Jakarta EE](https://img.shields.io/badge/Jakarta-Servlets-blue?style=for-the-badge)
![JSP](https://img.shields.io/badge/View-JSP-purple?style=for-the-badge)
![Maven](https://img.shields.io/badge/Build-Maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)
![License](https://img.shields.io/badge/License-Not%20specified-lightgrey?style=for-the-badge)

**Reserve a table. Manage bookings. Make dining simpler.**

</div>

---

## 📌 About the Project

The **Restaurant Table Reservation Platform** is a web application concept for a restaurant branded as *Los Pollos Hermanos*. Customers can submit reservation details, while the reservation management area allows staff to view, edit, and delete bookings.

The project demonstrates Java web development fundamentals, including servlet-based request handling, JSP views, object-oriented modelling, and data-structure implementation. Reservation records are stored in a text file, so a relational database is not required for the current version.

## ✨ Features

- **Reservation creation** — submit a name, date, time, and party size.
- **Reservation management** — view existing reservations and edit or delete a booking.
- **Input validation** — checks required reservation details and validates party size and time input.
- **File-based persistence** — reservation records are read from and written to a text file.
- **Circular queue** — uses a circular queue data structure to manage reservation records in memory.
- **Restaurant-themed interface** — JSP pages, custom fonts, images, and styled navigation.
- **Maven build** — package the application as a deployable WAR file.

> **Current implementation note:** Reservation functionality is the main implemented workflow. Some navigation items and sections shown in the interface (such as login, feedback, or table management) may be placeholders and should not be assumed to have complete backend functionality.

## 🧰 Tech Stack

| Technology | Purpose |
|---|---|
| Java 17 | Application logic and reservation model |
| Jakarta Servlet API 6.1 | HTTP request handling and routing |
| JSP 3.1 | Dynamic web pages and presentation |
| JSTL 3.0 | JSP view iteration and conditional rendering |
| Apache Maven | Dependency management and WAR packaging |
| Apache Tomcat 11 | Suggested servlet/JSP application server |
| Text file (`reservations.txt`) | Reservation data persistence |

## 🗂️ Project Structure

```text
Restaurant-Table-Reservation-Platform/
├── data/
│   └── reservations.txt             # Reservation records
├── src/main/java/com/restaurant/
│   ├── model/
│   │   └── Reservation.java         # Reservation data model
│   ├── service/
│   │   └── ReservationService.java  # Reservation operations and queue
│   └── servlet/
│       ├── HomeServlet.java         # Home page route
│       ├── ReservationServlet.java  # Reservation routes
│       └── AdminServlet.java        # Reservation admin view
├── src/main/webapp/
│   ├── WEB-INF/views/               # JSP views and shared layout
│   ├── images/                      # Restaurant images and graphics
│   ├── fonts/                       # Custom fonts
│   ├── index.jsp
│   └── contact.jsp
├── pom.xml
├── mvnw
├── mvnw.cmd
└── README.md
```

## ⚙️ Getting Started

### Prerequisites

Install the following before running the project:

- **JDK 17** or later
- **Apache Maven** (or use the included Maven Wrapper)
- **Apache Tomcat 11**
- An IDE such as IntelliJ IDEA or Eclipse (optional, but recommended)

### 1. Clone the repository

```bash
git clone https://github.com/YOUR-USERNAME/Restaurant-Table-Reservation-Platform.git
cd Restaurant-Table-Reservation-Platform
```

Replace `YOUR-USERNAME` with your GitHub username and adjust the repository URL if you use a different repository name.

### 2. Configure the reservation file path

Before running the application, open:

```text
src/main/java/com/restaurant/service/ReservationService.java
```

Update the `FILE_PATH` constant to point to the `data/reservations.txt` file in your local project. The current source contains a machine-specific macOS path, so it will not work unchanged on every computer. Use an absolute path for your local setup, and make sure the application has permission to read and write the file.

### 3. Build the WAR file

On Windows:

```bat
mvnw.cmd clean package
```

On macOS or Linux:

```bash
./mvnw clean package
```

If you have Maven installed globally, you can use `mvn clean package` instead.

The generated WAR should be available under `target/`.

### 4. Deploy to Tomcat

1. Copy the generated WAR file from `target/` into Tomcat's `webapps/` directory.
2. Start Tomcat.
3. Open the application in your browser using the context path assigned by Tomcat, for example:

```text
http://localhost:8080/RestaurantTableReservationPlatform/home
```

The exact URL may differ depending on the WAR filename and your Tomcat configuration.

## 🔄 How It Works

1. A customer enters their reservation details in the web interface.
2. The reservation servlet receives and validates the submitted form data.
3. The reservation service creates a `Reservation` object and manages reservation records.
4. Reservation data is persisted in the configured text file.
5. The administration view displays existing reservations, with routes for editing and deleting records.

## 🧠 Concepts Demonstrated

- Object-oriented programming with a `Reservation` model
- MVC-style separation between model, service, servlet, and JSP view layers
- HTTP `GET` and `POST` request handling
- Form validation and date/time parsing
- File input/output for persistence
- Circular queue operations
- Maven WAR packaging and servlet-container deployment

## 🛠️ Known Limitations

- Reservation storage is file-based rather than database-backed.
- The reservation file path must be configured for each environment.
- Authentication and authorization should be added before using the admin area in a real deployment.
- Some interface links or management sections may not have complete server-side implementations.
- This project is intended as a learning/demo application, not a production-ready booking service.

## 🚀 Future Improvements

- Add a database such as MySQL for persistent, multi-user storage.
- Implement secure login and role-based access for administrators.
- Add table availability checks and prevent conflicting reservations.
- Improve server-side validation and user-friendly error messages.
- Add automated unit and integration tests.
- Add screenshots or a short demo GIF to showcase the user interface.

## 🤝 Contributing

Contributions and suggestions are welcome. Fork the repository, create a feature branch, make your changes, and open a pull request.

## 📄 License

No license is currently specified. Add a `LICENSE` file if you want to define how others may use, modify, and distribute this project.

---

<div align="center">

Made with ☕ and Java · **Restaurant Table Reservation Platform**

</div>
