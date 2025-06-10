ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_course
FOREIGN KEY (course_id) REFERENCES courses(id);

ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollments_user
FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE payments
ADD CONSTRAINT fk_payments_enrollment
FOREIGN KEY (enrollment_id) REFERENCES enrollments(id);

ALTER TABLE enrollments
ADD COLUMN name VARCHAR(20),
ADD COLUMN no_hp VARCHAR(18);

