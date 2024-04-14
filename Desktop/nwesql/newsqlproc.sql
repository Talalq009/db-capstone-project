delimiter //
create procedure CheckBooking(date1 date,tableno int)
begin
declare BookingStatus varchar(255);
declare coun int;
select count(BookingID) into coun from bookings where BookingDate = date1 and TableNo = tableno;
if(coun > 0) then set BookingStatus = concat('Table ', tableno, ' is allready booked');
else set BookingStatus = concat('Table ', tableno, ' is available');
end if;
select BookingStatus;
end //
delimiter ;


call CheckBooking('2022-12-12', 50);

delimiter //
create procedure AddValidBooking(date1 date,tableno int)
begin
declare BookingStatus varchar(255);
declare coun int;
start transaction;
select count(BookingID) into coun from bookings where BookingDate = date1 and TableNo = tableno;
if(coun > 0) then set BookingStatus = concat('Table ', tableno, ' is allready booked - booking cancelled');
rollback;
else set BookingStatus = concat('Table ', tableno, ' is available');
commit;
end if;
select BookingStatus;
end //
delimiter ;

call AddValidBooking('2022-10-12', 19);

delimiter //
create procedure AddBooking(BID int, Tableno int, CID int, date2 date)
begin
declare confirmation varchar(255);
set confirmation = "New booking added";
insert into bookings values(BID, Tableno, CID, date2);
select confirmation;
end //
delimiter ;


call AddBooking(7, 19, 5, '2022-11-01');

delimiter //
create procedure UpdateBooking(BID int, date2 date)
begin
declare confirmation varchar(255);
set confirmation = concat('Booking ', BID, ' updated');
update bookings
set BookingDate = date2
where BookingID = BID;
select confirmation;
end //
delimiter ;


call UpdateBooking(7, '2022-12-17');

delimiter //
create procedure CancelBooking(BID int)
begin
declare confirmation varchar(255);
set confirmation = concat('Booking ', BID, ' Cancelled');
delete from bookings
where BookingID = BID;
select confirmation;
end //
delimiter ;

call CancelBooking(7);