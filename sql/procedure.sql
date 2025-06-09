DELIMITER //

CREATE PROCEDURE GetUserPayments(IN uid INT)
BEGIN
  SELECT p.* FROM payments p
  JOIN enrollments e ON e.id = p.enrollment_id
  WHERE e.user_id = uid;
END //

DELIMITER ;
