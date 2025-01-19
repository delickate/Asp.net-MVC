# User Management System - MVC5

This project is a User Management System developed using ASP.NET MVC5, which allows administrators to manage users, roles, permissions, and modules. The system is backed by a SQL Server database (`sani_usermanagement`) and utilizes Entity Framework for data access.

## Features

- **User Management**: Create, Edit, View, and Delete users.
- **Role Management**: CRUD operations for roles and assignment of permissions to roles.
- **Module Permissions**: Modules and rights management, allowing specific permissions for each role.
- **Authentication**: User login and session management for secure access.

## Database Schema

This project uses the following tables:

### 1. **rights**
Stores the available rights that can be assigned to roles.

| Field | Type   |
|-------|--------|
| id    | int    |
| name  | string |

### 2. **modules**
Stores the available modules in the system.

| Field     | Type    |
|-----------|---------|
| created_at| datetime|
| id        | int     |
| is_default| boolean |
| name      | string |
| parent_id | int     |
| slug      | string |
| sortid    | int     |
| status    | string  |
| url       | string  |

### 3. **roles**
Stores the roles available in the system.

| Field     | Type    |
|-----------|---------|
| id        | int     |
| is_default| boolean |
| name      | string  |

### 4. **roles_modules_permissions**
Stores the relationship between roles and modules, including whether the module is enabled for the role.

| Field     | Type    |
|-----------|---------|
| id        | int     |
| is_default| boolean |
| module_id | int     |
| role_id   | int     |

### 5. **roles_modules_permissions_rights**
Stores the rights assigned to specific modules for roles.

| Field                    | Type    |
|--------------------------|---------|
| id                       | int     |
| is_default               | boolean |
| rights_id                | int     |
| roles_modules_permissions_id | int |

### 6. **users**
Stores the user information.

| Field       | Type    |
|-------------|---------|
| aboutme     | string  |
| education_id| int     |
| email       | string  |
| gender_id   | int     |
| id          | int     |
| interests   | string  |
| is_default  | boolean |
| name        | string  |
| password    | string  |
| phone       | string  |
| picture     | string  |
| status      | string  |

### 7. **users_roles**
Stores the roles assigned to users.

| Field    | Type    |
|----------|---------|
| id       | int     |
| role_id  | int     |
| user_id  | int     |

## Technologies Used

- **ASP.NET MVC5**: Web framework for building the application.
- **Entity Framework**: ORM to interact with the SQL Server database.
- **SQL Server**: Database for storing the user management data.
- **HTML/CSS/Bootstrap**: Frontend for user interfaces.
- **jQuery**: For client-side interactions.

## Setup Instructions

### Prerequisites
- Install [Visual Studio](https://visualstudio.microsoft.com/) (with MVC support).
- Install [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) and create a database named `sani_usermanagement`.
- Install [SQL Server Management Studio (SSMS)](https://aka.ms/ssmsfullsetup) to manage the database (optional).


### Explanation:
1. **Project Overview**: Describes the project and its purpose.
2. **Database Schema**: Lists all the database tables used and their structure.
3. **Technologies Used**: Specifies the main technologies used for the project.
4. **Setup Instructions**: Provides step-by-step instructions on setting up and running the project.
5. **Usage**: Briefly describes how to interact with the application once it’s running.
6. **Contributing**: Encourages others to contribute to the project.
7. **License**: Specifies the license under which the project is distributed.

Feel free to adjust the repository URL, connection string, and other details specific to your project!


### Clone the Repository

```bash
git clone https://github.com/your-repo-url
