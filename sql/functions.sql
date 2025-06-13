DELIMITER //

CREATE FUNCTION TotalPaidByCourse(uid INT, cid INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
  DECLARE total DECIMAL(10,2);
  SELECT SUM(p.amount) INTO total
  FROM payments p
  JOIN enrollments e ON e.id = p.enrollment_id
  WHERE e.user_id = uid AND e.course_id = cid;
  RETURN IFNULL(total, 0);
END //

DELIMITER ;
