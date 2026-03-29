Create database Ola;
use Ola;
-- Q1.
select * from ola_data;
create view successful_bookings as
select * from ola_data
where Booking_Status = "Success";

-- Q2. 
create view average_ride_distance as
select Vehicle_Type, avg(Ride_Distance) as average_distance
from ola_data
group by Vehicle_Type;

-- Q3
create view total_number_of_cancelled_rides_by_customers as
select count(*)
from ola_data
where Booking_Status="Canceled by Customer";
-- Q4
create view highest_number_of_rides as
select Customer_ID, count(Booking_ID) as Total_number_ride
from ola_data
group by Customer_ID
order by Total_number_ride desc
limit 5;
-- Q5
create view cancelled_by_drivers_due_to_personal_and_car_related as
select count(*) from ola_data
where Canceled_Rides_by_Driver = "Personal & Car related issue";

-- Q6
create view max_min_Driver_Ratings as
select max(Driver_ratings) as Maximum_Ratings, min(Driver_ratings) as Minimum_Ratings
from ola_data
where Vehicle_Type = "Prime Sedan";

-- Q7
create view All_Rides_using_UPI as
select *
from ola_data
where Payment_Method = "UPI";

-- Q8

create View Average_Customer_Rating as
select Vehicle_Type, avg(Customer_Rating) as Average_Customer
from ola_data
group by Vehicle_Type;

-- 1. Retrieve all successful bookings:

select * from successful_bookings;

-- 2. Find the average ride distance for each vehicle type:

select * from average_ride_distance;

-- 3. Get the total number of cancelled rides by customers:

select * from total_number_of_cancelled_rides_by_customers;

-- 4. List the top 5 customers who booked the highest number of rides:

select * from highest_number_of_rides;

-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

select * from cancelled_by_drivers_due_to_personal_and_car_related;

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

select * from max_min_Driver_Ratings;

-- 7. Retrieve all rides where payment was made using UPI:

select * from All_Rides_using_UPI;

-- 8. Find the average customer rating per vehicle type:

select * from Average_Customer_Rating;

-- 9. Calculate the total booking value of rides completed successfully:

select sum(Booking_value) as Total_Booking_value
from ola_data
where Booking_Status = "Success";

-- 10. List all incomplete rides along with the reason

select Booking_Id, Incomplete_Rides_Reason from ola_data
where Incomplete_Rides = "Yes";
