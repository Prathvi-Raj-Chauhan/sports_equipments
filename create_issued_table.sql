-- SQL command to create the issued table for Sports Equipment Management System

CREATE TABLE IF NOT EXISTS issued (
    issue_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_name VARCHAR(255) NOT NULL,
    student_roll VARCHAR(50) NOT NULL,
    issue_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    return_date DATETIME NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'pending',
    quantity INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_student_roll (student_roll),
    INDEX idx_equipment_name (equipment_name),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Optional: Add foreign key constraints if you have related tables
-- ALTER TABLE issued ADD CONSTRAINT fk_equipment 
--     FOREIGN KEY (equipment_name) REFERENCES equipments(name) ON DELETE CASCADE;
-- 
-- ALTER TABLE issued ADD CONSTRAINT fk_student 
--     FOREIGN KEY (student_roll) REFERENCES students(roll_no) ON DELETE CASCADE;

