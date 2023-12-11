--1.Total hotel price by Location and Hotel Name: 
SELECT hi.HotelName,
	   hi.Hotellocation,
	   SUM(age(ri.CheckInDateTime, ri.CheckOutDateTime)*ri.R_PricePerNight) AS total_hotel_prices
FROM Hotel_Info hi
INNER JOIN Room_Info ri on hi.Hotel_ID = ri.Hotel_ID
GROUP BY hi.HotelName,
	   hi.Hotellocation
ORDER BY total_hotel_prices DESC;

--2.Flight price by Flight type

SELECT fi.FlightType,
	   SUM(fdi.FlightPrice) AS total_flight_prices
FROM Flight_Info fi
INNER JOIN FlightDetail_Info fdi on fi.Leg_ID = fdi.Leg_ID
GROUP BY fi.FlightType
ORDER BY total_flight_prices DESC;

--3.Rental price by Rental company name, pick, and return location
SELECT cri.CRC_Name,
	   ci.PickupLocation,
	   ci.ReturnLocation,
	   SUM(age(ci.PickupDateTime, ci.ReturnDateTime)*ci.CR_PricePerDay) AS total_rental_price
FROM CarRental_Info ci
INNER JOIN CarRentalCompany_Info cri on ci.RentalCompany_ID = cri.RentalCompany_ID
GROUP BY cri.CRC_Name,
	   ci.PickupLocation,
	   ci.ReturnLocation
ORDER BY total_rental_price DESC;

--4.Yearly/Monthly Sales Trend for each Flight, Rental, or Hotel
SELECT EXTRACT(MONTH FROM ci.PickupDateTime) AS Rental_transaction_month,
       EXTRACT(YEAR FROM ci.PickupDateTime) AS Rental_transaction_year,
       SUM(age(ci.PickupDateTime, ci.ReturnDateTime)*ci.CR_PricePerDay) AS total_rental_tranaction_sales
FROM CarRental_Info AS ci
GROUP BY  Rental_transaction_month,
       Rental_transaction_year
ORDER BY  Rental_transaction_month,
       Rental_transaction_year,
	   total_rental_tranaction_sales DESC;

--5.Current Customer Purchase Trend for each Flight, Rental, or Hotel
SELECT EXTRACT(MONTH FROM ci.PickupDateTime) AS Rental_transaction_month,
       EXTRACT(YEAR FROM ci.PickupDateTime) AS Rental_transaction_year,
	   di.D_FirstName,
	   di.D_LastName,
       SUM(age(ci.PickupDateTime, ci.ReturnDateTime)*ci.CR_PricePerDay) AS total_rental_tranaction_sales
FROM CarRental_Info AS ci
INNER JOIN Driver_Info AS di on ci.Driver_ID = di.Driver_ID
GROUP BY  Rental_transaction_month,
       Rental_transaction_year,
	   di.D_FirstName,
	   di.D_LastName
ORDER BY  Rental_transaction_month,
       Rental_transaction_year,
	   total_rental_tranaction_sales DESC;



--6.Review Rating related to the length of the comment

SELECT CASE
           WHEN ReviewRating >= 1 AND ReviewRating <= 2 THEN '1-2'
           WHEN ReviewRating > 2  AND ReviewRating <= 3 THEN '2-3'
           WHEN ReviewRating > 3  AND ReviewRating <= 4 THEN '3-4'
           WHEN ReviewRating > 4  AND ReviewRating <= 5 THEN '4-5'
           ELSE '>5 or <1'
       END AS ReviewRating_Range,
	   length(ReviewComment) as lenghofthecomment,
       COUNT(DISTINCT Review_ID) AS NumberofReviewID
FROM Review_Info

GROUP BY ReviewRating_Range
	     ,lenghofthecomment
ORDER BY ReviewRating_Range;



--7.Calculate the number of amenities in each hotel name
SELECT hai.FitnessCenter,
	hai.FreeParking,
	hai.AirportShuttle,
	hai.Laundry,
	hai.PetFriendly,
	hai.Pool,
	hai.Bar,
	hi.HotelName,
	COUNT(DISTINCT hai.Amenity_ID) AS TotalAmenitycount
FROM HotelAmenitiy_Info hai
INNER JOIN Hotel_Info hi on hai.Hotel_ID = hi.Hotel_ID
GROUP BY hai.FitnessCenter,
	hai.FreeParking,
	hai.AirportShuttle,
	hai.Laundry,
	hai.PetFriendly,
	hai.Pool,
	hai.Bar,
	hi.HotelName
ORDER BY TotalAmenitycount DESC;



--8.Hotel review and Hotel star relationship
SELECT hi.HotelName,
	   AVG(ri.ReviewRating),
	   AVG(hi.HotelStar)
FROM public.Review_Info ri
INNER JOIN Room_Info rmi on ri.Booking_ID = rmi.Booking_ID
INNER JOIN Hotel_Info hi on hi.Hotel_ID = rmi.Hotel_ID
GROUP BY hi.HotelName;






--9.Total number of Payment methods based on the year
SELECT PaymentMethod, 
	   DATE_PART('year', PaymentDateTime) AS PaymentDateTime_Year,
       COUNT(PaymentMethod) AS total_Number_paymentMethod
FROM Payment_Info 
GROUP BY PaymentMethod, PaymentDateTime_Year
ORDER BY PaymentDateTime_Year;



--10.Stay hotel, rent a car, or flight seat whether the customer has children or not
SELECT hgi.Guest_ID,
	  AGE(CheckInDateTime,CheckOutDateTime) AS total_num_stay
FROM HotelGuest_Info hgi
INNER JOIN Room_Info ri on hgi.Guest_ID = ri.Guest_ID
WHERE hgi.HaveChildren = 'yes';







