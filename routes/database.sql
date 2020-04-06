CREATE TABLE TICKET(
  Ticket_number INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Ticket_type VARCHAR(50),
  Priority INT,
  Status VARCHAR(50),
  Title VARCHAR(255),
  Created_By INT NOT NULL,
  Assigned_To INT,
  Assigned_Date DATE,
  Deadline_Date DATE,
  Description TEXT,
  FOREIGN KEY (Created_By) REFERENCES EMPLOYEE(Employee_id) ON DELETE CASCADE
);

CREATE TABLE DEPARTMENT(
  Department_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50),
  Location VARCHAR(255),
  Acronym VARCHAR(50)
);

CREATE TABLE TEAM(
  Team_id INT NOT NULL AUTO_INCREMENT,
  Department_id INT NOT NULL,
  Name VARCHAR(100),
  CONSTRAINT PRIMARY KEY TEAM(Team_id, Department_id),
  FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

CREATE TABLE EMPLOYEE(
  Employee_id VARCHAR(10) PRIMARY KEY NOT NULL,
  First_name VARCHAR(100),
  Last_name VARCHAR(100),
  Group_id INT,
  Department_id INT,
  Classification VARCHAR(100),
  FOREIGN KEY (Group_id) REFERENCES TEAM(Team_id),
  FOREIGN KEY (Department_id) REFERENCES DEPARTMENT(Department_id)
);

<<<<<<< HEAD

CREATE TABLE STATUS (
    Status_ID int,
    Status_name VARCHAR(15)
);


/* trigger for insert
//Delimiter
Create Trigger




DELIMITER //

=======
DELIMITER // 
CREATE PROCEDURE GetTeamsAndMembers()
BEGIN
    SELECT *
    FROM 
	    TEAM T JOIN EMPLOYEE E ON E.Group_id = T.Group_id;
END //
DELIMITER ;
>>>>>>> 263853e3d5106351efd5bfc7306b608237e9685f
