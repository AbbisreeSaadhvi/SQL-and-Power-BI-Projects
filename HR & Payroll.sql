--TABLE CREATION AND DATA INSERTION
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Position VARCHAR(100),
    DateOfJoining DATE,
    DateOfTermination DATE NULL,
    PerformanceScore INT
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    EmployeeID INT,
    PaymentDate DATE,
    PaymentAmount DECIMAL(10, 2),
    PaymentType VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Position, DateOfJoining, DateOfTermination, PerformanceScore) VALUES
(1, 'John Doe', 'Manager', '2020-01-15', NULL, 85),
(2, 'Jane Smith', 'Analyst', '2021-02-20', NULL, 90),
(3, 'Alice Johnson', 'Developer', '2019-03-25', '2023-01-10', 70),
(4, 'Bob Brown', 'Support', '2022-04-30', NULL, 65),
(5, 'Charlie Green', 'Sales', '2018-05-15', NULL, 80),
(6, 'David White', 'Manager', '2020-06-20', NULL, 75),
(7, 'Ella Black', 'Analyst', '2021-07-25', NULL, 95),
(8, 'Frank Blue', 'Developer', '2019-08-30', '2022-12-05', 60),
(9, 'Grace Yellow', 'Support', '2022-09-15', NULL, 85),
(10, 'Hank Red', 'Sales', '2018-10-20', NULL, 70),
(11, 'Ivy Violet', 'Manager', '2020-11-25', NULL, 80),
(12, 'Jack Orange', 'Analyst', '2021-12-30', NULL, 90),
(13, 'Kate Purple', 'Developer', '2019-01-05', '2023-02-20', 65),
(14, 'Leo Pink', 'Support', '2022-02-15', NULL, 75),
(15, 'Mia Grey', 'Sales', '2018-03-10', NULL, 85),
(16, 'Nina Blue', 'Manager', '2020-04-05', NULL, 90),
(17, 'Oscar White', 'Analyst', '2021-05-20', NULL, 80),
(18, 'Paul Black', 'Developer', '2019-06-25', '2023-03-15', 60),
(19, 'Quinn Yellow', 'Support', '2022-07-10', NULL, 70),
(20, 'Ryan Red', 'Sales', '2018-08-20', NULL, 75),
(21, 'Sara Violet', 'Manager', '2020-09-25', NULL, 85),
(22, 'Tom Orange', 'Analyst', '2021-10-30', NULL, 95),
(23, 'Uma Purple', 'Developer', '2019-11-05', '2023-04-20', 70),
(24, 'Victor Pink', 'Support', '2022-12-15', NULL, 65),
(25, 'Wendy Grey', 'Sales', '2018-01-10', NULL, 90);

INSERT INTO Payments (PaymentID, EmployeeID, PaymentDate, PaymentAmount, PaymentType) VALUES
(1, 1, '2023-01-01', 300.00, 'Travel'),(28, 1, '2023-01-02', 3000.00, 'Salary'),
(2, 2, '2023-01-15', 2000.00, 'Salary'),
(3, 3, '2023-01-15', 2500.00, 'Salary'),
(4, 4, '2023-01-15', 1500.00, 'Salary'),
(5, 5, '2023-01-15', 2200.00, 'Salary'),
(6, 6, '2023-01-15', 3000.00, 'Salary'),
(26, 6, '2023-01-15', 3000.00, 'Salary'),
(7, 7, '2023-01-15', 2000.00, 'Salary'),
(8, 8, '2023-01-15', 2500.00, 'Salary'),
(9, 9, '2023-01-15', 1500.00, 'Salary'),
(27, 9, '2023-01-15', 1500.00, 'Salary'),
(10, 10, '2023-01-15', 2200.00, 'Salary'),
(11, 3, '2023-12-25', 250.00, 'Travel'),
(29, 3, '2023-12-01', 2500.00, 'Salary'),
(12, 8, '2023-02-15', 2500.00, 'Salary'),
(13, 11, '2023-01-15', 3000.00, 'Salary'),
(14, 12, '2023-01-15', 2000.00, 'Salary'),
(15, 13, '2023-01-15', 2500.00, 'Salary'),
(16, 14, '2023-01-15', 1500.00, 'Salary'),
(17, 15, '2023-01-15', 2200.00, 'Salary'),
(18, 16, '2023-01-15', 3000.00, 'Salary'),
(19, 17, '2023-01-15', 2000.00, 'Salary'),
(20, 18, '2023-01-15', 2500.00, 'Salary'),
(21, 19, '2023-01-15', 1500.00, 'Salary'),
(22, 20, '2023-01-15', 2200.00, 'Salary'),
(23, 21, '2023-01-15', 3000.00, 'Salary'),
(24, 22, '2023-01-15', 2000.00, 'Salary'),
(25, 23, '2023-01-01', 2500.00, 'Salary');

--IDENTIFY MISSING PAYMENTS
SELECT e.EmployeeID, e.EmployeeName, p.PaymentDate, p.PaymentAmount
FROM Employees e
LEFT JOIN Payments p ON e.EmployeeID = p.EmployeeID
WHERE p.PaymentID IS NULL;

--DUPLICATE PAYMENTS
SELECT p1.EmployeeID, e.EmployeeName, p1.PaymentDate, p1.PaymentAmount
FROM Payments p1
JOIN Payments p2 ON p1.EmployeeID = p2.EmployeeID AND p1.PaymentDate = p2.PaymentDate AND p1.PaymentID <> p2.PaymentID
JOIN Employees e ON p1.EmployeeID = e.EmployeeID;

--PAYMENT AFTER TERMINATION
SELECT p.EmployeeID, e.EmployeeName, p.PaymentDate, p.PaymentAmount
FROM Payments p
JOIN Employees e ON p.EmployeeID = e.EmployeeID
WHERE e.DateOfTermination IS NOT NULL AND p.PaymentDate > e.DateOfTermination;

--Payment for Travel During Public Holidays - Flag
CREATE TABLE PublicHolidays (
    HolidayDate DATE PRIMARY KEY,
    HolidayName VARCHAR(100)
);

INSERT INTO PublicHolidays (HolidayDate, HolidayName) VALUES
('2023-01-01', 'New Year'),
('2023-12-25', 'Christmas');

SELECT p.EmployeeID, e.EmployeeName, p.PaymentDate, p.PaymentAmount,
CASE 
    WHEN ph.HolidayDate IS NOT NULL THEN 'Yes'
    ELSE 'No'
END AS TravelDuringHoliday
FROM Payments p
JOIN Employees e ON p.EmployeeID = e.EmployeeID
LEFT JOIN PublicHolidays ph ON p.PaymentDate = ph.HolidayDate
WHERE p.PaymentType = 'Travel';

--Bonus Calculation Based on Performance
SELECT e.EmployeeID, e.EmployeeName, e.PerformanceScore,
CASE 
    WHEN e.PerformanceScore >= 90 THEN 1000
    WHEN e.PerformanceScore >= 80 THEN 800
    WHEN e.PerformanceScore >= 70 THEN 600
    ELSE 400
END AS Bonus
FROM Employees e;

--COMBINING ALL QUERIES 
--note: run this seperately not with the rest of the code 
CREATE VIEW HR_Payroll_Dashboard AS
SELECT e.EmployeeID, e.EmployeeName, p.PaymentDate, p.PaymentAmount,
    CASE 
        WHEN p.PaymentID IS NULL THEN 'Missing Payment'
        ELSE 'No Missing Payment'
    END AS MissingPaymentFlag,
    CASE 
        WHEN dup.EmployeeID IS NOT NULL THEN 'Duplicate Payment'
        ELSE 'Not Duplicate'
    END AS DuplicatePaymentFlag,
    CASE 
        WHEN e.DateOfTermination IS NOT NULL AND p.PaymentDate > e.DateOfTermination THEN 'Payment After Termination'
        ELSE 'Still employeed'
    END AS TerminationPaymentFlag,
    CASE 
        WHEN ph.HolidayDate IS NOT NULL AND p.PaymentType = 'Travel' THEN 'Travel During Holiday - Reimbursed'
        ELSE 'no flag'
    END AS HolidayTravelFlag,
    CASE 
        WHEN e.PerformanceScore >= 90 THEN 1000
        WHEN e.PerformanceScore >= 80 THEN 800
        WHEN e.PerformanceScore >= 70 THEN 600
        ELSE 400
    END AS Bonus
FROM Employees e
LEFT JOIN Payments p ON e.EmployeeID = p.EmployeeID
LEFT JOIN PublicHolidays ph ON p.PaymentDate = ph.HolidayDate
LEFT JOIN (
    SELECT p1.EmployeeID, p1.PaymentDate, p1.PaymentAmount
    FROM Payments p1
    JOIN Payments p2 ON p1.EmployeeID = p2.EmployeeID AND p1.PaymentDate = p2.PaymentDate AND p1.PaymentID <> p2.PaymentID
) dup ON e.EmployeeID = dup.EmployeeID AND p.PaymentDate = dup.PaymentDate;

SELECT * FROM HR_Payroll_Dashboard;

-- Save the view as a table
SELECT * INTO HR_Payroll_Dashboard_Table FROM HR_Payroll_Dashboard;
