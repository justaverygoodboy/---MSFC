use furniture;

DROP TABLE IF EXISTS `support`;
CREATE TABLE `support` (
  `sup_id` varchar(30) NOT NULL,
  `sup_name` varchar(30) NOT NULL,
  `sup_tel` varchar(30) NOT NULL UNIQUE,

  PRIMARY KEY(`sup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ftype`; 
CREATE TABLE `ftype` (
  `type_id` varchar(30) NOT NULL,
  `type_name` varchar(30) NOT NULL,

  PRIMARY KEY(`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `cus_id` varchar(30) NOT NULL,
  `cus_name` varchar(30) NOT NULL,
  `cus_sex` varchar(10) DEFAULT NULL,
  `cus_tel` varchar(30) NOT NULL UNIQUE,

  PRIMARY KEY(`cus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `furnit`;
CREATE TABLE `furnit` (
  `fur_id` varchar(30) NOT NULL,
  `fur_name` varchar(30) NOT NULL,
  `fur_price` float NOT NULL,
  `fur_amount` int(10) NOT NULL,
  `type_id` varchar(30) NOT NULL,
  `sup_id` varchar(30) NOT NULL,
  
  PRIMARY KEY(`fur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `inbound`;
CREATE TABLE `inbound` (
  `ib_order` varchar(30) NOT NULL,
  `sup_id` varchar(30) NOT NULL,
  `fur_id` varchar(30) NOT NULL,
  `ib_amount` int(10) NOT NULL,
  `ib_price` float NOT NULL,
  `ib_date` date NOT NULL,
  
  PRIMARY KEY(`ib_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `outbound`;
CREATE TABLE `outbound` (
  `ob_order` varchar(30) NOT NULL,
  `cus_id` varchar(30) NOT NULL,
  `fur_id` varchar(30) NOT NULL,
  `ob_amount` int(10) NOT NULL,
  `ob_price` float NOT NULL,
  `ob_date` date NOT NULL,

  PRIMARY KEY(`ob_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


