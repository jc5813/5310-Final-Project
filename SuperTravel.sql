
CREATE TABLE User_Info (
    User_ID      	int,
	U_FirstName     varchar(20) NOT NULL,
    U_LastName      varchar(20) NOT NULL,
    U_Email         varchar(50) NOT NULL, 
	U_Password		varchar(20) NOT NULL,
	U_Address		varchar(100) NOT NULL,
	U_Phone			varchar(15) NOT NULL,
	PRIMARY KEY (User_ID)
);

CREATE TABLE Booking_Info (
    Booking_ID		int,
	User_ID		    int,
	BookingDate		timestamp,
	Status			ENUM ('confirmed', 'canceled','pending'),
    PRIMARY KEY (Booking_ID),
    FOREIGN KEY (User_ID) REFERENCES User_Info (User_ID)
);

CREATE TABLE Flight_Info (
    Flight_ID			int,
   	Booking_ID			int,
	Passenger_ID		int,
	Leg_ID				int,
	FlightType			ENUM (‘AirAsia’,’Air_India’,’GO_FIRST”, ‘Indigo’,’SpiceJet’,’Vistara’),
	PRIMARY KEY (Flight_ID),
   	FOREIGN KEY (Booking_ID) REFERENCES Booking_Info (Booking_ID),
	FOREIGN KEY (Passenger_ID) REFERENCES Flight_Passenger_Info (Passenger_ID),
	FOREIGN KEY (Leg_ID) REFERENCES FlightDetail_Info (Leg_ID)
);

CREATE TABLE FlightDetail_Info (
    Leg_ID				    int,
    LegNumber	   			smallint,
	DepartureAirport		varchar(3) NOT NULL,
	DepartureDateTime		timestamp,
	DepartureSeat			varchar(3) NOT NULL,
	ArrivalAirport			varchar(3) NOT NULL,
	ArrivalDateTime			timestamp,
	ArrivalSeat				varchar(3) NOT NULL,
	FlightPrice				numeric(8,2),
    PRIMARY KEY (Leg_ID)    
);


CREATE TABLE Flight_Passenger_Info (
    Passenger_ID		int,
	FP_FirstName       	varchar(20) NOT NULL,
    FP_LastName        	varchar(20) NOT NULL,
    FP_Email           	varchar(50) NOT NULL, 
	FP_PassportNumber	varchar(15) NOT NULL,
	PRIMARY KEY (Passenger_ID)
);




CREATE TABLE CarRentalCompany_Info (
    RentalCompany_ID		int,
    CRC_Name			    varchar(100) NOT NULL,
	CRC_FirstName			varchar(20) NOT NULL,
	CRC_LastName	        varchar(20) NOT NULL,
	CRC_Email				varchar(50) NOT NULL,
	CRC_Phone				varchar(15) NOT NULL,
    PRIMARY KEY (RentalCompany_ID)
);

CREATE TABLE CarRental_Info (
    Rental_ID     		    int,
    RentalCompany_ID        int,
	Booking_ID				int,    
	Driver_ID				int,
	CarModel				varchar(30) NOT NULL,
	NumberofSeat			smallint,
	PickupLocation		    varchar(100) NOT NULL,
	ReturnLocation          varchar(100) NOT NULL,
    PickupDateTime			timestamp,
	ReturnDateTime			timestamp,
	CR_PricePerDay			numeric(8,2),
    PRIMARY KEY (Rental_ID),
    FOREIGN KEY (RentalCompany_ID) REFERENCES CarRentalCompany_Info (RentalCompany_ID),
	FOREIGN KEY (Booking_ID) REFERENCES Booking_Info (Booking_ID),
	FOREIGN KEY (Driver_ID) REFERENCES Driver_Info (Driver_ID)
);


CREATE TABLE Driver_Info (
    Driver_ID				int,
    DriverAge				int,
	DriverLiscense			varchar(20) NOT NULL,
	D_FirstName		        varchar(20) NOT NULL,
	D_LastName				varchar(20) NOT NULL,
    PRIMARY KEY (Driver_ID)
);



CREATE TABLE HotelGuest_Info (
    Guest_ID				int,
    NumberOfGuest			int,
	HaveChildren			boolean,
	PRIMARY KEY (Guest_ID)
);


CREATE TABLE Room_Info (
    Room_ID 	  	 int,
    Guest_ID		 int,   
	Hotel_ID		 int,
	Booking_ID	     int,
	RoomType    	 ENUM (‘King’, ‘Double’, ‘Suite’),
	RoomArea	 	 numeric(6,2),
	RoomCapacity	 int,
 	CityView	  	 boolean,	
	NonSmoking	  	 boolean,	
	CheckInDateTime	 timestamp,
	CheckOutDateTime timestamp,
	R_PricePerNight  numeric(8,2),
    PRIMARY KEY (Room_ID),
	FOREIGN KEY (Guest_ID) REFERENCES HotelGuest_Info (Guest_ID),
	FOREIGN KEY (Hotel_ID) REFERENCES Hotel_Info (Hotel_ID),
	FOREIGN KEY (Booking_ID) REFERENCES Booking_Info (Booking_ID)
);

CREATE TABLE HotelChain_Info (
    Chain_ID     		    int,
	ChainName				varchar(100) NOT NULL,
	HC_ContactPerson		varchar(50) NOT NULL,
	HC_ContactEmail         varchar(50) NOT NULL,
	HC_ContactPhone			varchar(15) NOT NULL,
    PRIMARY KEY (Chain_ID)
);


CREATE TABLE Hotel_Info (
    Hotel_ID     		    int,
    Chain_ID    		    int,
	HotelName				varchar(100) NOT NULL,
	HotelStar		    	smallint,
	HotelLocation			varchar(100) NOT NULL,
    PRIMARY KEY (Hotel_ID),
    FOREIGN KEY (Chain_ID) REFERENCES HotelChain_Info (Chain_ID)
);


CREATE TABLE Payment_Info (
    Payment_ID     		    int,
    Booking_ID				int,    
	PaymentMethod		    ENUM ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Third Party') ,
    PaymentDateTime			timestamp,
	PRIMARY KEY (Payment_ID),
    FOREIGN KEY (Booking_ID) REFERENCES Booking_Info (Booking_ID)
	
);	



CREATE TABLE Review_Info (
    Review_ID     		    int,
  	Booking_ID				int,    
	User_ID					int,
	ReviewRating			smallint,
	ReviewComment		    varchar(1000) NOT NULL,
    ReviewDate				timestamp,
    PRIMARY KEY (Review_ID),
    FOREIGN KEY (User_ID) REFERENCES User_Info (User_ID),
	FOREIGN KEY (Booking_ID) REFERENCES Booking_Info (Booking_ID)
);

CREATE TABLE HotelAmenity_Info (
    Amenity_ID			    int,
    Hotel_ID    			int,
	FitnessCenter			boolean,
	FreeParking    			boolean,
	AirportShuttle			boolean,
	Laundry					boolean,
	PetFriendly				boolean,
	Pool					boolean,
	Bar						boolean,
    PRIMARY KEY (Amenity_ID),
    FOREIGN KEY (Hotel_ID) REFERENCES Hotel_Info (Hotel_ID)
);