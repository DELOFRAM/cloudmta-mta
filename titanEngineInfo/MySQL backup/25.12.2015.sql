-- Adminer 4.2.2 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `_3dtexts`;
CREATE TABLE `_3dtexts` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `vw` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `text` text,
  `r` int(11) NOT NULL DEFAULT '255',
  `g` int(11) NOT NULL DEFAULT '255',
  `b` int(11) NOT NULL DEFAULT '255',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_3dtexts` (`ID`, `x`, `y`, `z`, `vw`, `int`, `text`, `r`, `g`, `b`) VALUES
(3,	1554.62,	-1675.2,	16.1953,	0,	0,	'** Budynek w trakcie remontu. **',	255,	255,	255),
(5,	1942.49,	-1792.12,	13.3828,	0,	0,	'* To jedyny dystrybutor który działa w całym mieście hehe. *',	255,	0,	0);

DROP TABLE IF EXISTS `_anims`;
CREATE TABLE `_anims` (
  `uid` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `animlib` varchar(45) NOT NULL,
  `animname` varchar(45) NOT NULL,
  `loop` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `freeze` tinyint(2) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=36;

INSERT INTO `_anims` (`uid`, `name`, `animlib`, `animname`, `loop`, `freeze`) VALUES
(1,	'idz1',	'PED',	'WALK_gang1',	1,	1),
(2,	'idz2',	'PED',	'WALK_gang2',	1,	1),
(3,	'idz3',	'PED',	'WOMAN_walksexy',	1,	1),
(4,	'idz4',	'PED',	'WOMAN_walkfatold',	1,	1),
(5,	'idz5',	'PED',	'Walk_Wuzi',	1,	1),
(6,	'idz6',	'PED',	'WALK_player',	1,	1),
(7,	'stopani',	'CARRY',	'crry_prtial',	0,	0),
(8,	'pa',	'KISSING',	'gfwave2',	0,	0),
(9,	'zmeczony',	'PED',	'IDLE_tired',	1,	0),
(10,	'umyjrece',	'INT_HOUSE',	'wash_up',	0,	0),
(11,	'medyk',	'MEDIC',	'CPR',	0,	0),
(12,	'ranny',	'SWEET',	'Sweet_injuredloop',	1,	1),
(13,	'salutuj',	'ON_LOOKERS',	'lkup_in',	0,	1),
(14,	'wtf',	'RIOT',	'RIOT_ANGRY',	0,	1),
(15,	'spoko',	'GANGS',	'prtial_gngtlkD',	0,	0),
(16,	'napad',	'SHOP',	'ROB_Loop_Threat',	1,	0),
(17,	'krzeslo',	'ped',	'SEAT_idle',	1,	1),
(18,	'szukaj',	'COP_AMBIENT',	'Copbrowse_loop',	1,	0),
(19,	'lornetka',	'ON_LOOKERS',	'shout_loop',	1,	0),
(20,	'oh',	'MISC',	'plyr_shkhead',	0,	0),
(21,	'oh2',	'OTB',	'wtchrace_lose',	0,	0),
(22,	'wyciagnij',	'FOOD',	'SHP_Tray_Lift',	0,	0),
(23,	'zdziwiony',	'PED',	'facsurp',	0,	1),
(24,	'recemaska',	'POLICE',	'crm_drgbst_01',	1,	1),
(25,	'krzeslojem',	'FOOD',	'FF_Sit_Eat1',	1,	0),
(26,	'gogo',	'RIOT',	'RIOT_CHANT',	1,	1),
(27,	'czekam',	'GRAVEYARD',	'prst_loopa',	1,	1),
(28,	'garda',	'FIGHT_D',	'FightD_IDLE',	1,	1),
(29,	'barman2',	'BAR',	'BARman_idle',	0,	0),
(30,	'fotel',	'INT_HOUSE',	'LOU_Loop',	1,	1),
(31,	'napraw',	'CAR',	'Fixn_Car_Loop',	1,	1),
(32,	'barman',	'BAR',	'Barserve_loop',	1,	0),
(33,	'opieraj',	'GANGS',	'leanIDLE',	0,	1),
(34,	'bar.nalej',	'BAR',	'Barserve_glass',	0,	0),
(35,	'ramiona',	'COP_AMBIENT',	'Coplook_loop',	1,	1),
(36,	'bar.wez',	'BAR',	'Barserve_bottle',	0,	0),
(37,	'chowaj',	'ped',	'cower',	1,	0),
(38,	'wez',	'BAR',	'Barserve_give',	0,	0),
(39,	'fuck',	'ped',	'fucku',	0,	0),
(40,	'klepnij',	'SWEET',	'sweet_ass_slap',	0,	0),
(41,	'cmon',	'RYDER',	'RYD_Beckon_01',	0,	0),
(42,	'daj',	'DEALER',	'DEALER_DEAL',	0,	0),
(43,	'pij',	'VENDING',	'VEND_Drink2_P',	1,	1),
(44,	'start',	'CAR',	'flag_drop',	0,	0),
(45,	'karta',	'HEIST9',	'Use_SwipeCard',	0,	0),
(46,	'spray',	'GRAFFITI',	'spraycan_fire',	1,	0),
(47,	'odejdz',	'POLICE',	'CopTraf_Left',	0,	0),
(48,	'fotelk',	'JST_BUISNESS',	'girl_02',	1,	1),
(49,	'chodz',	'POLICE',	'CopTraf_Come',	0,	0),
(50,	'stop',	'POLICE',	'CopTraf_Stop',	0,	0),
(51,	'drapjaja',	'MISC',	'Scratchballs_01',	1,	0),
(52,	'opieraj2',	'MISC',	'Plyrlean_loop',	1,	0),
(53,	'walekonia',	'PAULNMAC',	'wank_loop',	1,	0),
(54,	'popchnij',	'GANGS',	'shake_cara',	0,	0),
(55,	'rzuc',	'GRENADE',	'WEAPON_throwu',	0,	0),
(56,	'rap1',	'RAPPING',	'RAP_A_Loop',	1,	0),
(57,	'rap2',	'RAPPING',	'RAP_C_Loop',	1,	0),
(58,	'rap3',	'RAPPING',	'RAP_B_Loop',	1,	0),
(59,	'rap4',	'GANGS',	'prtial_gngtlkH',	1,	1),
(60,	'glowka',	'WAYFARER',	'WF_Fwd',	0,	0),
(61,	'skop',	'FIGHT_D',	'FightD_G',	0,	0),
(62,	'siad',	'BEACH',	'ParkSit_M_loop',	1,	0),
(63,	'krzeslo2',	'FOOD',	'FF_Sit_Loop',	1,	0),
(64,	'krzeslo3',	'INT_OFFICE',	'OFF_Sit_Idle_Loop',	1,	0),
(65,	'krzeslo4',	'INT_OFFICE',	'OFF_Sit_Bored_Loop',	1,	0),
(66,	'krzeslo5',	'INT_OFFICE',	'OFF_Sit_Type_Loop',	1,	0),
(67,	'padnij',	'PED',	'KO_shot_front',	0,	1),
(68,	'padaczka',	'PED',	'FLOOR_hit_f',	1,	0),
(69,	'unik',	'PED',	'EV_dive',	0,	1),
(70,	'crack',	'CRACK',	'crckdeth2',	1,	0),
(71,	'bomb',	'BOMBER',	'BOM_Plant',	0,	0),
(72,	'cpaj',	'SHOP',	'ROB_Shifty',	0,	0),
(73,	'rece',	'ROB_BANK',	'SHP_HandsUp_Scr',	0,	1),
(78,	'tancz5',	'STRIP',	'STR_Loop_A',	1,	0),
(79,	'pijak',	'PED',	'WALK_DRUNK',	1,	1),
(80,	'nie',	'GANGS',	'Invite_No',	0,	0),
(81,	'lokiec',	'CAR',	'Sit_relaxed',	1,	1),
(82,	'go',	'RIOT',	'RIOT_PUNCHES',	0,	0),
(83,	'stack1',	'GHANDS',	'gsign2LH',	0,	0),
(84,	'lez3',	'BEACH',	'ParkSit_W_loop',	1,	0),
(85,	'lez1',	'BEACH',	'bather',	1,	0),
(86,	'lez2',	'BEACH',	'Lay_Bac_Loop',	1,	0),
(87,	'padnij2',	'PED',	'KO_skid_front',	0,	1),
(88,	'bat',	'CRACK',	'Bbalbat_Idle_01',	1,	1),
(89,	'bat2',	'CRACK',	'Bbalbat_Idle_02',	0,	1),
(90,	'stack2',	'GHANDS',	'gsign2',	0,	1),
(91,	'stack3',	'GHANDS',	'gsign4',	0,	1),
(92,	'taichi',	'PARK',	'Tai_Chi_Loop',	1,	0),
(93,	'kosz1',	'BSKTBALL',	'BBALL_idleloop',	1,	0),
(94,	'kosz2',	'BSKTBALL',	'BBALL_Jump_Shot',	0,	0),
(95,	'kosz3',	'BSKTBALL',	'BBALL_pickup',	0,	0),
(96,	'kosz4',	'BSKTBALL',	'BBALL_def_loop',	1,	0),
(97,	'kosz5',	'BSKTBALL',	'BBALL_Dnk',	0,	0),
(98,	'papieros',	'SMOKING',	'M_smklean_loop',	1,	0),
(99,	'wymiotuj',	'FOOD',	'EAT_Vomit_P',	0,	0),
(100,	'fuck2',	'RIOT',	'RIOT_FUKU',	0,	0),
(101,	'koks',	'PED',	'IDLE_HBHB',	1,	1),
(102,	'idz7',	'PED',	'WOMAN_walkshop',	1,	1),
(103,	'cry',	'GRAVEYARD',	'mrnF_loop',	1,	1),
(104,	'rozciagaj',	'PLAYIDLES',	'stretch',	0,	0),
(107,	'bagaznik',	'POOL',	'POOL_Place_White',	0,	1),
(108,	'wywaz',	'GANGS',	'shake_carK',	0,	0),
(109,	'skradajsie',	'PED',	'Player_Sneak',	1,	1),
(110,	'przycisk',	'CRIB',	'CRIB_use_switch',	0,	0),
(111,	'tancz6',	'DANCING',	'DAN_down_A',	1,	0),
(112,	'tancz7',	'DANCING',	'DAN_left_A',	1,	0),
(113,	'idz8',	'PED',	'walk_shuffle',	1,	1),
(114,	'stack4',	'LOWRIDER',	'prtial_gngtlkB',	0,	0),
(115,	'stack5',	'LOWRIDER',	'prtial_gngtlkC',	0,	1),
(116,	'stack6',	'lowrider',	'prtial_gngtlkD',	0,	0),
(117,	'stack7',	'lowrider',	'prtial_gngtlkE',	0,	0),
(118,	'stack8',	'lowrider',	'prtial_gngtlkF',	0,	0),
(119,	'stack9',	'lowrider',	'prtial_gngtlkG',	0,	0),
(120,	'stack10',	'lowrider',	'prtial_gngtlkH',	0,	1),
(121,	'tancz8',	'DANCING',	'dnce_m_d',	1,	0),
(122,	'kasjer',	'INT_SHOP',	'shop_cashier',	0,	0),
(123,	'idz9',	'wuzi',	'wuzi_walk',	1,	1),
(124,	'taxi',	'misc',	'hiker_pose',	0,	1),
(125,	'wskaz',	'on_lookers',	'pointup_loop',	0,	1),
(126,	'wskaz2',	'on_lookers',	'point_loop',	0,	1),
(127,	'podpisz',	'otb',	'betslp_loop',	0,	0);

DROP TABLE IF EXISTS `_arrests`;
CREATE TABLE `_arrests` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `interior` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `int` int(11) NOT NULL,
  `dim` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `_blockades`;
CREATE TABLE `_blockades` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `model` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_blockades` (`ID`, `name`, `model`) VALUES
(1,	'Pachołek',	1238),
(2,	'Objazd',	1425),
(3,	'Droga',	3578),
(4,	'Barykada',	1282),
(5,	'Barierka',	1434),
(6,	'Zapora',	1459),
(7,	'Płotek',	1424),
(8,	'Taśma Crime Scene',	1282),
(9,	'Barierka nowa',	1424);

DROP TABLE IF EXISTS `_buses`;
CREATE TABLE `_buses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `objectID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_buses` (`ID`, `name`, `objectID`) VALUES
(6,	'Pershing Square',	109),
(7,	'Unity Station',	110),
(8,	'Downtown',	111),
(10,	'Centrum market',	113);

DROP TABLE IF EXISTS `_characters`;
CREATE TABLE `_characters` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID postaci',
  `memberID` bigint(20) NOT NULL COMMENT 'ID usera',
  `name` varchar(20) NOT NULL COMMENT 'Imię',
  `lastname` varchar(20) NOT NULL COMMENT 'Nazwisko',
  `shortDNA` varchar(4) NOT NULL,
  `DNA` varchar(255) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '100' COMMENT 'HP',
  `skin` int(11) NOT NULL COMMENT 'Skin',
  `defaultSkin` int(11) NOT NULL COMMENT 'Default Skin',
  `x` float NOT NULL COMMENT 'Koord. x',
  `y` float NOT NULL COMMENT 'Koord. y',
  `z` float NOT NULL COMMENT 'Koord. z',
  `angle` float NOT NULL COMMENT 'Kąt zwrotu',
  `dimension` int(11) NOT NULL DEFAULT '0' COMMENT 'Wymiar',
  `interior` int(11) NOT NULL DEFAULT '0' COMMENT 'Interior',
  `money` bigint(20) NOT NULL DEFAULT '5000' COMMENT 'Pieniądze',
  `accountID` bigint(20) NOT NULL,
  `accountMoney` bigint(20) NOT NULL,
  `bwTime` int(11) NOT NULL DEFAULT '0' COMMENT 'BW',
  `ajTime` int(11) NOT NULL DEFAULT '0' COMMENT 'AJ',
  `onlineTime` int(11) NOT NULL DEFAULT '0' COMMENT 'Czas online',
  `afkTime` int(11) NOT NULL DEFAULT '0' COMMENT 'AFK',
  `arrestTime` int(11) NOT NULL DEFAULT '0',
  `arrestData` int(11) NOT NULL DEFAULT '0',
  `sex` int(11) NOT NULL DEFAULT '1' COMMENT 'Płeć',
  `inGame` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'W grze',
  `lastVisit` int(11) NOT NULL,
  `blocked` tinyint(2) NOT NULL DEFAULT '0',
  `hide` int(11) NOT NULL DEFAULT '0',
  `dob` date NOT NULL DEFAULT '1975-01-01',
  `vehBlock` int(11) NOT NULL DEFAULT '0',
  `runBlock` int(11) NOT NULL DEFAULT '0',
  `oocBlock` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1820;

INSERT INTO `_characters` (`ID`, `memberID`, `name`, `lastname`, `shortDNA`, `DNA`, `hp`, `skin`, `defaultSkin`, `x`, `y`, `z`, `angle`, `dimension`, `interior`, `money`, `accountID`, `accountMoney`, `bwTime`, `ajTime`, `onlineTime`, `afkTime`, `arrestTime`, `arrestData`, `sex`, `inGame`, `lastVisit`, `blocked`, `hide`, `dob`, `vehBlock`, `runBlock`, `oocBlock`) VALUES
(1,	1,	'Jeremy',	'Simons',	'64A9',	'51dbf7cf8c684c0e288ed866eb764445',	89,	60,	60,	1789.4,	-1853.61,	13.4141,	94.0856,	0,	0,	18998973,	6517585149695,	3847,	0,	0,	451741,	472975,	0,	0,	1,	1,	1451042174,	0,	0,	'1975-01-01',	0,	0,	0),
(2,	2,	'Joachim',	'Caraway',	'4J9A',	'5284btfakovtsk63842cgbajurf693ge',	3,	60,	60,	1665.36,	-1731.47,	13.1555,	85.8462,	0,	0,	4000,	8419224704602,	0,	0,	0,	16119,	11389,	0,	0,	1,	0,	1450627721,	0,	0,	'1975-01-01',	0,	0,	0),
(15,	3,	'Brody',	'Reyes',	'JBG0',	'2a2c25578a29f0267eaaf6e2d3c011c2',	39,	60,	60,	2893.16,	-1625.92,	11.0546,	175.007,	0,	0,	29914,	1270937396866,	10000000,	0,	0,	67028,	81867,	0,	0,	1,	0,	1450624223,	0,	0,	'1975-01-01',	0,	0,	0),
(16,	4,	'John',	'Hinkley',	'1TSA',	'7yn26t82rzmc1i5y7fj6qc8qmsy21b6c',	10,	60,	60,	1065.82,	-1327.82,	13.0953,	1.1868,	0,	0,	0,	0,	0,	0,	0,	6796,	5520,	0,	0,	1,	0,	1448303883,	0,	0,	'1975-01-01',	0,	0,	0),
(17,	5,	'Ryan',	'Rogers',	'O8XF',	'f2b61aa79c5ebd38c5fedf0e0a8fb35d',	25,	60,	60,	1945.56,	-1772.76,	19.525,	274.5,	0,	0,	0,	0,	0,	0,	0,	899,	16,	0,	0,	1,	0,	1448468905,	0,	0,	'1975-01-01',	0,	0,	0),
(18,	6,	'Joseph',	'Farmer',	'74WD',	'9904180b88a2eb69f8415557f985db0b',	34,	60,	60,	1726.88,	-1842.79,	18.1486,	290.738,	0,	0,	1900,	0,	0,	0,	0,	16273,	8857,	0,	0,	1,	0,	1449692575,	0,	0,	'1975-01-01',	0,	0,	0),
(19,	7,	'Jason',	'Werner',	'RA9D',	'45712a7d8cd0f4d16ebdf7e76bacee69',	45,	280,	60,	1930,	-1779.29,	13.5469,	277.884,	0,	0,	5,	0,	0,	0,	0,	4091,	10200,	0,	0,	1,	1,	1450961045,	0,	0,	'1975-01-01',	0,	0,	0),
(20,	8,	'Raymond',	'Knox',	'DI6J',	'68ef68358c7e99209507ee045e77de0a',	48,	299,	60,	1536.84,	-1683.94,	13.5469,	166.954,	0,	0,	99989,	0,	0,	0,	0,	16688,	9795,	0,	0,	1,	1,	1450630235,	0,	0,	'1975-01-01',	0,	0,	0),
(21,	9,	'Thomas',	'Klein',	'PBC2',	'4299b0a2a55e861fcf7441a6d0fb5c6c',	42,	60,	60,	1549.43,	-1289.4,	16.5347,	250.632,	0,	0,	4981,	0,	0,	0,	0,	5864,	6694,	0,	0,	1,	0,	1450723505,	0,	0,	'1975-01-01',	0,	0,	0),
(22,	10,	'Timothy',	'Harris',	'8M5W',	'5a470b6b91988acb015a5e7877c6598a',	37,	60,	60,	672.704,	-1155.64,	15.4305,	291.266,	0,	0,	697891,	8939682268617,	100,	0,	0,	2156,	3653,	0,	0,	1,	0,	1451040217,	0,	0,	'1975-01-01',	0,	0,	0),
(23,	1,	'David',	'Marion',	'887R',	'86fe484bb361780dfcfe3d150a863403',	100,	60,	60,	0,	0,	0,	0,	0,	0,	5000,	0,	0,	0,	0,	0,	0,	0,	0,	1,	0,	0,	1,	0,	'1975-01-01',	0,	0,	0);

DROP TABLE IF EXISTS `_clothes`;
CREATE TABLE `_clothes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `shopID` int(11) NOT NULL,
  `skinID` int(11) NOT NULL,
  `skinName` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461;

INSERT INTO `_clothes` (`ID`, `shopID`, `skinID`, `skinName`, `price`) VALUES
(1,	10,	60,	'Koszula w kratkÄ™',	252),
(2,	10,	17,	'Rambo',	5764),
(3,	10,	22,	'Murzynek bambo',	1);

DROP TABLE IF EXISTS `_corpses`;
CREATE TABLE `_corpses` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `DNA` varchar(255) NOT NULL,
  `killerDNA` varchar(255) NOT NULL,
  `killTime` int(11) NOT NULL,
  `weaponID` int(11) NOT NULL,
  `weaponData` varchar(32) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_corpses` (`ID`, `name`, `DNA`, `killerDNA`, `killTime`, `weaponID`, `weaponData`, `location`) VALUES
(1,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'51dbf7cf8c684c0e288ed866eb764445',	1446596502,	24,	'VM8T57K',	'Commerce'),
(3,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'n/d',	1450018912,	63,	'Zabity przez Wybuch w aucie',	'Santa Flora'),
(4,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'n/d',	1450019082,	63,	'Zabity przez Wybuch w aucie',	'Santa Flora'),
(5,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'n/d',	1450019156,	63,	'Zabity przez Wybuch w aucie',	'Santa Flora'),
(6,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'2a2c25578a29f0267eaaf6e2d3c011c2',	1450019231,	24,	'CKJJ3WF',	'Santa Flora'),
(7,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'2a2c25578a29f0267eaaf6e2d3c011c2',	1450019309,	24,	'CKJJ3WF',	'Santa Flora'),
(8,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'n/d',	1450019756,	63,	'Zabity przez Wybuch w aucie',	'El Corona'),
(9,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'n/d',	1450019806,	63,	'Zabity przez Wybuch w aucie',	'El Corona'),
(10,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'2a2c25578a29f0267eaaf6e2d3c011c2',	1450037880,	24,	'CKJJ3WF',	'Idlewood'),
(11,	'Brody Reyes',	'2a2c25578a29f0267eaaf6e2d3c011c2',	'n/d',	1450039378,	63,	'Zabity przez Wybuch w aucie',	'Bayside'),
(12,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'68ef68358c7e99209507ee045e77de0a',	1450044263,	24,	'7JCW46J',	'El Corona'),
(13,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'4299b0a2a55e861fcf7441a6d0fb5c6c',	1450113536,	24,	'FST9OIN',	'El Corona'),
(14,	'Thomas Klein',	'4299b0a2a55e861fcf7441a6d0fb5c6c',	'n/d',	1450120599,	54,	'Zabity przez Upadek',	'El Corona'),
(15,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'5a470b6b91988acb015a5e7877c6598a',	1450638520,	24,	'PHDSOTB',	'Idlewood'),
(16,	'Jeremy Simons',	'51dbf7cf8c684c0e288ed866eb764445',	'4299b0a2a55e861fcf7441a6d0fb5c6c',	1450720603,	24,	'GCHZCLT',	'Downtown Los Santos'),
(17,	'Jason Werner',	'45712a7d8cd0f4d16ebdf7e76bacee69',	'51dbf7cf8c684c0e288ed866eb764445',	1450956668,	24,	'ALSCO9G',	'Idlewood');

DROP TABLE IF EXISTS `_delivers`;
CREATE TABLE `_delivers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `intID` int(11) NOT NULL,
  `pieces` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  `orderType` int(11) NOT NULL DEFAULT '1',
  `deliverGroup` int(11) NOT NULL,
  `deliverID` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `cost` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192;

INSERT INTO `_delivers` (`ID`, `intID`, `pieces`, `data`, `name`, `orderType`, `deliverGroup`, `deliverID`, `time`, `cost`) VALUES
(2,	1,	100,	'[ { \"itemName\": \"Amunicja: Beretta 92FS\", \"itemType\": 2, \"itemVal1\": 24, \"itemVal2\": 35, \"itemVal3\": \"LSPD\", \"itemVolume\": 2 } ]',	'Los Santos Police Department',	1,	0,	0,	0,	0);

DROP TABLE IF EXISTS `_deposite`;
CREATE TABLE `_deposite` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `intID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `itemType` int(11) NOT NULL,
  `itemVal1` int(11) NOT NULL,
  `itemVal2` int(11) NOT NULL,
  `itemVal3` varchar(255) NOT NULL,
  `itemVolume` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_deposite` (`ID`, `intID`, `name`, `stock`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(2,	1,	'Beretta 92FS',	48,	1,	24,	35,	'LSPD',	2),
(3,	1,	'Beretta 92FS',	99,	1,	24,	35,	'LSPD',	2);

DROP TABLE IF EXISTS `_doors`;
CREATE TABLE `_doors` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerType` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1638;

INSERT INTO `_doors` (`ID`, `name`, `ownerType`, `owner`, `dimension`) VALUES
(1,	'Los Santos Police Department - GĹ‚Ăłwny Interior',	2,	1,	1),
(5,	'All Saints General Hospital',	2,	1,	2),
(7,	'Dom: Jeremy Simons',	1,	2,	3),
(8,	'Szychu test',	1,	1,	4),
(9,	'24/7 #1',	0,	0,	5),
(10,	'Ciucholand',	0,	0,	6),
(11,	'Department of Motor Vehicles',	2,	5,	7),
(12,	'Los Santos Wehrmacht Department',	2,	6,	8),
(13,	'LSG',	2,	2,	9),
(14,	'Drzwi ELESPEDE',	2,	1,	10),
(15,	'Szychu dom',	1,	2,	11),
(16,	'Szychu',	1,	1,	12),
(17,	'Szychu',	1,	1,	13),
(18,	'Stacja benzynowa',	0,	0,	14),
(19,	'Los Santos Bank',	3,	0,	15);

DROP TABLE IF EXISTS `_doorspickup`;
CREATE TABLE `_doorspickup` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `parentID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `inX` float NOT NULL,
  `inY` float NOT NULL,
  `inZ` float NOT NULL,
  `outX` float NOT NULL,
  `outY` float NOT NULL,
  `outZ` float NOT NULL,
  `inDim` int(11) NOT NULL,
  `outDim` int(11) NOT NULL,
  `inInt` int(11) NOT NULL,
  `outInt` int(11) NOT NULL,
  `outModel` int(11) NOT NULL,
  `inModel` int(11) NOT NULL,
  `inAngle` float NOT NULL,
  `outAngle` float NOT NULL,
  `locked` int(11) NOT NULL,
  `vehpass` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2048;

INSERT INTO `_doorspickup` (`ID`, `parentID`, `name`, `inX`, `inY`, `inZ`, `outX`, `outY`, `outZ`, `inDim`, `outDim`, `inInt`, `outInt`, `outModel`, `inModel`, `inAngle`, `outAngle`, `locked`, `vehpass`) VALUES
(1,	1,	'Los Santos Police Department',	238.741,	139.413,	1003.02,	1554.66,	-1675.45,	16.1953,	1,	0,	3,	0,	1239,	1318,	352.889,	85.3953,	0,	0),
(7,	5,	'Drzwi do szpitala',	1194.41,	-1325.02,	13.3984,	1172.77,	-1323.86,	15.4009,	2,	0,	0,	0,	1239,	1318,	268.386,	268.386,	0,	0),
(8,	7,	'Dom Kubaska',	260.819,	1237.74,	1084.26,	1331.78,	-632.639,	109.135,	3,	0,	9,	0,	1239,	1318,	358.651,	16.2188,	1,	0),
(17,	9,	'Los Santos Kauflandos',	-30.9502,	-91.4111,	1003.55,	1352.34,	-1758.82,	13.5078,	5,	0,	18,	0,	1239,	1318,	355.141,	356.976,	0,	0),
(19,	10,	'Ciuchlandos',	161.507,	-96.6553,	1001.8,	1102.96,	-1440.31,	15.7969,	6,	0,	18,	0,	1239,	1318,	356.07,	264.887,	0,	0),
(20,	11,	'DMV',	-2026.88,	-104.033,	1035.17,	1081.19,	-1697.17,	13.5469,	7,	0,	3,	0,	1239,	1318,	180.357,	173.776,	0,	0),
(21,	12,	'Los Santos Wehrmacht Department',	315.939,	-143.663,	999.602,	816.104,	-1386.7,	13.6072,	8,	0,	7,	0,	1239,	1318,	0.661926,	177.094,	0,	0),
(22,	13,	'Los Santos Goverment',	390.175,	173.798,	1008.38,	1481.46,	-1771.37,	18.7958,	9,	0,	3,	0,	1239,	1318,	84.1154,	356.938,	0,	0),
(23,	15,	'Szychu dom',	867.723,	-717.066,	105.68,	867.66,	-717.096,	105.68,	11,	0,	0,	0,	1239,	1318,	154.462,	334.465,	0,	0),
(24,	18,	'Stacja benzynowa',	-27.2695,	-57.6992,	1003.55,	1929.15,	-1776.35,	13.5469,	14,	0,	6,	0,	1239,	1318,	2.43076,	268.408,	0,	0),
(25,	1,	'LSPD - garaże',	245.015,	146.721,	1003.02,	1519.78,	-1658.07,	13.5392,	1,	0,	3,	0,	1239,	1318,	92.1904,	71.2941,	0,	1),
(27,	19,	'Los Santos Bank',	2306.55,	-16.1865,	26.7496,	1465.67,	-1010.73,	26.8438,	15,	0,	0,	0,	1239,	1318,	270.99,	179.16,	0,	0);

DROP TABLE IF EXISTS `_globaldata`;
CREATE TABLE `_globaldata` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `UID` int(11) unsigned NOT NULL,
  `adminLevel` int(11) NOT NULL,
  `adminPerms` longtext NOT NULL,
  `cloudPoints` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=16384;

INSERT INTO `_globaldata` (`ID`, `UID`, `adminLevel`, `adminPerms`, `cloudPoints`) VALUES
(1,	1,	3,	'[ { \"vehicles\": true, \"aj\": true, \"manageadmins\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"bus\": true, \"arrest\": true, \"doors\": true, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"kick\": true, \"globdo\": true, \"texts\": true } ]',	2147483647),
(2,	2,	3,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"spec\": true, \"aset_money\": true, \"manageadmins\": true, \"items\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"kick\": true, \"globdo\": true, \"tele\": true, \"texts\": true } ]',	6337),
(3,	3,	3,	'[ { \"vehicles\": true, \"aj\": true, \"manageadmins\": false, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"bus\": true, \"arrest\": true, \"doors\": true, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"kick\": true, \"globdo\": true, \"texts\": true } ]',	2147483647),
(5,	5,	3,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"spec\": true, \"aset_money\": true, \"manageadmins\": true, \"items\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"kick\": true, \"globdo\": true, \"tele\": true, \"texts\": true } ]',	10),
(6,	6,	2,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"spec\": true, \"aset_money\": true, \"manageadmins\": false, \"items\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"kick\": true, \"globdo\": true, \"tele\": true, \"texts\": true } ]',	0),
(7,	7,	3,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"manageadmins\": true, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"globdo\": true, \"kick\": true, \"texts\": true } ]',	500),
(8,	8,	3,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"manageadmins\": true, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": true, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"globdo\": true, \"kick\": true, \"texts\": true } ]',	NULL),
(9,	9,	2,	'[ { \"vehicles\": true, \"aj\": true, \"doors\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": true, \"glob\": true, \"arrest\": true, \"manageadmins\": false, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": false, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"globdo\": true, \"kick\": true, \"texts\": true } ]',	50),
(10,	10,	3,	'[ { \"vehicles\": true, \"aj\": true, \"manageadmins\": true, \"orgs\": true, \"block\": true, \"aset_globaladmin\": false, \"glob\": true, \"bus\": true, \"arrest\": true, \"doors\": true, \"spec\": true, \"aset_money\": true, \"items\": true, \"masteradmin\": false, \"ban\": true, \"bw\": true, \"aset\": true, \"tele\": true, \"kick\": true, \"globdo\": true, \"texts\": true } ]',	NULL);

DROP TABLE IF EXISTS `_groups`;
CREATE TABLE `_groups` (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'UID',
  `name` varchar(64) NOT NULL COMMENT 'Nazwa grupy',
  `tag` varchar(4) NOT NULL COMMENT 'Tag',
  `r` smallint(3) NOT NULL DEFAULT '255' COMMENT 'R',
  `g` smallint(3) NOT NULL DEFAULT '255' COMMENT 'G',
  `b` smallint(3) NOT NULL DEFAULT '255' COMMENT 'B',
  `orderType` int(11) NOT NULL COMMENT 'Typ zamawiania',
  `perms` longtext NOT NULL COMMENT 'Uprawnienia',
  `cash` int(11) NOT NULL COMMENT 'GotĂłwka',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461;

INSERT INTO `_groups` (`ID`, `name`, `tag`, `r`, `g`, `b`, `orderType`, `perms`, `cash`) VALUES
(1,	'Los Santos Police Department',	'LSPD',	49,	92,	214,	1,	'[ { \"itemsteal\": true, \"chatooc\": true, \"news\": true, \"tickets\": true, \"gps\": true, \"arrest\": true, \"vehfix\": true, \"chatic\": true, \"vehblock\": true, \"cpr\": true, \"ediall\": true, \"search\": true, \"blockade\": true, \"orders\": true, \"chatdept\": true, \"phoneloc\": true, \"cduty\": true } ]',	0),
(7,	'Grupa Szychowa',	'SZYH',	201,	14,	195,	0,	'[ { \"doorram\": true, \"itemsteal\": true, \"vehplates\": true, \"chatooc\": true, \"chatdept\": true, \"mask\": true, \"orders\": true, \"offerdoc\": true, \"news\": true, \"meg\": true, \"search\": true, \"ediall\": true, \"tickets\": true, \"gym\": true, \"sdoc\": true, \"gps\": true, \"vehblock\": true, \"ladder\": true, \"carsalon\": true, \"arrest\": true, \"taxi\": true, \"tax\": true, \"chatic\": true, \"logistic\": true, \"blockade\": true, \"heal\": true, \"vehfix\": true, \"offer\": true, \"bdiall\": true, \"dtax\": true, \"phoneloc\": true, \"cpr\": true } ]',	0),
(9,	'San News',	'SNN',	167,	20,	86,	0,	'[ { \"gps\": true, \"news\": true, \"chatic\": true, \"chatooc\": true } ]',	0);

DROP TABLE IF EXISTS `_groups_members`;
CREATE TABLE `_groups_members` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `rankID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2048;

INSERT INTO `_groups_members` (`ID`, `userID`, `rankID`, `groupID`) VALUES
(1,	1,	1,	1),
(2,	6,	2,	1),
(3,	7,	2,	1),
(10,	14,	2,	1),
(12,	15,	13,	7),
(14,	2,	2,	1),
(15,	16,	2,	1),
(17,	16,	17,	9),
(18,	1,	18,	9),
(19,	15,	18,	9),
(20,	1,	14,	7),
(23,	19,	2,	1),
(24,	20,	2,	1),
(25,	18,	2,	1),
(26,	18,	18,	9),
(27,	15,	2,	1),
(28,	21,	2,	1),
(29,	22,	2,	1);

DROP TABLE IF EXISTS `_groups_ranks`;
CREATE TABLE `_groups_ranks` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `groupID` int(11) NOT NULL,
  `cash` int(11) NOT NULL,
  `defaultRank` tinyint(1) NOT NULL,
  `perms` longtext NOT NULL,
  `skin` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2730;

INSERT INTO `_groups_ranks` (`ID`, `name`, `groupID`, `cash`, `defaultRank`, `perms`, `skin`) VALUES
(1,	'Lider',	1,	0,	0,	'[{\"leader\": true}]',	0),
(2,	'Default',	1,	0,	1,	'[{\"leader\": false}]',	0),
(13,	'Lider',	7,	0,	0,	'[{\"leader\": true}]',	0),
(14,	'Default',	7,	0,	1,	'[{\"leader\": false}]',	0),
(17,	'Lider',	9,	0,	0,	'[{\"leader\": true}]',	0),
(18,	'Default',	9,	0,	1,	'[{\"leader\": false}]',	0);

DROP TABLE IF EXISTS `_intlist`;
CREATE TABLE `_intlist` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=122 ROW_FORMAT=REDUNDANT;

INSERT INTO `_intlist` (`uid`, `name`, `x`, `y`, `z`, `a`, `int`) VALUES
(1,	'24/7 [1]',	-25.8845,	-185.869,	1003.55,	0,	17),
(2,	'24/7 [2]',	-6.09118,	-29.2719,	1003.55,	0,	10),
(3,	'24/7 [3]',	-30.9467,	-89.6096,	1003.55,	0,	18),
(4,	'24/7 [4]',	-25.9075,	-141.28,	1003.55,	0,	16),
(5,	'24/7 [5]',	-27.3123,	-29.2776,	1003.55,	0,	4),
(6,	'24/7 [6]',	-26.6916,	-55.7149,	1003.55,	0,	6),
(7,	'Francis Ticket Sales Airport',	-1827.15,	7.20742,	1061.14,	0,	14),
(8,	'Francis Baggage Claim Airport',	-1855.57,	41.2632,	1061.14,	0,	14),
(9,	'Andromada Cargo Hold',	315.856,	1024.5,	1949.8,	0,	9),
(10,	'Shamal Cabin',	2.38483,	33.1034,	1199.85,	0,	1),
(11,	'Interernational Airport',	-1830.81,	16.83,	1061.14,	0,	14),
(12,	'Ammunation [1]',	286.149,	-40.6444,	1001.57,	0,	1),
(13,	'Ammunation [2]',	286.801,	-82.5476,	1001.54,	0,	4),
(14,	'Ammunation [3]',	296.92,	-108.072,	1001.57,	0,	6),
(15,	'Ammunation [4]',	314.821,	-141.432,	999.662,	0,	7),
(16,	'Ammunation [5]',	316.525,	-167.707,	999.662,	0,	6),
(17,	'Booth Ammunation',	302.293,	-143.139,	1004.06,	0,	7),
(18,	'Range Ammunation',	280.795,	-135.203,	1004.06,	0,	7),
(19,	'B Dups Apartment',	1527.05,	-12.0236,	1002.1,	0,	3),
(20,	'B Dups Crack Palace',	1523.51,	-47.8211,	1002.27,	0,	2),
(21,	'OG Locs House',	512.929,	-11.6929,	1001.57,	0,	3),
(22,	'Ryders house',	2447.87,	-1704.45,	1013.51,	0,	2),
(23,	'Sweets house',	2527.02,	-1679.21,	1015.5,	0,	1),
(24,	'Madd Doggs Mansion',	1267.84,	-776.959,	1091.91,	0,	5),
(25,	'Johnson House',	2496.05,	-1695.17,	1014.74,	0,	3),
(26,	'Angel Pine Trailer',	1.1853,	-3.2387,	999.428,	0,	2),
(27,	'Safe House',	2233.69,	-1112.81,	1050.88,	0,	5),
(28,	'Safe House 2',	2194.79,	-1204.35,	1049.02,	0,	6),
(29,	'Safe House 3',	2319.13,	-1023.96,	1050.21,	0,	9),
(30,	'Safe House 4',	2262.48,	-1138.56,	1050.63,	0,	10),
(31,	'Verdant Bluffs Safehouse',	2365.11,	-1133.08,	1050.88,	0,	8),
(32,	'Willowfield Safehouse',	2282.91,	-1138.29,	1050.9,	0,	11),
(33,	'The Camels Toe Safehouse',	2216.13,	-1076.31,	1050.48,	0,	1),
(34,	'Abandoned AC Tower',	419.894,	2537.12,	10,	0,	10),
(35,	'Burning Desire Building',	2338.32,	-1180.61,	1027.98,	0,	5),
(36,	'Colonel Furhberger',	2807.63,	-1170.15,	1025.57,	0,	8),
(37,	'Welcome Pump',	681.66,	-453.32,	-25.61,	0,	1),
(38,	'Wu Zi Mus Apartement',	-2158.72,	641.29,	1052.38,	0,	1),
(39,	'House',	234.283,	1065.23,	1084.21,	0,	6),
(40,	'Burglary House 1',	234.609,	1187.82,	1080.26,	0,	3),
(41,	'Burglary House 2',	225.571,	1240.06,	1082.14,	0,	2),
(42,	'Burglary House 3',	224.288,	1289.19,	1082.14,	0,	1),
(43,	'Burglary House 4',	239.282,	1114.2,	1080.99,	0,	5),
(44,	'Burglary House 5',	295.139,	1473.37,	1080.26,	0,	15),
(45,	'Burglary House 6',	261.116,	1287.22,	1080.26,	0,	4),
(46,	'Burglary House 7',	24.3769,	1341.18,	1084.38,	0,	10),
(47,	'Burglary House 8',	-262.176,	1456.62,	1084.37,	0,	4),
(48,	'Burglary House 9',	22.861,	1404.92,	1084.43,	0,	5),
(49,	'Burglary House 10',	140.368,	1367.88,	1083.86,	0,	5),
(50,	'Burglary House 11',	234.283,	1065.23,	1084.21,	0,	6),
(51,	'Burglary House 12',	-68.5145,	1353.85,	1080.21,	0,	6),
(52,	'Burglary House 13',	-285.251,	1471.2,	1084.38,	0,	15),
(53,	'Burglary House 14',	-42.5267,	1408.23,	1084.43,	0,	8),
(54,	'Burglary House 15',	84.9244,	1324.3,	1083.86,	0,	9),
(55,	'Burglary House 16',	260.742,	1238.23,	1084.26,	0,	9),
(56,	'Budget Inn Motel Room',	446.325,	509.966,	1001.42,	0,	12),
(57,	'Crack Den',	318.565,	1118.21,	1083.88,	0,	5),
(58,	'RC War Arena',	-1079.99,	1061.58,	1343.04,	0,	10),
(59,	'Racing Stadium',	-1395.96,	-208.197,	1051.17,	0,	7),
(60,	'Racing Stadium 2',	-1424.93,	-664.587,	1059.86,	0,	4),
(61,	'Bloodbowl Stadium',	-1394.2,	987.62,	1023.96,	0,	15),
(62,	'Kickstart Stadium',	-1410.72,	1591.16,	1052.53,	0,	14),
(63,	'Caligulas Casino',	2233.8,	1712.23,	1011.76,	0,	1),
(64,	'4 Dragons Casino',	2016.27,	1017.78,	996.875,	0,	14),
(65,	'Redsands Casino',	1132.91,	-9.7726,	1000.68,	0,	14),
(66,	'4 Dragons Managerial Suite',	2000.67,	1015.15,	39.09,	0,	11),
(67,	'Inside Track Betting',	830.602,	5.9404,	1004.18,	0,	3),
(68,	'Caligulas Roof',	2268.52,	1647.77,	1084.23,	0,	1),
(69,	'Tattoo',	-203.076,	-24.1658,	1002.27,	0,	16),
(70,	'Rusty Donut\'s',	378.026,	-190.516,	1000.63,	0,	17),
(71,	'Zero\'s RC Shop',	-2240.1,	136.973,	1035.41,	0,	6),
(72,	'Sex Shop',	-100.267,	-22.9376,	1000.72,	0,	3),
(73,	'Dillimore Gas Station',	664.19,	-570.73,	16.34,	0,	0),
(74,	'Loco Low Co.',	616.782,	-74.8151,	997.635,	0,	2),
(75,	'Wheel Arch Angels',	615.285,	-124.239,	997.635,	0,	3),
(76,	'Transfender',	617.538,	-1.99,	1000.68,	0,	1),
(77,	'Doherty Garage',	-2041.23,	178.397,	28.8465,	0,	1),
(78,	'Denises Bedroom',	245.231,	304.763,	999.148,	0,	1),
(79,	'Helena\'s Barn',	290.623,	309.062,	999.148,	0,	3),
(80,	'Barbara\'s Love Nest',	322.501,	303.691,	999.148,	0,	5),
(81,	'Katie\'s Lovenest',	269.641,	305.951,	999.148,	0,	2),
(82,	'Michelle\'s Love Nest',	306.197,	307.819,	1003.3,	0,	4),
(83,	'Millie\'s Bedroom',	344.998,	307.182,	999.156,	0,	6),
(84,	'Barber Shop',	418.467,	-80.4595,	1001.8,	0,	3),
(85,	'Pro-Laps',	206.463,	-137.708,	1003.09,	0,	3),
(86,	'Victim',	225.031,	-9.1838,	1002.22,	0,	5),
(87,	'SubUrban',	204.117,	-46.8047,	1001.8,	0,	1),
(88,	'Reece\'s Barber Shop',	414.299,	-18.8044,	1001.8,	0,	2),
(89,	'Zip',	161.405,	-94.2416,	1001.8,	0,	18),
(90,	'Didier Sachs',	204.166,	-165.768,	1000.52,	0,	14),
(91,	'Binco',	207.522,	-109.745,	1005.13,	0,	15),
(92,	'Barber Shop 2',	411.971,	-51.9217,	1001.9,	0,	12),
(93,	'Wardrobe',	256.905,	-41.6537,	1002.02,	0,	14),
(94,	'Brothel',	974.018,	-9.5937,	1001.15,	0,	3),
(95,	'Brothel 2',	961.931,	-51.9071,	1001.12,	0,	3),
(96,	'The Big Spread Ranch',	1212.08,	-28.5799,	1000.95,	0,	3),
(97,	'Dinner',	454.985,	-107.255,	999.438,	0,	5),
(98,	'World Of Coq',	445.6,	-6.9823,	1000.73,	0,	1),
(99,	'The Pig Pen',	1204.93,	-8.165,	1000.92,	0,	2),
(100,	'Club',	490.27,	-18.426,	1000.68,	0,	17),
(101,	'Jay\'s Diner',	449.017,	-88.9894,	999.555,	0,	4),
(102,	'Secret Valley Diner',	442.129,	-52.4782,	999.717,	0,	6),
(103,	'Fanny Batter\'s Whore House',	748.462,	1438.24,	1102.95,	0,	6),
(104,	'Jizzy\'s',	-2637.69,	1404.24,	906.46,	0,	3),
(105,	'Burger Shot',	365.41,	-73.6167,	1001.51,	0,	10),
(106,	'Well Stacked Pizza',	372.352,	-131.651,	1001.49,	0,	5),
(107,	'Cluckin\' Bell',	365.716,	-9.8873,	1001.85,	0,	9),
(108,	'Lil\' Probe Inn',	-227.57,	1401.55,	27.7656,	0,	18),
(109,	'Los Santos Gym',	772.11,	-3.9,	1000.73,	0,	5),
(110,	'San Fierro Gym',	771.863,	-40.5659,	1000.69,	0,	6),
(111,	'Las Venturas Gym',	774.068,	-71.8559,	1000.65,	0,	7),
(112,	'SF Police Department',	246.4,	110.84,	1003.22,	0,	10),
(113,	'LS Police Department',	246.669,	65.8039,	1003.64,	0,	6),
(114,	'LV Police Department',	288.472,	170.065,	1007.18,	0,	3),
(115,	'Planning Department',	386.526,	173.638,	1008.38,	0,	3),
(116,	'Blastin\' Fools Records',	1037.83,	0.397,	1001.28,	0,	3),
(117,	'Warehouse',	1290.41,	1.9512,	1001.02,	0,	18),
(118,	'Warehouse 2',	1411.44,	-2.7966,	1000.92,	0,	1),
(119,	'Meat Factory',	963.059,	2159.76,	1011.03,	0,	1),
(120,	'Bike School',	1494.86,	1306.48,	1093.3,	0,	3),
(121,	'Driving School',	-2031.12,	-115.829,	1035.17,	0,	3),
(122,	'Big Smoke\'s Crack Palace',	2536.53,	-1294.84,	1044.12,	0,	2),
(123,	'Atrium',	1726.18,	-1641,	20.23,	0,	18),
(124,	'Jefferson Motel',	2220.26,	-1148.01,	1025.8,	0,	15),
(125,	'Liberty City',	-750.8,	491,	1371.7,	0,	1),
(126,	'Sherman Dam',	-944.24,	1886.15,	5.0051,	0,	17),
(127,	'Rosenberg\'s Caligulas Office',	2182.2,	1628.58,	1043.87,	0,	2),
(128,	'4 Dragons Janitors Office',	1893.07,	1017.9,	31.8828,	0,	10),
(129,	'Czyste lotnisko',	1811,	-2439,	13,	0,	0),
(130,	'Bank',	2315.95,	-1.61817,	26.7422,	0,	0);

DROP TABLE IF EXISTS `_items`;
CREATE TABLE `_items` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `ownerType` int(11) NOT NULL COMMENT '1 - player, 2 - veh_trunk, 3 - veh_int, 4 - door',
  `owner` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `slotID` int(11) NOT NULL,
  `val1` int(11) NOT NULL,
  `val2` int(11) NOT NULL,
  `val3` text NOT NULL,
  `volume` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `lastUsed` int(11) NOT NULL,
  `lastUsedID` int(11) NOT NULL,
  `lastUsedHistory` longtext NOT NULL,
  `used` tinyint(1) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=431;

INSERT INTO `_items` (`ID`, `name`, `ownerType`, `owner`, `type`, `slotID`, `val1`, `val2`, `val3`, `volume`, `created`, `lastUsed`, `lastUsedID`, `lastUsedHistory`, `used`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`) VALUES
(1,	'Desert Eagle',	1,	1,	1,	1,	24,	996,	'ALSCO9G',	1,	1450723853,	1450956611,	1,	'[ [ \"51dbf7cf8c684c0e288ed866eb764445\" ] ]',	0,	0,	0,	0,	0,	0,	0,	0,	0),
(3,	'Syrena policyjna',	1,	1,	20,	2,	1,	1,	'1',	1,	1450723868,	0,	0,	'',	0,	0,	0,	0,	0,	0,	0,	0,	0),
(5,	'Zwłoki',	1,	1,	7,	3,	17,	0,	'0',	2,	1450956668,	0,	0,	'',	0,	0,	0,	0,	0,	0,	0,	0,	0),
(6,	'Dowód osobisty',	1,	19,	11,	1,	1,	1,	'1',	1,	1450956877,	0,	0,	'',	0,	0,	0,	0,	0,	0,	0,	0,	0),
(7,	'Kokaina',	1,	19,	13,	2,	1,	1,	'1',	1,	1450956888,	0,	0,	'',	0,	0,	0,	0,	0,	0,	0,	0,	0),
(8,	'ubranie',	1,	20,	3,	1,	299,	299,	'299',	299,	1451044482,	1451044507,	20,	'[ [ \"68ef68358c7e99209507ee045e77de0a\" ] ]',	0,	0,	0,	0,	0,	0,	0,	0,	0);

DROP TABLE IF EXISTS `_login_logs`;
CREATE TABLE `_login_logs` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `charID` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `serial` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=151;

INSERT INTO `_login_logs` (`ID`, `charID`, `ip`, `serial`, `time`) VALUES
(1,	1,	'83.9.78.53',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450003373),
(2,	1,	'95.49.139.187',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450015052),
(3,	15,	'83.29.87.207',	'F2AD37CAB28093F256157B5F077DEEA4',	1450015330),
(4,	15,	'83.22.43.63',	'F2AD37CAB28093F256157B5F077DEEA4',	1450019198),
(5,	1,	'95.49.139.187',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450019633),
(6,	1,	'95.49.139.187',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450034287),
(7,	15,	'83.22.43.63',	'F2AD37CAB28093F256157B5F077DEEA4',	1450037784),
(8,	1,	'95.49.139.187',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450037896),
(9,	20,	'178.235.77.93',	'7C9489C13463D874AE29E5C8EC1DF292',	1450039297),
(10,	15,	'83.22.43.63',	'F2AD37CAB28093F256157B5F077DEEA4',	1450039414),
(11,	1,	'95.49.139.187',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450044357),
(12,	1,	'83.9.77.130',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450108837),
(13,	21,	'83.31.31.107',	'B79263503D9122FEEDF38165FBE55391',	1450113283),
(14,	1,	'83.9.77.130',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450113568),
(15,	15,	'83.22.40.53',	'F2AD37CAB28093F256157B5F077DEEA4',	1450119961),
(16,	21,	'83.31.31.107',	'B79263503D9122FEEDF38165FBE55391',	1450120655),
(17,	15,	'83.22.40.53',	'F2AD37CAB28093F256157B5F077DEEA4',	1450121329),
(18,	15,	'83.22.40.53',	'F2AD37CAB28093F256157B5F077DEEA4',	1450121604),
(19,	1,	'83.9.74.139',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450214349),
(20,	1,	'178.42.17.207',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450379395),
(21,	1,	'178.42.17.207',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450384638),
(22,	15,	'83.29.154.244',	'F2AD37CAB28093F256157B5F077DEEA4',	1450384809),
(23,	1,	'83.9.90.190',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450611910),
(24,	1,	'83.9.90.190',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450616809),
(25,	15,	'83.29.90.71',	'F2AD37CAB28093F256157B5F077DEEA4',	1450620160),
(26,	2,	'85.28.185.36',	'CF4258B2875DF7AE42AF0C272AF34854',	1450625880),
(27,	20,	'178.235.77.93',	'7C9489C13463D874AE29E5C8EC1DF292',	1450626448),
(28,	1,	'83.31.52.110',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450637639),
(29,	22,	'89.68.36.180',	'504EAC8CDB861B7D653573BF9104C7F4',	1450637983),
(30,	1,	'83.31.52.110',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450638542),
(31,	1,	'83.31.52.110',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450639006),
(32,	1,	'83.31.52.110',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450641468),
(33,	1,	'83.31.233.57',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450719833),
(34,	21,	'83.31.31.95',	'B79263503D9122FEEDF38165FBE55391',	1450720183),
(35,	1,	'83.31.233.57',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450723785),
(36,	1,	'83.9.178.233',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450858939),
(37,	1,	'79.185.255.215',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450893868),
(38,	1,	'79.185.255.215',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450894776),
(39,	1,	'79.185.255.215',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450895409),
(40,	1,	'95.49.136.49',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450895649),
(41,	19,	'89.79.217.0',	'2EE421AC277B43704442189D037FD483',	1450896420),
(42,	1,	'83.9.79.38',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450911474),
(43,	1,	'83.9.79.38',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450915080),
(44,	1,	'83.9.79.38',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450916333),
(45,	1,	'83.9.79.38',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1450954496),
(46,	19,	'89.79.217.0',	'2EE421AC277B43704442189D037FD483',	1450954686),
(47,	19,	'89.79.217.0',	'2EE421AC277B43704442189D037FD483',	1450956694),
(48,	22,	'89.68.36.180',	'504EAC8CDB861B7D653573BF9104C7F4',	1451035190),
(49,	1,	'83.9.90.35',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1451035364),
(50,	1,	'37.47.37.183',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1451041945),
(51,	1,	'83.9.209.10',	'695AE5F2800D2C9C26C0DFDABD3E2602',	1451043874),
(52,	20,	'178.235.77.93',	'7C9489C13463D874AE29E5C8EC1DF292',	1451044024),
(53,	19,	'89.79.217.0',	'2EE421AC277B43704442189D037FD483',	1451044207);

DROP TABLE IF EXISTS `_objects`;
CREATE TABLE `_objects` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `model` int(11) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `gx` float NOT NULL,
  `gy` float NOT NULL,
  `gz` float NOT NULL,
  `grx` float NOT NULL,
  `gry` float NOT NULL,
  `grz` float NOT NULL,
  `gAnimTime` float NOT NULL,
  `gRange` float NOT NULL,
  `isGate` tinyint(4) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=5461;

INSERT INTO `_objects` (`ID`, `model`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`, `gx`, `gy`, `gz`, `grx`, `gry`, `grz`, `gAnimTime`, `gRange`, `isGate`) VALUES
(42,	968,	1544.69,	-1630.96,	13.1406,	0,	90,	90,	0,	0,	1544.69,	-1630.96,	13.1406,	0,	20,	90,	2000,	10,	1),
(45,	997,	1544.7,	-1620.66,	12.2969,	0,	0,	270,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(46,	997,	1544.7,	-1617.57,	12.2969,	0,	0,	270,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(47,	9339,	1544.59,	-1645.78,	13.0078,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(66,	3089,	228.306,	150.234,	1003.15,	0,	0,	90.2197,	3,	1,	228.306,	150.234,	1003.15,	0,	0,	179.048,	1000,	3,	1),
(68,	3089,	228.302,	153.214,	1003.15,	0,	0,	270,	3,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(72,	3089,	228.256,	160.246,	1003.14,	0,	0,	90,	3,	1,	228.256,	160.246,	1003.14,	0,	0,	23.3594,	1000,	5,	1),
(73,	3089,	228.26,	163.227,	1003.14,	0,	0,	270,	3,	1,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(88,	1676,	1942.46,	-1793.07,	14.0312,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(93,	1266,	1802.07,	-1873.27,	29.6016,	0,	0,	270,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(109,	1257,	1522.73,	-1700.19,	13.8281,	0,	0,	180,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(110,	1257,	1796.86,	-1861.52,	13.7891,	0,	0,	270,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(111,	1257,	1567.25,	-1310.08,	17.3831,	0,	0,	270,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(113,	1257,	1281.72,	-1412.9,	13.5357,	0,	0,	268.341,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(114,	3089,	2304.87,	-17.6982,	26.9375,	0,	0,	90,	0,	15,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(115,	3089,	2304.85,	-14.6543,	26.9141,	0,	0,	270,	0,	15,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(116,	3089,	2314.74,	0.301758,	26.7578,	0,	0,	0,	0,	15,	0,	0,	0,	0,	0,	0,	0,	0,	0),
(123,	1649,	1783.79,	-1859.97,	14.2188,	0,	0,	180,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0,	0);

DROP TABLE IF EXISTS `_orders`;
CREATE TABLE `_orders` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `orderSize` int(11) DEFAULT '1',
  `catID` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `orderType` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=8192;

INSERT INTO `_orders` (`ID`, `orderSize`, `catID`, `data`, `price`, `name`, `orderType`) VALUES
(1,	1,	1,	'[ { \"itemName\": \"Beretta 92FS\", \"itemType\": 1, \"itemVal1\": 24, \"itemVal2\": 35, \"itemVal3\": \"LSPD\", \"itemVolume\": 2 } ]',	500,	'Beretta 92FS',	1),
(2,	1,	1,	'[ { \"itemName\": \"Amunicja: Beretta 92FS\", \"itemType\": 2, \"itemVal1\": 24, \"itemVal2\": 35, \"itemVal3\": \"LSPD\", \"itemVolume\": 2 } ]',	200,	'Amunicja: Beretta 92FS',	1),
(3,	1,	2,	'[ { \"itemName\": \"Beretta 92FS\", \"itemType\": 1, \"itemVal1\": 24, \"itemVal2\": 35, \"itemVal3\": \"LSPD\", \"itemVolume\": 2 } ]',	500,	'Beretta Pelego',	1);

DROP TABLE IF EXISTS `_orderscat`;
CREATE TABLE `_orderscat` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `orderType` int(11) NOT NULL,
  `orderOwner` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_orderscat` (`ID`, `orderType`, `orderOwner`, `name`) VALUES
(1,	1,	0,	'Wyposażenie LSPD'),
(2,	0,	1,	'Zamowienia dla Pelego');

DROP TABLE IF EXISTS `_penalty_logs`;
CREATE TABLE `_penalty_logs` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userID` int(11) unsigned NOT NULL,
  `adminID` int(11) unsigned NOT NULL,
  `serial` varchar(32) NOT NULL,
  `ip` varchar(20) NOT NULL,
  `reason` text NOT NULL,
  `time` int(11) unsigned NOT NULL,
  `expire` int(11) unsigned NOT NULL,
  `type` int(11) unsigned NOT NULL COMMENT '1 - kick, 2- adminJail, 3 - warn, 4 - ban, 5 - charBlock',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_penalty_logs` (`ID`, `userID`, `adminID`, `serial`, `ip`, `reason`, `time`, `expire`, `type`) VALUES
(1,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.72.15',	'Testowy block postaci.',	1438960660,	0,	5),
(2,	1,	1,	'CF4258B2875DF7AE42AF0C272AF34854',	'85.28.185.36',	'Test.',	1447746887,	50,	6),
(3,	15,	3,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.29.4.59',	'Bo tak.',	1447792141,	5000,	6),
(4,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dupa.',	1447863740,	500,	6),
(5,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dupa.',	1447863760,	500,	6),
(6,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dupa.',	1447863771,	500,	6),
(7,	15,	1,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.10.35.171',	'Good player.',	1447864046,	500,	6),
(8,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dupa.',	1447864078,	400,	6),
(9,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dupa dupa.',	1447864090,	0,	6),
(10,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Przecież to dobry administrator jest... :(.',	1447864113,	48050,	6),
(11,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.80',	'Dobra, wróc już do kodzenia.',	1447871973,	0,	1),
(12,	2,	1,	'CF4258B2875DF7AE42AF0C272AF34854',	'85.28.185.36',	'Idź stąd, zmieniam Ci nick.',	1447963424,	0,	1),
(13,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'79.185.130.42',	'Blokujemy bo FCK.',	1447964223,	0,	5),
(14,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'79.185.130.42',	'Testowy block, np FCK.',	1447964278,	0,	5),
(15,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'79.185.130.42',	'TEST.',	1447964288,	0,	5),
(16,	16,	4,	'1E3C968ED2AB99CA532FEBF0437D3FB2',	'79.186.67.30',	'Bardzo dobry gracz; wzorowa postawa.',	1447967654,	100000,	6),
(17,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'79.185.130.42',	'DUPA.',	1447974208,	0,	1),
(18,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.209.22',	'Ssij.',	1448306191,	0,	1),
(19,	2,	3,	'CF4258B2875DF7AE42AF0C272AF34854',	'85.28.185.36',	'Nie.',	1448306265,	0,	1),
(20,	15,	3,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.29.107.96',	'Zadość uczynienie.',	1448306295,	500,	6),
(21,	2,	2,	'CF4258B2875DF7AE42AF0C272AF34854',	'85.28.185.36',	'#PrayForLight.',	1448306366,	1337,	6),
(22,	2,	3,	'CF4258B2875DF7AE42AF0C272AF34854',	'85.28.185.36',	'Pa.',	1448307031,	0,	1),
(23,	15,	2,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.22.39.211',	'Wypierdalaj.',	1448403857,	0,	1),
(24,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.138.197',	'DM, Ciota i w ogóle ciota.',	1448562520,	0,	4),
(25,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.138.197',	'10.',	1448562681,	0,	1),
(26,	15,	1,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.29.108.224',	'Spierdalaj już.',	1448562991,	0,	1),
(27,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.138.197',	'Debil.',	1448563030,	0,	6),
(28,	15,	1,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.29.108.224',	'Ty też.',	1448563038,	0,	6),
(29,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.138.197',	'Do kodzenia.',	1448573855,	0,	1),
(30,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.138.197',	'100.',	1448575259,	0,	1),
(31,	15,	1,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.29.102.220',	'Bugowanie skryptu -.-.',	1449003493,	0,	1),
(32,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'178.42.16.148',	'Bugowanie.',	1449692568,	0,	1),
(33,	18,	3,	'1E3C968ED2AB99CA532FEBF0437D3FB2',	'83.8.189.68',	'Bugowanie.',	1449692575,	0,	1),
(34,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.139.187',	':).',	1450019567,	0,	1),
(35,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.139.187',	'FCK.',	1450038126,	0,	5),
(36,	15,	3,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.22.43.63',	'Bo jest fajny ziomeczek, nie to co ten pseudo skrypter kubas.',	1450041538,	4294967295,	6),
(37,	1,	3,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.139.187',	'Ciota.',	1450041568,	0,	6),
(38,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.139.187',	'Jestem najlepszym ziomeczkiem na świecie a Szychu to ciota.',	1450041591,	4294967295,	6),
(39,	15,	3,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.22.43.63',	'Chujowe.',	1450041941,	0,	6),
(40,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'95.49.139.187',	'Po koderino.',	1450044493,	0,	1),
(41,	21,	1,	'B79263503D9122FEEDF38165FBE55391',	'83.31.31.107',	'Witam.',	1450113926,	50,	6),
(42,	15,	1,	'F2AD37CAB28093F256157B5F077DEEA4',	'83.22.40.53',	'Idź lepiej.',	1450121512,	0,	1),
(43,	1,	1,	'695AE5F2800D2C9C26C0DFDABD3E2602',	'83.9.77.130',	'/me wychodzi z gry.',	1450122785,	0,	1);

DROP TABLE IF EXISTS `_phone_contacts`;
CREATE TABLE `_phone_contacts` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `phoneID` int(11) NOT NULL,
  `number` int(6) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1024;

INSERT INTO `_phone_contacts` (`ID`, `phoneID`, `number`, `name`) VALUES
(1,	11,	911,	'KubasCwel');

DROP TABLE IF EXISTS `_shops`;
CREATE TABLE `_shops` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `shopID` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemType` int(11) NOT NULL,
  `itemVal1` int(11) NOT NULL,
  `itemVal2` int(11) NOT NULL,
  `itemVal3` text NOT NULL,
  `itemVolume` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=2730;

INSERT INTO `_shops` (`ID`, `shopID`, `price`, `itemName`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(1,	9,	20,	'Płyta CD',	12,	0,	0,	'',	1),
(2,	9,	2000,	'Boombox',	19,	0,	0,	'0',	2),
(3,	9,	500,	'Kogut policyjny',	20,	0,	0,	'0',	2),
(5,	9,	5000,	'[SASD] Beretta 92FS',	1,	24,	35,	'gun-generate',	2),
(6,	9,	600,	'Telefon',	8,	0,	1,	'phone-generate',	1),
(7,	9,	800,	'Kostka do gry',	22,	6,	0,	'0',	1),
(8,	9,	5000,	'[SASD] Colt AR15A4 Rifle',	1,	31,	500,	'gun-generate',	2),
(9,	9,	500,	'[SASD] Pałka policyjna',	1,	3,	1,	'gun-generate',	1),
(10,	9,	2500,	'[SASD] Less Lethal',	14,	25,	500,	'gun-generate',	2),
(11,	18,	500,	'Desert Eagle',	1,	24,	500,	'gun-generate',	1),
(12,	18,	500,	'Amunicja: Desert Eagle',	2,	24,	500,	'gun-generate',	1),
(13,	18,	500,	'Ubranie: 280',	3,	280,	0,	'',	1),
(14,	18,	500,	'Megafon',	4,	1,	1,	'',	1),
(15,	18,	500,	'Kamizelka kuloodporna',	5,	10,	1,	'1',	1),
(16,	18,	500,	'Jedzenie',	6,	50,	0,	'',	1),
(17,	18,	500,	'Zwłoki',	7,	1,	0,	'',	1),
(18,	18,	500,	'Telefon',	8,	1,	1,	'phone-generate',	1),
(19,	18,	500,	'Rękawiczki',	9,	10,	1,	'1',	1),
(20,	18,	500,	'Dowód osobisty',	11,	1,	1,	'1',	1),
(21,	18,	500,	'Płyta CD',	12,	0,	0,	'',	1),
(22,	18,	500,	'Kokaina',	13,	1,	1,	'1',	1),
(23,	18,	500,	'Beanbag',	14,	25,	500,	'gun-generate',	1),
(24,	18,	500,	'O: Odznaka policyjna',	15,	1649,	1,	'1',	1),
(25,	18,	500,	'Kominiarka',	16,	10,	1,	'1',	1),
(26,	18,	500,	'Kajdanki',	18,	1,	1,	'1',	1),
(27,	18,	500,	'Boombox',	19,	1,	1,	'1',	0),
(28,	18,	500,	'Syrena policyjna',	20,	1,	1,	'1',	1),
(29,	18,	500,	'Kostka do gry',	22,	6,	1,	'1',	1),
(30,	18,	500,	'Łom',	24,	10,	1,	'1',	1);

DROP TABLE IF EXISTS `_users`;
CREATE TABLE `_users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `inGame` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `_users` (`ID`, `username`, `pass`, `inGame`) VALUES
(1,	'Kubas',	'dupa',	1),
(2,	'Pele',	'dupa',	0),
(3,	'Szychu',	'dupa',	0),
(5,	'Piteriuz',	'dupa',	0),
(6,	'Light',	'dupa',	0),
(7,	'Rubik',	'dupa',	1),
(8,	'Darek',	'dupa',	1),
(9,	'Grzeholek',	'dupa',	0),
(10,	'Kaizi',	'dupa',	0);

DROP TABLE IF EXISTS `_vehicles`;
CREATE TABLE `_vehicles` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `ownerType` int(11) NOT NULL,
  `ownerID` int(11) NOT NULL,
  `c1r` int(11) NOT NULL DEFAULT '255',
  `c1g` int(11) NOT NULL DEFAULT '255',
  `c1b` int(11) NOT NULL DEFAULT '255',
  `c2r` int(11) NOT NULL DEFAULT '255',
  `c2g` int(11) NOT NULL DEFAULT '255',
  `c2b` int(11) NOT NULL DEFAULT '255',
  `model` int(11) NOT NULL,
  `hp` float NOT NULL DEFAULT '1000',
  `spawned` int(11) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `v1` int(11) NOT NULL,
  `v2` int(11) NOT NULL,
  `fuel` float NOT NULL,
  `maxfuel` int(11) NOT NULL DEFAULT '50',
  `damage` mediumtext NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `flashType` int(11) NOT NULL,
  `distance` float NOT NULL,
  `hasAlarm` tinyint(1) NOT NULL,
  `handbrake` tinyint(1) NOT NULL,
  `tireBlock` tinyint(1) NOT NULL,
  `sirenType` int(11) NOT NULL,
  `carplate` varchar(7) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=1024;

INSERT INTO `_vehicles` (`ID`, `name`, `ownerType`, `ownerID`, `c1r`, `c1g`, `c1b`, `c2r`, `c2g`, `c2b`, `model`, `hp`, `spawned`, `locked`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `v1`, `v2`, `fuel`, `maxfuel`, `damage`, `interior`, `dimension`, `flashType`, `distance`, `hasAlarm`, `handbrake`, `tireBlock`, `sirenType`, `carplate`) VALUES
(1,	'Bullet',	1,	1,	0,	0,	0,	0,	0,	0,	541,	1000,	1,	0,	1601.29,	-1704.16,	5.51539,	359.511,	359.995,	88.0994,	0,	0,	41.4719,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	1,	428.728,	1,	0,	0,	1,	'XB30W13'),
(2,	'Patriot',	2,	1,	255,	255,	255,	255,	255,	255,	470,	1000,	1,	0,	1777.15,	-1862.73,	13.5566,	359.626,	359.995,	179.863,	0,	0,	43.5075,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	1,	140.28,	1,	0,	0,	1,	'2LU1FX9'),
(3,	'Police LS',	2,	1,	0,	0,	0,	255,	255,	255,	596,	1000,	1,	0,	1771.17,	-1863.39,	13.2968,	359.687,	0.351562,	178.363,	0,	0,	49.5598,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	0,	4.61204,	0,	0,	0,	0,	'QUUHSXR'),
(4,	'Police LS',	2,	1,	0,	0,	0,	255,	255,	255,	596,	1000,	1,	0,	1768.25,	-1863.32,	13.2968,	359.621,	359.995,	178.066,	0,	0,	0,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	1,	31.0778,	0,	0,	0,	1,	'JG4ZKII'),
(5,	'Police LS',	2,	1,	0,	0,	0,	255,	255,	255,	596,	1000,	1,	0,	1765.1,	-1863.22,	13.2958,	359.615,	359.995,	176.951,	0,	0,	49.711,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	0,	1.96332,	0,	0,	0,	1,	'MHOL35B'),
(6,	'Huntley',	1,	15,	255,	255,	255,	255,	255,	255,	579,	1000,	0,	0,	1821.04,	-1834.76,	14.5053,	0,	0,	253.682,	0,	0,	49.8151,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 0, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 0, \"door1\": 0, \"door5\": 0, \"panel6\": 0, \"panel2\": 0, \"panel1\": 0, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 0, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	0,	0.637327,	0,	0,	0,	0,	'RX7HXDZ'),
(7,	'Cheetah',	1,	20,	255,	255,	255,	255,	255,	255,	415,	753,	0,	0,	1533.33,	-1684.85,	13.5469,	0,	0,	28.602,	0,	0,	0,	50,	'[ { \"light4\": 0, \"panel7\": 0, \"panel3\": 0, \"door2\": 0, \"light2\": 1, \"wheel1\": 0, \"door4\": 0, \"door6\": 0, \"panel5\": 1, \"door1\": 2, \"door5\": 0, \"panel6\": 2, \"panel2\": 2, \"panel1\": 1, \"light3\": 0, \"wheel4\": 0, \"panel4\": 0, \"wheel3\": 0, \"light1\": 1, \"wheel2\": 0, \"door3\": 0 } ]',	0,	0,	0,	17.2795,	0,	0,	0,	0,	'CP331D3');

DROP TABLE IF EXISTS `_vehtuning`;
CREATE TABLE `_vehtuning` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `vehID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `type` int(11) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2015-12-25 12:41:31
