CREATE TABLE Customer
  (CustNo VARCHAR(8) NOT NULL, 
   CustName VARCHAR(30) NOT NULL, 
   Address VARCHAR(50) NOT NULL, 
   Internal CHAR(1) NOT NULL, 
   Contact VARCHAR(35) NOT NULL, 
   Phone VARCHAR(11) NOT NULL, 
   City VARCHAR(30) NOT NULL,
   State VARCHAR(2) NOT NULL, 
   Zip VARCHAR(10) NOT NULL,
   PRIMARY KEY (CustNo) ) ;
CREATE TABLE Facility
  (FacNo VARCHAR(8) NOT NULL, 
   FacName VARCHAR(30) NOT NULL,
   PRIMARY KEY (FacNo),
   UNIQUE(FacName));
CREATE TABLE Location
  (LocNo VARCHAR(8) NOT NULL, 
   FacNo VARCHAR(8) NOT NULL, 
   LocName VARCHAR(30) NOT NULL,
   PRIMARY KEY (LocNo),
   FOREIGN KEY (FacNo) REFERENCES FACILITY (FacNo) );
CREATE TABLE Employee
  (EmpNo VARCHAR(8) NOT NULL,
   EmpName VARCHAR(30) NOT NULL,
   Department VARCHAR(30) NOT NULL,
   Email VARCHAR(50) NOT NULL,
   Phone VARCHAR(10) NOT NULL,
   PRIMARY KEY (EmpNo)
  );
 CREATE TABLE ResourceTbl
   (ResNo VARCHAR(8) NOT NULL,
    ResName VARCHAR(30) NOT NULL,
    Rate DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ResNo),
    CHECK (Rate>0)
   );
CREATE TABLE EventRequest
  (EventNo VARCHAR(8) NOT NULL,
   DateHeld DATE NOT NULL,
   DateReq DATE NOT NULL,
   FacNo VARCHAR(8) NOT NULL,
   CustNo VARCHAR(8) NOT NULL,
   DateAuth DATE,
   Status VARCHAR(30) NOT NULL,
   EstCost DECIMAL(10,2) NOT NULL,
   EstAudience VARCHAR(10) NOT NULL,
   BudNo VARCHAR(8),
   PRIMARY KEY (EventNo),
   FOREIGN KEY (CustNo) REFERENCES Customer(CustNo),
   FOREIGN KEY (FacNo) REFERENCES Facility(FacNo),
   CHECK (Status IN ("Pending","Denied","Approved")),
   CHECK (EstAudience > 0)
  );
CREATE TABLE EventPlan
	(PlanNo VARCHAR(8) NOT NULL,
    EventNo VARCHAR(8) NOT NULL,
    WorkDate DATE NOT NULL,
    Notes VARCHAR(30),
    Activity VARCHAR(20) NOT NULL,
    EmpNo VARCHAR(8),
    PRIMARY KEY (PlanNo),
    FOREIGN KEY (EventNo) REFERENCES EventRequest(EventNo),
    FOREIGN KEY (EmpNo) REFERENCES Employee(EmpNo)
    );
CREATE TABLE EventPlanLine
	(PlanNo VARCHAR(8) NOT NULL,
    LineNo INT NOT NULL,
    TimeStart DATETIME NOT NULL,
    TimeEnd DATETIME NOT NULL,
    NumberFld INT NOT NULL,
    LocNo VARCHAR(8) NOT NULL,
    ResNo VARCHAR(8) NOT NULL,
    PRIMARY KEY (PlanNo, LineNo),
    FOREIGN KEY (PlanNo) REFERENCES EventPlan(PlanNo),
    FOREIGN KEY (LocNo) REFERENCES Location(LocNo),
    FOREIGN KEY (ResNo) REFERENCES ResourceTbl(ResNo),
    CHECK (TimeStart < TimeEnd)
    );

Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E100','Chuck Coordinator','Administration','chuck@colorado.edu','3-1111');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E101','Mary Manager','Football','mary@colorado.edu','5-1111');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E102','Sally Supervisor','Planning','sally@colorado.edu','3-2222');
Insert into EMPLOYEE (EMPNO,EMPNAME,DEPARTMENT,EMAIL,PHONE) values ('E103','Alan Administrator','Administration','alan@colorado.edu','3-3333');

Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C100','Football','Box 352200','Y','Mary Manager','6857100','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C101','Men''s Basketball','Box 352400','Y','Sally Supervisor','5431700','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C103','Baseball','Box 352020','Y','Bill Baseball','5431234','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C104','Women''s Softball','Box 351200','Y','Sue Softball','5434321','Boulder','CO','80309');
Insert into CUSTOMER (CUSTNO,CUSTNAME,ADDRESS,INTERNAL,CONTACT,PHONE,CITY,STATE,ZIP) values ('C105','High School Football','123 AnyStreet','N','Coach Bob','4441234','Louisville','CO','80027');

Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R100','attendant',10);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R101','police',15);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R102','usher',10);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R103','nurse',20);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R104','janitor',15);
Insert into RESOURCETBL (RESNO,RESNAME,RATE) values ('R105','food service',10);

Insert into FACILITY (FACNO,FACNAME) values ('F100','Football stadium');
Insert into FACILITY (FACNO,FACNAME) values ('F101','Basketball arena');
Insert into FACILITY (FACNO,FACNAME) values ('F102','Baseball field');
Insert into FACILITY (FACNO,FACNAME) values ('F103','Recreation room');

Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L100','F100','Locker room');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L101','F100','Plaza');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L102','F100','Vehicle gate');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L103','F101','Locker room');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L104','F100','Ticket Booth');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L105','F101','Gate');
Insert into LOCATION (LOCNO,FACNO,LOCNAME) values ('L106','F100','Pedestrian gate');

Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E100',str_to_date('25,OCT,18','%d,%b,%y'),str_to_date('06,JUN,18','%d,%b,%y'),'C100','F100',str_to_date('08,JUN,18','%d,%b,%y'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E101',str_to_date('26,OCT,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C100','F100',null,'Pending',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E103',str_to_date('21,SEP,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C100','F100',str_to_date('01,AUG,18','%d,%b,%y'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E102',str_to_date('14,SEP,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C100','F100',str_to_date('31,JUL,18','%d,%b,%y'),'Approved',5000,80000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E104',str_to_date('03,DEC,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C101','F101',str_to_date('31,JUL,18','%d,%b,%y'),'Approved',2000,12000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E105',str_to_date('05,DEC,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C101','F101',str_to_date('01,AUG,18','%d,%b,%y'),'Approved',2000,10000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E106',str_to_date('12,DEC,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C101','F101',str_to_date('31,JUL,18','%d,%b,%y'),'Approved',2000,10000,'B1000');
Insert into EVENTREQUEST (EVENTNO,DATEHELD,DATEREQ,CUSTNO,FACNO,DATEAUTH,STATUS,ESTCOST,ESTAUDIENCE,BUDNO) values ('E107',str_to_date('23,NOV,18','%d,%b,%y'),str_to_date('28,JUL,18','%d,%b,%y'),'C105','F100',str_to_date('31,JUL,18','%d,%b,%y'),'Denied',10000,5000,null);


Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P100','E100',str_to_date('25,OCT,18','%d,%b,%y'),'Standard operation','Operation','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P101','E104',str_to_date('03,DEC,18','%d,%b,%y'),'Watch for gate crashers','Operation','E100');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P102','E105',str_to_date('05,DEC,18','%d,%b,%y'),'Standard operation','Operation','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P103','E106',str_to_date('12,DEC,18','%d,%b,%y'),'Watch for seat switching','Operation',null);
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P104','E101',str_to_date('26,OCT,18','%d,%b,%y'),'Standard cleanup','Cleanup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P105','E100',str_to_date('25,OCT,18','%d,%b,%y'),'Light cleanup','Cleanup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P199','E102',str_to_date('10,DEC,18','%d,%b,%y'),'ABC','Operation','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P299','E101',str_to_date('26,OCT,18','%d,%b,%y'),null,'Operation','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P349','E106',str_to_date('12,DEC,18','%d,%b,%y'),null,'Setup','E101');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P85','E100',str_to_date('25,OCT,18','%d,%b,%y'),'Standard operation','Cleanup','E102');
Insert into EVENTPLAN (PLANNO,EVENTNO,WORKDATE,NOTES,ACTIVITY,EMPNO) values ('P95','E101',str_to_date('26,OCT,18','%d,%b,%y'),'Extra security','Cleanup','E102');

Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',1, str_to_date('25,OCT,18 8:00:00','%d,%b,%y %H:%i:%s'), str_to_date('25,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),2,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',2, str_to_date('25,OCT,18 12:00:00','%d,%b,%y %H:%i:%s'),str_to_date('25,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'), 2,'L101','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',3, str_to_date('25,OCT,18 7:00:00','%d,%b,%y %H:%i:%s'), str_to_date('25,OCT,18 16:30:00','%d,%b,%y %H:%i:%s'), 1,'L102','R102');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P100',4, str_to_date('25,OCT,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('25,OCT,18 22:00:00','%d,%b,%y %H:%i:%s'),2,'L100','R102');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',1, str_to_date('3,DEC,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('3,DEC,18 20:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',2, str_to_date('3,DEC,18 18:30:00','%d,%b,%y %H:%i:%s'),str_to_date('3,DEC,18 19:00:00','%d,%b,%y %H:%i:%s'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P101',3, str_to_date('3,DEC,18 19:00:00','%d,%b,%y %H:%i:%s'),str_to_date('3,DEC,18 20:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',1, str_to_date('5,DEC,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('5,DEC,18 19:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',2, str_to_date('5,DEC,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('5,DEC,18 21:00:00','%d,%b,%y %H:%i:%s'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P102',3, str_to_date('5,DEC,18 19:00:00','%d,%b,%y %H:%i:%s'),str_to_date('5,DEC,18 22:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',1, str_to_date('12,DEC,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('12,DEC,18 21:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',2, str_to_date('12,DEC,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('12,DEC,18 21:00:00','%d,%b,%y %H:%i:%s'),4,'L105','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P103',3, str_to_date('12,DEC,18 19:00:00','%d,%b,%y %H:%i:%s'),str_to_date('12,DEC,18 22:00:00','%d,%b,%y %H:%i:%s'),2,'L103','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P104',1, str_to_date('26,OCT,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('26,OCT,18 22:00:00','%d,%b,%y %H:%i:%s'),4,'L101','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P104',2, str_to_date('26,OCT,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('26,OCT,18 22:00:00','%d,%b,%y %H:%i:%s'),4,'L100','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P105',1, str_to_date('25,OCT,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('25,OCT,18 22:00:00','%d,%b,%y %H:%i:%s'),4,'L101','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P105',2, str_to_date('25,OCT,18 18:00:00','%d,%b,%y %H:%i:%s'),str_to_date('25,OCT,18 22:00:00','%d,%b,%y %H:%i:%s'),4,'L100','R104');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P199',1, str_to_date('10,DEC,18 8:00:00','%d,%b,%y %H:%i:%s'), str_to_date('10,DEC,18 12:00:00','%d,%b,%y %H:%i:%s'),1,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P349',1, str_to_date('12,DEC,18 12:00:00','%d,%b,%y %H:%i:%s'),str_to_date('12,DEC,18 15:30:00','%d,%b,%y %H:%i:%s'),1,'L103','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',1,  str_to_date('25,OCT,18 9:00:00','%d,%b,%y %H:%i:%s'), str_to_date('25,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),5,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',2,  str_to_date('25,OCT,18 8:00:00','%d,%b,%y %H:%i:%s'), str_to_date('25,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),2,'L102','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P85',3, str_to_date('25,OCT,18 10:00:00','%d,%b,%y %H:%i:%s'), str_to_date('25,OCT,18 15:00:00','%d,%b,%y %H:%i:%s'),3,'L104','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',1, str_to_date('26,OCT,18 8:00:00','%d,%b,%y %H:%i:%s'),  str_to_date('26,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),4,'L100','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',2, str_to_date('26,OCT,18 9:00:00','%d,%b,%y %H:%i:%s'),  str_to_date('26,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),4,'L102','R101');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',3, str_to_date('26,OCT,18 10:00:00','%d,%b,%y %H:%i:%s'), str_to_date('26,OCT,18 15:00:00','%d,%b,%y %H:%i:%s'),4,'L106','R100');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',4, str_to_date('26,OCT,18 13:00:00','%d,%b,%y %H:%i:%s'), str_to_date('26,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),2,'L100','R103');
Insert into EVENTPLANLINE (PLANNO,LINENO,TIMESTART,TIMEEND,NUMBERFLD,LOCNO,RESNO) values ('P95',5, str_to_date('26,OCT,18 13:00:00','%d,%b,%y %H:%i:%s'), str_to_date('26,OCT,18 17:00:00','%d,%b,%y %H:%i:%s'),2,'L101','R104');