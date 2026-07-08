
CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(45) DEFAULT NULL,
  `product_category` varchar(45) DEFAULT NULL,
  `product_cost` decimal(10,2) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `stores` (
  `store_id` int NOT NULL,
  `store_name` varchar(45) DEFAULT NULL,
  `store_city` varchar(45) DEFAULT NULL,
  `store_location` varchar(45) DEFAULT NULL,
  `store_open_date` date DEFAULT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `calendar` (
  `date` date NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE sales (
    sale_id INT NOT NULL,
    date DATE DEFAULT NULL,
    store_id INT DEFAULT NULL,
    product_id INT DEFAULT NULL,
    units INT DEFAULT NULL,
    PRIMARY KEY (sale_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `inventory` (
  `store_id` int NOT NULL,
  `product_id` int NOT NULL,
  `stock_on_hand` int DEFAULT NULL,
  PRIMARY KEY (`store_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




