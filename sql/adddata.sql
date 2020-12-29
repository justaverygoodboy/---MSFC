INSERT INTO support VALUES ('001','微软','608030'),
('002','谷歌','611030'),
('003','苹果','501413'),
('004','脸书','354311');

INSERT INTO ftype VALUES ('01','办公家具'),
('02','户外家具'),
('03','客厅家具'),
('04','卧室家具'),
('05','卫浴家具'),
('06','厨卫家具');

INSERT INTO customer VALUES ('0001','小红','女','13566775423'),
('0002','张华','男','13455323433'),
('0003','李玉','女','13677996589'),
('0004','李冲','男','13979903975'),
('0005','张蓉','女','13231232333'),
('0006','小芳','女','13677882323');

INSERT INTO furnit VALUES ('jj0001','沙发',5000,3,'03','001'),
('jj0002','床',1000,2,'04','001'),
('jj0003','茶几',500,1,'03','002'),
('jj0004','椅子',300,5,'03','003'),
('jj0005','办公桌',500,2,'01','002');

INSERT INTO inbound VALUES ('jh0001','001','jj0001',1,4000,'2020-03-05',4000),
('jh0002','002','jj0002',2,800,'2020-03-05');

INSERT INTO outbound VALUES ('xs0001','0001','jj0001',1,5000,'2020-03-06',5000),
('xs0002','0002','jj0002',2,1000,'2020-03-05');


DELIMITER $$
CREATE TRIGGER `ib_tr` AFTER INSERT
ON `inbound` FOR EACH ROW
BEGIN
    SET @furID = NEW.`fur_id`;
    SET @ibAmount = NEW.`ib_amount`;
    UPDATE `furnit` SET `fur_amount` = `fur_amount` + @ibAmount
    WHERE `fur_id` = @furID;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `ob_tr` BEFORE INSERT 
ON `outbound` FOR EACH ROW
BEGIN
  SET @furID = NEW.`fur_id`;
  SET @obAmount = NEW.`ob_amount`;
  SELECT `fur_amount` INTO @furAmount FROM `furnit` WHERE `fur_id`=@furID;
  IF @furAmount-@obAmount>=0 THEN
    UPDATE `furnit` SET `fur_amount` = `fur_amount` - @obAmount
    WHERE `fur_id` = @furID;
  ELSE
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "not enough amount";
  END iF;
END$$
DELIMITER ;