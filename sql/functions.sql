DELIMITER //

CREATE FUNCTION TotalPaid(uid INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(p.amount) INTO total
  FROM payments p
  JOIN enrollments e ON e.id = p.enrollment_id
  WHERE e.user_id = uid;
  RETURN IFNULL(total, 0);
END //

DELIMITER ;
