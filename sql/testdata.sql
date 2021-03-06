-- Test Data for MyDataServlet
INSERT INTO users VALUES ('0', 'eggert@cs.ucla.edu', 'Paul', 'Eggert', 1234);

-- INSERT INTO max_hub_id VALUES (0);
-- INSERT INTO max_node_id VALUES (0);
-- INSERT INTO max_pin_id VALUES (0);


INSERT INTO hubs VALUES (0, 'iPhone Isaac', 'api_key_isaac', 5678, '0');
INSERT INTO hubs VALUES (1, 'iPhone Sang', 'api_key_sang', 1234, '0');
INSERT INTO hubs VALUES (2, 'XBee Hub', 'api_key_xbee', 1991, '0');

INSERT INTO max_hub_id VALUES (2);
---INSERT INTO nodes VALUES (0, 'Air Conditioner', '0013a200', '40315568', '0', 0);
-- INSERT INTO pins VALUES (0, 'Air Conditioner Pin', 'control_V', 0);

-- INSERT INTO max_node_id VALUES (1);

INSERT INTO nodes VALUES (1, 'Isaac''s iPhone', '1', '1', '31415926', 0);
INSERT INTO pins  VALUES (1, 'Isaac''s Bluetooth Sensor', 'sensor_M', '31415926', 1);
INSERT INTO pins  VALUES (5, 'Isaac''s iBeacon ID', 'static_ID', '15440', 1);
INSERT INTO pins  VALUES (2, 'Isaac: Reminder for Sang', 'control_R', 'SuperSectretMessageForIsaac', 1);

INSERT INTO nodes VALUES (3, 'Sang''s iPhone', '3', '3', '53589793', 1);
INSERT INTO pins  VALUES (3, 'Sang''s Bluetooth Sensor', 'sensor_M', '53589793', 3);
INSERT INTO pins  VALUES (6, 'Sang''s iBeacon ID', 'static_ID', '5496', 3);
INSERT INTO pins  VALUES (4, 'Sang: Reminder for Isaac', 'control_R', 'SuperSectretMessageForSang', 3);
INSERT INTO pins  VALUES (7, 'Sang: Reminder for Ryan', 'control_R', 'KindaSectretMessageForRyan', 3);

INSERT INTO nodes VALUES (0, 'Desk Lamp', '0013a200', '40315565', '1', 2);
INSERT INTO pins  VALUES (0, 'Desk Lamp', 'control_B', '1', 0);

INSERT INTO max_node_id VALUES (4);
INSERT INTO max_pin_id VALUES (7);

-- INSERT INTO recipes VALUES (0, 3, 'SINGLE', 'Sang->Isaac_BT0', -1);
-- INSERT INTO ingredients VALUES (2, '=', '0', 'receivedZero', FALSE, 0);

-- INSERT INTO recipes VALUES (1, 3, 'SINGLE', 'Sang->Isaac_BT1', -1);
-- INSERT INTO ingredients VALUES(2, '=', '1', 'receivedOne', FALSE, 1);

-- INSERT INTO recipes VALUES (2, 1, 'SINLGE', 'Isaac->Sang_BT2', -1);
-- INSERT INTO ingredients VALUES (4, '=', '0', 'receivedZero', FALSE, 2);

-- INSERT INTO recipes VALUES (3, 1, 'SINGLE', 'Isaac->Sang_BT3', -1);
-- INSERT INTO ingredients VALUES(4, '=', '1', 'receivedOne', FALSE, 3);

-- INSERT INTO recipes VALUES (8, 3, 'SINGLE', 'Ryan->Sang_BT1', -1);
-- INSERT INTO ingredients VALUES(7, '=', '5749', '1', FALSE, 8);

-- lamp automation
INSERT INTO recipes VALUES (0, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES (0, '=', '0', '0', FALSE, 0);

INSERT INTO recipes VALUES (1, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES(0, '=', '1', '1', FALSE, 1);

INSERT INTO recipes VALUES (2, 3, 'SINGLE', 'Isaac->Sang_BT0', -1);
INSERT INTO ingredients VALUES (0, '=', '0', '0', FALSE, 2);

INSERT INTO recipes VALUES (3, 3, 'SINGLE', 'Isaac->Sang_BT1', -1);
INSERT INTO ingredients VALUES(0, '=', '15440', '1', FALSE, 3);

INSERT INTO max_recipe_id VALUES(3);
-- INSERT INTO tags VALUES ('lamp', 0);
-- INSERT INTO tags VALUES ('light', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:23:53', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 10:52:07', '1', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-29 12:32:38', '0', 0);
-- INSERT INTO pin_data VALUES (TIMESTAMP '2013-5-30 12:32:38', '1', 1);

-- Test Data for TestLampServlet
--INSERT INTO test_lamps VALUES (1, now(), 0);
--INSERT INTO test_lamps VALUES (2, now(), 1);