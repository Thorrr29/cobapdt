DELIMITER //

CREATE TRIGGER AfterPayment
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
  UPDATE enrollments
  SET status = 'paid'
  WHERE id = NEW.enrollment_id;
END //

DELIMITER ;
