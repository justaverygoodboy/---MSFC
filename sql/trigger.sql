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