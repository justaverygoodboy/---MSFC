DELIMITER $
CREATE PROCEDURE period_io(IN `start_io_date` DATE,IN `end_io_date` DATE)
BEGIN
  SELECT a.`fur_id`,CAST(SUM(ob_amount) AS CHAR(10)) AS total_out,CAST(SUM(ib_amount) AS CHAR(10)) AS total_in FROM `furnit` a,`inbound` b,`outbound` c
  WHERE (a.`fur_id` = b.`fur_id` AND a.`fur_id` = c.`fur_id`) 
  AND b.`ib_date` BETWEEN start_io_date AND end_io_date
  AND c.`ob_date` BETWEEN start_io_date AND end_io_date
  GROUP BY a.`fur_id`
  UNION
  SELECT a.`fur_id`,`ob_amount` AS total_out,0 AS total_in
  FROM `outbound` a
  WHERE NOT EXISTS(SELECT b.`fur_id` FROM `inbound` b WHERE a.`fur_id`=b.`fur_id`) AND `ob_date` BETWEEN start_io_date AND end_io_date
  UNION
  SELECT a.`fur_id`,0 AS total_out,`ib_amount` AS total_in
  FROM `inbound` a
  WHERE NOT EXISTS(SELECT b.`fur_id` FROM `outbound` b WHERE a.`fur_id`=b.`fur_id`) AND `ib_date` BETWEEN start_io_date AND end_io_date;
END$
DELIMITER ;