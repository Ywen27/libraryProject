# Library Management System
*Lisez ceci en [Français](README.md)*
## Technologies Used
- Database: MySQL
- IDE: IDEA
- Data connection pool: Druid
- Web container: Apache Tomcat
- Project management tools: Maven
- Version control tools: Git
- Back-end technology: Spring + SpringMVC + MyBatis（SSM）
- Front-end framework：bootstrap

### Features for the administrator:
- Authentication: The administrator must log in using a username and password.
- Loan management: The administrator can view the list of loans, make a loan for the reader, modify the status of a loan (in progress, returned, lost, etc.), that is, return a book.
- Book management: The administrator can view the list of books, add new books, modify the information of existing books, and delete books.
- User management: The administrator can view the list of users, modify their information, and delete users.
- Management of book types: The administrator can view the list of book types, add new types, and delete types.
- Announcement management: The administrator can make an announcement if desired.
- Statistics: The administrator can view statistics on books by type.
- There are two categories of administrators: Senior and Ordinary. Senior administrators have the ability to manage administrators, while ordinary administrators cannot.

### Features for the readers
- Authentication: Readers must log in using a username and password.
- Users can modify their personal information as well as their password.
- Book search: Users can search for books by title, author, genre.
- Viewing a book's information: Users can view the information of a book, such as the title, author, genre, and availability, etc.
- View personal loans: Users can look at their book borrowing timeline.
- View announcements.
