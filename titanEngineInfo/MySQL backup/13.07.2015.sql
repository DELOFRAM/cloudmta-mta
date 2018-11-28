-- phpMyAdmin SQL Dump
-- version 4.4.1
-- http://www.phpmyadmin.net
--
-- Host: 10.0.0.152:3306
-- Czas generowania: 13 Lip 2015, 13:39
-- Wersja serwera: 5.5.40-0+wheezy1
-- Wersja PHP: 5.4.39-0+deb7u2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `cloudmta_db`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_members`
--

CREATE TABLE IF NOT EXISTS `forum_members` (
  `id_member` mediumint(8) unsigned NOT NULL,
  `member_name` varchar(80) NOT NULL DEFAULT '',
  `date_registered` int(10) unsigned NOT NULL DEFAULT '0',
  `posts` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_group` smallint(5) unsigned NOT NULL DEFAULT '0',
  `lngfile` varchar(255) NOT NULL DEFAULT '',
  `last_login` int(10) unsigned NOT NULL DEFAULT '0',
  `real_name` varchar(255) NOT NULL DEFAULT '',
  `instant_messages` smallint(5) NOT NULL DEFAULT '0',
  `unread_messages` smallint(5) NOT NULL DEFAULT '0',
  `new_pm` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `buddy_list` text NOT NULL,
  `pm_ignore_list` varchar(255) NOT NULL DEFAULT '',
  `pm_prefs` mediumint(8) NOT NULL DEFAULT '0',
  `mod_prefs` varchar(20) NOT NULL DEFAULT '',
  `message_labels` text NOT NULL,
  `passwd` varchar(64) NOT NULL DEFAULT '',
  `openid_uri` text NOT NULL,
  `email_address` varchar(255) NOT NULL DEFAULT '',
  `personal_text` varchar(255) NOT NULL DEFAULT '',
  `gender` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `birthdate` date NOT NULL DEFAULT '0001-01-01',
  `website_title` varchar(255) NOT NULL DEFAULT '',
  `website_url` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `icq` varchar(255) NOT NULL DEFAULT '',
  `aim` varchar(255) NOT NULL DEFAULT '',
  `yim` varchar(32) NOT NULL DEFAULT '',
  `msn` varchar(255) NOT NULL DEFAULT '',
  `hide_email` tinyint(4) NOT NULL DEFAULT '0',
  `show_online` tinyint(4) NOT NULL DEFAULT '1',
  `time_format` varchar(80) NOT NULL DEFAULT '',
  `signature` text NOT NULL,
  `time_offset` float NOT NULL DEFAULT '0',
  `avatar` varchar(255) NOT NULL DEFAULT '',
  `pm_email_notify` tinyint(4) NOT NULL DEFAULT '0',
  `karma_bad` smallint(5) unsigned NOT NULL DEFAULT '0',
  `karma_good` smallint(5) unsigned NOT NULL DEFAULT '0',
  `usertitle` varchar(255) NOT NULL DEFAULT 'Brak',
  `notify_announcements` tinyint(4) NOT NULL DEFAULT '1',
  `notify_regularity` tinyint(4) NOT NULL DEFAULT '1',
  `notify_send_body` tinyint(4) NOT NULL DEFAULT '0',
  `notify_types` tinyint(4) NOT NULL DEFAULT '2',
  `member_ip` varchar(255) NOT NULL DEFAULT '',
  `member_ip2` varchar(255) NOT NULL DEFAULT '',
  `secret_question` varchar(255) NOT NULL DEFAULT '',
  `secret_answer` varchar(64) NOT NULL DEFAULT '',
  `id_theme` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `is_activated` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `validation_code` varchar(10) NOT NULL DEFAULT '',
  `id_msg_last_visit` int(10) unsigned NOT NULL DEFAULT '0',
  `additional_groups` varchar(255) NOT NULL DEFAULT '',
  `smiley_set` varchar(48) NOT NULL DEFAULT '',
  `id_post_group` smallint(5) unsigned NOT NULL DEFAULT '0',
  `total_time_logged_in` int(10) unsigned NOT NULL DEFAULT '0',
  `password_salt` varchar(255) NOT NULL DEFAULT '',
  `ignore_boards` text NOT NULL,
  `warning` tinyint(4) NOT NULL DEFAULT '0',
  `passwd_flood` varchar(12) NOT NULL DEFAULT '',
  `pm_receive_from` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `inGame` int(11) NOT NULL DEFAULT '0',
  `admin` int(11) NOT NULL,
  `adminPerm` longtext NOT NULL,
  `duty_desc` text NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_members`
--

INSERT INTO `forum_members` (`id_member`, `member_name`, `date_registered`, `posts`, `id_group`, `lngfile`, `last_login`, `real_name`, `instant_messages`, `unread_messages`, `new_pm`, `buddy_list`, `pm_ignore_list`, `pm_prefs`, `mod_prefs`, `message_labels`, `passwd`, `openid_uri`, `email_address`, `personal_text`, `gender`, `birthdate`, `website_title`, `website_url`, `location`, `icq`, `aim`, `yim`, `msn`, `hide_email`, `show_online`, `time_format`, `signature`, `time_offset`, `avatar`, `pm_email_notify`, `karma_bad`, `karma_good`, `usertitle`, `notify_announcements`, `notify_regularity`, `notify_send_body`, `notify_types`, `member_ip`, `member_ip2`, `secret_question`, `secret_answer`, `id_theme`, `is_activated`, `validation_code`, `id_msg_last_visit`, `additional_groups`, `smiley_set`, `id_post_group`, `total_time_logged_in`, `password_salt`, `ignore_boards`, `warning`, `passwd_flood`, `pm_receive_from`, `inGame`, `admin`, `adminPerm`, `duty_desc`) VALUES
(1, 'Kubas', 1417596022, 7, 1, '', 1425761638, 'Kubas', 0, 0, 0, '', '', 0, '', '', '27223ed8980dd8ed1c85e67570121a6b17d5d3c0', '', 'kubasgc@icloud.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, '', 1, 1, 0, 2, '198.41.242.115', '198.41.242.115', '', '', 5, 1, '', 2688, '', '', 4, 20885, '057b', '', 0, '1425418546|2', 1, 0, 4, '', 'Wszystko'),
(147, 'Kociol.', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', '9fd593c5c435a06aeed3526da5912e8778b1d6ab', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 1, '', ''),
(145, 'Rubik', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', '836ce0fd64d574661b7807b59274257416113cbd', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 4, '', ''),
(146, 'filip', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', 'a05f80e1d132976c22cd9da37582a449fc39fade', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 4, '', ''),
(152, 'Msk', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', '2d2864b0064fdf3c42c1e1c1544b2be27ef0f7d6', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 0, '', ''),
(151, 'Arteusz', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', 'eddaf5b95a5704d69033198daf3513872ca2daf0', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 2, '', ''),
(149, 'Arteusz', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', 'eddaf5b95a5704d69033198daf3513872ca2daf0', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 1, '', ''),
(150, 'vincert', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', '2fb74b0a6372f638e9eb98ac96d690ad65959e40', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 4, '', ''),
(153, 'Szychu', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', 'cd1cb67affd94f8fb140a11643794e9a7a4ae565', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 3, '', ''),
(144, 'Darek', 0, 0, 0, '', 0, '', 0, 0, 0, '', '', 0, '', '', '3e49e556f44c829519c35101220e8426be569467', '', '', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Brak', 1, 1, 0, 2, '', '', '', '', 0, 1, '', 0, '', '', 0, 0, '', '', 0, '', 1, 0, 4, '', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_3Dtexts`
--

CREATE TABLE IF NOT EXISTS `_3Dtexts` (
  `ID` int(11) unsigned NOT NULL,
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `vw` int(11) NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0',
  `text` text,
  `r` int(11) NOT NULL DEFAULT '255',
  `g` int(11) NOT NULL DEFAULT '255',
  `b` int(11) NOT NULL DEFAULT '255'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_3Dtexts`
--

INSERT INTO `_3Dtexts` (`ID`, `x`, `y`, `z`, `vw`, `int`, `text`, `r`, `g`, `b`) VALUES
(3, 1772.23, -1740.72, 13.5469, 0, 0, '** Budynek doszczętnie spłonął, Rubik go podpalił **', 154, 156, 205);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_anims`
--

CREATE TABLE IF NOT EXISTS `_anims` (
  `uid` int(3) unsigned NOT NULL,
  `name` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `animlib` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `animname` varchar(45) COLLATE utf8_polish_ci NOT NULL,
  `loop` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `freeze` tinyint(2) unsigned NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci AVG_ROW_LENGTH=36;

--
-- Zrzut danych tabeli `_anims`
--

INSERT INTO `_anims` (`uid`, `name`, `animlib`, `animname`, `loop`, `freeze`) VALUES
(1, 'idz1', 'PED', 'WALK_gang1', 1, 1),
(2, 'idz2', 'PED', 'WALK_gang2', 1, 1),
(3, 'idz3', 'PED', 'WOMAN_walksexy', 1, 1),
(4, 'idz4', 'PED', 'WOMAN_walkfatold', 1, 1),
(5, 'idz5', 'PED', 'Walk_Wuzi', 1, 1),
(6, 'idz6', 'PED', 'WALK_player', 1, 1),
(7, 'stopani', 'CARRY', 'crry_prtial', 0, 0),
(8, 'pa', 'KISSING', 'gfwave2', 0, 0),
(9, 'zmeczony', 'PED', 'IDLE_tired', 1, 0),
(10, 'umyjrece', 'INT_HOUSE', 'wash_up', 0, 0),
(11, 'medyk', 'MEDIC', 'CPR', 0, 0),
(12, 'ranny', 'SWEET', 'Sweet_injuredloop', 1, 1),
(13, 'salutuj', 'ON_LOOKERS', 'lkup_in', 0, 1),
(14, 'wtf', 'RIOT', 'RIOT_ANGRY', 0, 1),
(15, 'spoko', 'GANGS', 'prtial_gngtlkD', 0, 0),
(16, 'napad', 'SHOP', 'ROB_Loop_Threat', 1, 1),
(17, 'krzeslo', 'ped', 'SEAT_idle', 1, 1),
(18, 'szukaj', 'COP_AMBIENT', 'Copbrowse_loop', 1, 0),
(19, 'lornetka', 'ON_LOOKERS', 'shout_loop', 1, 0),
(20, 'oh', 'MISC', 'plyr_shkhead', 0, 0),
(21, 'oh2', 'OTB', 'wtchrace_lose', 0, 0),
(22, 'wyciagnij', 'FOOD', 'SHP_Tray_Lift', 0, 0),
(23, 'zdziwiony', 'PED', 'facsurp', 0, 1),
(24, 'recemaska', 'POLICE', 'crm_drgbst_01', 1, 1),
(25, 'krzeslojem', 'FOOD', 'FF_Sit_Eat1', 1, 0),
(26, 'gogo', 'RIOT', 'RIOT_CHANT', 1, 1),
(27, 'czekam', 'GRAVEYARD', 'prst_loopa', 1, 1),
(28, 'garda', 'FIGHT_D', 'FightD_IDLE', 1, 1),
(31, 'napraw', 'CAR', 'Fixn_Car_Loop', 1, 1),
(30, 'fotel', 'INT_HOUSE', 'LOU_Loop', 1, 1),
(29, 'barman2', 'BAR', 'BARman_idle', 0, 0),
(32, 'barman', 'BAR', 'Barserve_loop', 1, 0),
(33, 'opieraj', 'GANGS', 'leanIDLE', 1, 1),
(34, 'bar.nalej', 'BAR', 'Barserve_glass', 0, 0),
(35, 'ramiona', 'COP_AMBIENT', 'Coplook_loop', 1, 1),
(36, 'bar.wez', 'BAR', 'Barserve_bottle', 0, 0),
(37, 'chowaj', 'ped', 'cower', 1, 0),
(38, 'wez', 'BAR', 'Barserve_give', 0, 0),
(39, 'fuck', 'ped', 'fucku', 0, 0),
(40, 'klepnij', 'SWEET', 'sweet_ass_slap', 0, 0),
(42, 'daj', 'DEALER', 'DEALER_DEAL', 0, 0),
(43, 'pij', 'VENDING', 'VEND_Drink2_P', 1, 1),
(44, 'start', 'CAR', 'flag_drop', 0, 0),
(45, 'karta', 'HEIST9', 'Use_SwipeCard', 0, 0),
(46, 'spray', 'GRAFFITI', 'spraycan_fire', 1, 0),
(47, 'odejdz', 'POLICE', 'CopTraf_Left', 0, 0),
(48, 'fotelk', 'JST_BUISNESS', 'girl_02', 1, 1),
(49, 'chodz', 'POLICE', 'CopTraf_Come', 0, 0),
(50, 'stop', 'POLICE', 'CopTraf_Stop', 0, 0),
(51, 'drapjaja', 'MISC', 'Scratchballs_01', 1, 0),
(52, 'opieraj2', 'MISC', 'Plyrlean_loop', 1, 0),
(53, 'walekonia', 'PAULNMAC', 'wank_loop', 1, 0),
(54, 'popchnij', 'GANGS', 'shake_cara', 0, 0),
(55, 'rzuc', 'GRENADE', 'WEAPON_throwu', 0, 0),
(56, 'rap1', 'RAPPING', 'RAP_A_Loop', 1, 0),
(57, 'rap2', 'RAPPING', 'RAP_C_Loop', 1, 0),
(58, 'rap3', 'RAPPING', 'RAP_B_Loop', 1, 0),
(59, 'rap4', 'GANGS', 'prtial_gngtlkH', 1, 1),
(60, 'glowka', 'WAYFARER', 'WF_Fwd', 0, 0),
(61, 'skop', 'FIGHT_D', 'FightD_G', 0, 0),
(62, 'siad', 'BEACH', 'ParkSit_M_loop', 1, 0),
(63, 'krzeslo2', 'FOOD', 'FF_Sit_Loop', 1, 0),
(64, 'krzeslo3', 'INT_OFFICE', 'OFF_Sit_Idle_Loop', 1, 0),
(65, 'krzeslo4', 'INT_OFFICE', 'OFF_Sit_Bored_Loop', 1, 0),
(66, 'krzeslo5', 'INT_OFFICE', 'OFF_Sit_Type_Loop', 1, 0),
(67, 'padnij', 'PED', 'KO_shot_front', 0, 1),
(68, 'padaczka', 'PED', 'FLOOR_hit_f', 1, 0),
(70, 'crack', 'CRACK', 'crckdeth2', 1, 0),
(84, 'lez3', 'BEACH', 'ParkSit_W_loop', 1, 0),
(79, 'pijak', 'PED', 'WALK_DRUNK', 1, 1),
(69, 'unik', 'PED', 'EV_dive', 0, 1),
(71, 'bomb', 'BOMBER', 'BOM_Plant', 0, 0),
(72, 'cpaj', 'SHOP', 'ROB_Shifty', 0, 0),
(73, 'rece', 'ROB_BANK', 'SHP_HandsUp_Scr', 0, 1),
(78, 'tancz5', 'STRIP', 'STR_Loop_A', 1, 0),
(80, 'nie', 'GANGS', 'Invite_No', 0, 0),
(81, 'lokiec', 'CAR', 'Sit_relaxed', 1, 1),
(82, 'go', 'RIOT', 'RIOT_PUNCHES', 0, 0),
(83, 'stack1', 'GHANDS', 'gsign2LH', 0, 0),
(85, 'lez1', 'BEACH', 'bather', 1, 0),
(86, 'lez2', 'BEACH', 'Lay_Bac_Loop', 1, 0),
(87, 'padnij2', 'PED', 'KO_skid_front', 0, 1),
(88, 'bat', 'CRACK', 'Bbalbat_Idle_01', 1, 1),
(89, 'bat2', 'CRACK', 'Bbalbat_Idle_02', 0, 1),
(90, 'stack2', 'GHANDS', 'gsign2', 0, 1),
(91, 'stack3', 'GHANDS', 'gsign4', 0, 1),
(92, 'taichi', 'PARK', 'Tai_Chi_Loop', 1, 0),
(93, 'kosz1', 'BSKTBALL', 'BBALL_idleloop', 1, 0),
(94, 'kosz2', 'BSKTBALL', 'BBALL_Jump_Shot', 0, 0),
(95, 'kosz3', 'BSKTBALL', 'BBALL_pickup', 0, 0),
(96, 'kosz4', 'BSKTBALL', 'BBALL_def_loop', 1, 0),
(97, 'kosz5', 'BSKTBALL', 'BBALL_Dnk', 0, 0),
(98, 'papieros', 'SMOKING', 'M_smklean_loop', 1, 0),
(99, 'wymiotuj', 'FOOD', 'EAT_Vomit_P', 0, 0),
(100, 'fuck2', 'RIOT', 'RIOT_FUKU', 0, 0),
(41, 'cmon', 'RYDER', 'RYD_Beckon_01', 0, 0),
(101, 'koks', 'PED', 'IDLE_HBHB', 1, 1),
(102, 'idz7', 'PED', 'WOMAN_walkshop', 1, 1),
(103, 'cry', 'GRAVEYARD', 'mrnF_loop', 1, 1),
(104, 'rozciagaj', 'PLAYIDLES', 'stretch', 0, 0),
(107, 'bagaznik', 'POOL', 'POOL_Place_White', 0, 1),
(108, 'wywaz', 'GANGS', 'shake_carK', 0, 0),
(109, 'skradajsie', 'PED', 'Player_Sneak', 1, 1),
(110, 'przycisk', 'CRIB', 'CRIB_use_switch', 0, 0),
(111, 'tancz6', 'DANCING', 'DAN_down_A', 1, 0),
(112, 'tancz7', 'DANCING', 'DAN_left_A', 1, 0),
(113, 'idz8', 'PED', 'walk_shuffle', 1, 1),
(114, 'stack4', 'LOWRIDER', 'prtial_gngtlkB', 0, 0),
(115, 'stack5', 'LOWRIDER', 'prtial_gngtlkC', 0, 1),
(116, 'stack6', 'lowrider', 'prtial_gngtlkD', 0, 0),
(117, 'stack7', 'lowrider', 'prtial_gngtlkE', 0, 0),
(118, 'stack8', 'lowrider', 'prtial_gngtlkF', 0, 0),
(119, 'stack9', 'lowrider', 'prtial_gngtlkG', 0, 0),
(120, 'stack10', 'lowrider', 'prtial_gngtlkH', 0, 1),
(121, 'tancz8', 'DANCING', 'dnce_m_d', 1, 0),
(122, 'kasjer', 'INT_SHOP', 'shop_cashier', 0, 0),
(123, 'idz9', 'wuzi', 'wuzi_walk', 1, 1),
(124, 'taxi', 'misc', 'hiker_pose', 0, 1),
(125, 'wskaz', 'on_lookers', 'pointup_loop', 0, 1),
(126, 'wskaz2', 'on_lookers', 'point_loop', 0, 1),
(127, 'podpisz', 'otb', 'betslp_loop', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_characters`
--

CREATE TABLE IF NOT EXISTS `_characters` (
  `ID` bigint(20) NOT NULL COMMENT 'ID postaci',
  `memberID` bigint(20) NOT NULL COMMENT 'ID usera',
  `name` varchar(20) NOT NULL COMMENT 'Imię',
  `lastname` varchar(20) NOT NULL COMMENT 'Nazwisko',
  `faceCode` varchar(6) NOT NULL COMMENT 'Kod twarzy',
  `shortDNA` varchar(4) NOT NULL,
  `DNA` varchar(255) NOT NULL,
  `hp` int(11) NOT NULL DEFAULT '100' COMMENT 'HP',
  `skin` int(11) NOT NULL COMMENT 'Skin',
  `x` float NOT NULL COMMENT 'Koord. x',
  `y` float NOT NULL COMMENT 'Koord. y',
  `z` float NOT NULL COMMENT 'Koord. z',
  `angle` float NOT NULL COMMENT 'Kąt zwrotu',
  `dimension` int(11) NOT NULL COMMENT 'Wymiar',
  `interior` int(11) NOT NULL COMMENT 'Interior',
  `money` bigint(20) NOT NULL COMMENT 'Pieniądze',
  `bwTime` int(11) NOT NULL COMMENT 'BW',
  `ajTime` int(11) NOT NULL COMMENT 'AJ',
  `onlineTime` int(11) NOT NULL COMMENT 'Czas online',
  `afkTime` int(11) NOT NULL COMMENT 'AFK',
  `sex` int(11) NOT NULL DEFAULT '1' COMMENT 'Płeć',
  `inGame` tinyint(1) NOT NULL COMMENT 'W grze',
  `lastVisit` int(11) NOT NULL,
  `blocked` tinyint(2) NOT NULL,
  `hide` int(11) NOT NULL,
  `dob` date NOT NULL,
  `activated` int(11) NOT NULL,
  `vehBlock` int(11) NOT NULL DEFAULT '0',
  `runBlock` int(11) NOT NULL DEFAULT '0',
  `oocBlock` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_characters`
--

INSERT INTO `_characters` (`ID`, `memberID`, `name`, `lastname`, `faceCode`, `shortDNA`, `DNA`, `hp`, `skin`, `x`, `y`, `z`, `angle`, `dimension`, `interior`, `money`, `bwTime`, `ajTime`, `onlineTime`, `afkTime`, `sex`, `inGame`, `lastVisit`, `blocked`, `hide`, `dob`, `activated`, `vehBlock`, `runBlock`, `oocBlock`) VALUES
(1, 1, 'Jeremy', 'Simons', 'ASDXDD', '64A9', '51dbf7cf8c684c0e288ed866eb764445', 100, 280, 1705.26, -1728.75, 13.1658, 24.7473, 0, 0, 20026923, 0, 0, 270231, 289504, 1, 0, 1436784079, 0, 0, '0000-00-00', 0, 0, 0, 0),
(5, 144, 'Dupka', 'Dupka', 'OKNM8X', '', '', 84, 60, 1696.4, -1711.65, 13.5469, 179.819, 0, 0, 0, 0, 0, 2259, 270, 1, 0, 1436784829, 0, 0, '0000-00-00', 0, 0, 0, 0),
(6, 145, 'Dupka', 'Dupka', 'SNR525', '', '', 45, 60, 1799.96, -1875.93, 20.1931, 127.073, 0, 0, 92080, 0, 0, 4407, 19977, 1, 0, 1436460529, 0, 0, '0000-00-00', 0, 0, 0, 0),
(7, 146, 'Dupka', 'Dupka', 'AT51A6', '', '', 30, 17, 2136.83, -1635.07, 13.3842, 224.571, 0, 0, 0, 0, 0, 2444, 9010, 1, 0, 1436716208, 0, 0, '0000-00-00', 0, 0, 0, 0),
(8, 147, 'Dupka', 'Dupka', 'AST2AJ', '', '', 100, 17, 1173.1, -1173.76, 86.899, 322.682, 8828, 0, 973036, 0, 0, 5113, 646, 1, 0, 1436458584, 0, 0, '0000-00-00', 0, 0, 0, 0),
(11, 150, 'Dupka', 'Dupka', 'AS517T', '', '', 100, 0, 1125.37, -1704.28, 15.2231, 82.7692, 0, 0, 0, 0, 0, 3006, 2670, 1, 0, 1436271781, 0, 0, '0000-00-00', 0, 0, 0, 0),
(12, 151, 'Dupka', 'Dupka', '', '', '', 22, 0, 1308.22, -1730.12, 13.1987, 89.5385, 0, 0, 558655, 0, 0, 2047, 124, 1, 0, 1436457800, 0, 0, '0000-00-00', 0, 0, 0, 0),
(13, 152, 'Michal', 'Msk', 'A03MLE', '', '', 100, 0, 1869.36, -1761.65, 13.5469, 207.961, 0, 0, 0, 0, 0, 177, 0, 1, 0, 1436477982, 0, 0, '0000-00-00', 0, 0, 0, 0),
(14, 153, 'Dupka', 'Dupka', 'AST69C', '', '', 100, 280, 1614.07, -1762.57, 27.5265, 202.429, 0, 0, 46090, 0, 0, 6600, 4819, 1, 0, 1436649916, 0, 0, '0000-00-00', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_clothes`
--

CREATE TABLE IF NOT EXISTS `_clothes` (
  `ID` int(11) NOT NULL,
  `shopID` int(11) NOT NULL,
  `skinID` int(11) NOT NULL,
  `skinName` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_clothes`
--

INSERT INTO `_clothes` (`ID`, `shopID`, `skinID`, `skinName`, `price`) VALUES
(1, 10, 60, 'Koszula w kratkę', 252),
(2, 10, 17, 'Rambo', 5764),
(3, 10, 22, 'Murzynek bambo', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_delivers`
--

CREATE TABLE IF NOT EXISTS `_delivers` (
  `ID` int(11) NOT NULL,
  `intID` int(11) NOT NULL,
  `pieces` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `name` varchar(255) NOT NULL,
  `orderType` int(11) NOT NULL DEFAULT '1',
  `deliverGroup` int(11) NOT NULL,
  `deliverID` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `cost` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_delivers`
--

INSERT INTO `_delivers` (`ID`, `intID`, `pieces`, `data`, `name`, `orderType`, `deliverGroup`, `deliverID`, `time`, `cost`) VALUES
(1, 1, 180, '[ { "itemName": "Beretta 92FS", "itemType": 1, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 'Los Santos Police Department', 3, 0, 0, 1426412289, 0),
(3, 1, 80, '[ { "itemName": "Amunicja: Beretta 92FS", "itemType": 2, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 'Los Santos Police Department', 1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_deposite`
--

CREATE TABLE IF NOT EXISTS `_deposite` (
  `ID` int(11) NOT NULL,
  `intID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `stock` int(11) NOT NULL,
  `itemType` int(11) NOT NULL,
  `itemVal1` int(11) NOT NULL,
  `itemVal2` int(11) NOT NULL,
  `itemVal3` varchar(255) NOT NULL,
  `itemVolume` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_deposite`
--

INSERT INTO `_deposite` (`ID`, `intID`, `name`, `stock`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(2, 1, 'Beretta 92FS', 48, 1, 24, 35, 'LSPD', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_doors`
--

CREATE TABLE IF NOT EXISTS `_doors` (
  `ID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerType` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `dimension` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doors`
--

INSERT INTO `_doors` (`ID`, `name`, `ownerType`, `owner`, `dimension`) VALUES
(1, 'Los Santos Police Department - Główny Interior', 2, 1, 1),
(5, 'All Saints General Hospital', 2, 1, 2),
(7, 'Dom: Jeremy Simons', 1, 2, 3),
(8, 'Szychu test', 1, 1, 4),
(9, '24/7 #1', 0, 0, 5),
(10, 'Ciucholand', 0, 0, 6),
(11, 'Department of Motor Vehicles', 2, 5, 7),
(12, 'Los Santos Wehrmacht Department', 2, 6, 8),
(13, 'LSG', 2, 2, 9),
(14, 'Drzwi ELESPEDE', 2, 1, 10);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_doorsPickup`
--

CREATE TABLE IF NOT EXISTS `_doorsPickup` (
  `ID` int(11) NOT NULL,
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
  `locked` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doorsPickup`
--

INSERT INTO `_doorsPickup` (`ID`, `parentID`, `name`, `inX`, `inY`, `inZ`, `outX`, `outY`, `outZ`, `inDim`, `outDim`, `inInt`, `outInt`, `outModel`, `inModel`, `inAngle`, `outAngle`, `locked`) VALUES
(1, 1, 'Los Santos Police Department', 238.741, 139.413, 1003.02, 1554.66, -1675.45, 16.1953, 1, 0, 3, 0, 1239, 1318, 352.889, 85.3953, 0),
(7, 5, 'Drzwi do szpitala', 1194.41, -1325.02, 13.3984, 1172.77, -1323.86, 15.4009, 2, 0, 0, 0, 1239, 1318, 268.386, 268.386, 0),
(8, 7, 'Dom Kubaska', 260.819, 1237.74, 1084.26, 1331.78, -632.639, 109.135, 3, 0, 9, 0, 1239, 1318, 358.651, 16.2188, 1),
(17, 9, 'Los Santos Kauflandos', -30.9502, -91.4111, 1003.55, 1352.34, -1758.82, 13.5078, 5, 0, 18, 0, 1239, 1318, 355.141, 356.976, 0),
(19, 10, 'Ciuchlandos', 161.507, -96.6553, 1001.8, 1102.96, -1440.31, 15.7969, 6, 0, 18, 0, 1239, 1318, 356.07, 264.887, 0),
(20, 11, 'DMV', -2026.88, -104.033, 1035.17, 1081.19, -1697.17, 13.5469, 7, 0, 3, 0, 1239, 1318, 180.357, 173.776, 0),
(21, 12, 'Los Santos Wehrmacht Department', 315.939, -143.663, 999.602, 816.104, -1386.7, 13.6072, 8, 0, 7, 0, 1239, 1318, 0.661926, 177.094, 0),
(22, 13, 'Los Santos Goverment', 390.175, 173.798, 1008.38, 1481.46, -1771.37, 18.7958, 9, 0, 3, 0, 1239, 1318, 84.1154, 356.938, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_faceCodes`
--

CREATE TABLE IF NOT EXISTS `_faceCodes` (
  `charID` int(11) NOT NULL,
  `faceCode` varchar(10) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_faceCodes`
--

INSERT INTO `_faceCodes` (`charID`, `faceCode`, `name`) VALUES
(2, 'OKNM8X', 'Dareczko'),
(5, 'ASDXDD', 'Kubuś'),
(1, 'OKNM8X', 'Darek'),
(1, 'SNR525', 'Rubio'),
(1, 'AT51A6', 'Filip'),
(12, 'ASDXDD', 'Kubas'),
(8, 'SNR525', 'A to chuj Rubik'),
(1, 'AST69C', 'Szychu');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups`
--

CREATE TABLE IF NOT EXISTS `_groups` (
  `ID` int(11) NOT NULL COMMENT 'UID',
  `name` varchar(64) NOT NULL COMMENT 'Nazwa grupy',
  `tag` varchar(4) NOT NULL COMMENT 'Tag',
  `r` smallint(3) NOT NULL DEFAULT '255' COMMENT 'R',
  `g` smallint(3) NOT NULL DEFAULT '255' COMMENT 'G',
  `b` smallint(3) NOT NULL DEFAULT '255' COMMENT 'B',
  `orderType` int(11) NOT NULL COMMENT 'Typ zamawiania',
  `perms` longtext NOT NULL COMMENT 'Uprawnienia',
  `cash` int(11) NOT NULL COMMENT 'Gotówka'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups`
--

INSERT INTO `_groups` (`ID`, `name`, `tag`, `r`, `g`, `b`, `orderType`, `perms`, `cash`) VALUES
(1, 'Los Santos Police Department', 'LSPD', 50, 150, 180, 0, '[ { "itemsteal": true, "chatooc": true, "blockade": true, "orders": true, "vehblock": true, "arrest": true, "ediall": true, "tickets": true, "chatic": true, "gps": true, "meg": true, "doorram": true, "vehfix": true, "mask": true, "news": true, "chatdept": true, "phoneloc": true, "search": true } ]', 0),
(4, 'County General Hospital', 'CGH', 255, 255, 255, 0, '[ { "heal": true, "ediall": true, "chatic": true, "chatooc": true, "chatdept": true, "cpr": true, "orders": true, "offer": true } ]', 0),
(5, 'Los Santos Fire Department', 'LSFD', 255, 255, 255, 0, '[ { "offer": true, "blockade": true, "orders": true, "chatooc": true, "chatic": true, "heal": true, "vehfix": true, "chatdept": true, "ediall": true, "cpr": true, "meg": true, "ladder": true } ]', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups_members`
--

CREATE TABLE IF NOT EXISTS `_groups_members` (
  `ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `rankID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_members`
--

INSERT INTO `_groups_members` (`ID`, `userID`, `rankID`, `groupID`) VALUES
(1, 1, 1, 1),
(2, 6, 2, 1),
(3, 7, 2, 1),
(6, 1, 7, 4),
(7, 8, 8, 4),
(8, 1, 9, 5),
(9, 12, 10, 5),
(10, 14, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups_ranks`
--

CREATE TABLE IF NOT EXISTS `_groups_ranks` (
  `ID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `groupID` int(11) NOT NULL,
  `cash` int(11) NOT NULL,
  `defaultRank` tinyint(1) NOT NULL,
  `perms` longtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_ranks`
--

INSERT INTO `_groups_ranks` (`ID`, `name`, `groupID`, `cash`, `defaultRank`, `perms`) VALUES
(1, 'Lider', 1, 0, 0, '[{"leader": true}]'),
(2, 'Default', 1, 0, 1, '[{"leader": false}]'),
(7, 'Lider', 4, 0, 0, '[{"leader": true}]'),
(8, 'Default', 4, 0, 1, '[{"leader": false}]'),
(9, 'Lider', 5, 0, 0, '[{"leader": true}]'),
(10, 'Default', 5, 0, 1, '[{"leader": false}]');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_intlist`
--

CREATE TABLE IF NOT EXISTS `_intlist` (
  `uid` int(10) unsigned NOT NULL,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `x` float NOT NULL DEFAULT '0',
  `y` float NOT NULL DEFAULT '0',
  `z` float NOT NULL DEFAULT '0',
  `a` float NOT NULL DEFAULT '0',
  `int` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=122 ROW_FORMAT=REDUNDANT;

--
-- Zrzut danych tabeli `_intlist`
--

INSERT INTO `_intlist` (`uid`, `name`, `x`, `y`, `z`, `a`, `int`) VALUES
(1, '24/7 [1]', -25.8845, -185.869, 1003.55, 0, 17),
(2, '24/7 [2]', -6.09118, -29.2719, 1003.55, 0, 10),
(3, '24/7 [3]', -30.9467, -89.6096, 1003.55, 0, 18),
(4, '24/7 [4]', -25.9075, -141.28, 1003.55, 0, 16),
(5, '24/7 [5]', -27.3123, -29.2776, 1003.55, 0, 4),
(6, '24/7 [6]', -26.6916, -55.7149, 1003.55, 0, 6),
(7, 'Francis Ticket Sales Airport', -1827.15, 7.20742, 1061.14, 0, 14),
(8, 'Francis Baggage Claim Airport', -1855.57, 41.2632, 1061.14, 0, 14),
(9, 'Andromada Cargo Hold', 315.856, 1024.5, 1949.8, 0, 9),
(10, 'Shamal Cabin', 2.38483, 33.1034, 1199.85, 0, 1),
(11, 'Interernational Airport', -1830.81, 16.83, 1061.14, 0, 14),
(12, 'Ammunation [1]', 286.149, -40.6444, 1001.57, 0, 1),
(13, 'Ammunation [2]', 286.801, -82.5476, 1001.54, 0, 4),
(14, 'Ammunation [3]', 296.92, -108.072, 1001.57, 0, 6),
(15, 'Ammunation [4]', 314.821, -141.432, 999.662, 0, 7),
(16, 'Ammunation [5]', 316.525, -167.707, 999.662, 0, 6),
(17, 'Booth Ammunation', 302.293, -143.139, 1004.06, 0, 7),
(18, 'Range Ammunation', 280.795, -135.203, 1004.06, 0, 7),
(19, 'B Dups Apartment', 1527.05, -12.0236, 1002.1, 0, 3),
(20, 'B Dups Crack Palace', 1523.51, -47.8211, 1002.27, 0, 2),
(21, 'OG Locs House', 512.929, -11.6929, 1001.57, 0, 3),
(22, 'Ryders house', 2447.87, -1704.45, 1013.51, 0, 2),
(23, 'Sweets house', 2527.02, -1679.21, 1015.5, 0, 1),
(24, 'Madd Doggs Mansion', 1267.84, -776.959, 1091.91, 0, 5),
(25, 'Johnson House', 2496.05, -1695.17, 1014.74, 0, 3),
(26, 'Angel Pine Trailer', 1.1853, -3.2387, 999.428, 0, 2),
(27, 'Safe House', 2233.69, -1112.81, 1050.88, 0, 5),
(28, 'Safe House 2', 2194.79, -1204.35, 1049.02, 0, 6),
(29, 'Safe House 3', 2319.13, -1023.96, 1050.21, 0, 9),
(30, 'Safe House 4', 2262.48, -1138.56, 1050.63, 0, 10),
(31, 'Verdant Bluffs Safehouse', 2365.11, -1133.08, 1050.88, 0, 8),
(32, 'Willowfield Safehouse', 2282.91, -1138.29, 1050.9, 0, 11),
(33, 'The Camels Toe Safehouse', 2216.13, -1076.31, 1050.48, 0, 1),
(34, 'Abandoned AC Tower', 419.894, 2537.12, 10, 0, 10),
(35, 'Burning Desire Building', 2338.32, -1180.61, 1027.98, 0, 5),
(36, 'Colonel Furhberger', 2807.63, -1170.15, 1025.57, 0, 8),
(37, 'Welcome Pump', 681.66, -453.32, -25.61, 0, 1),
(38, 'Wu Zi Mus Apartement', -2158.72, 641.29, 1052.38, 0, 1),
(39, 'House', 234.283, 1065.23, 1084.21, 0, 6),
(40, 'Burglary House 1', 234.609, 1187.82, 1080.26, 0, 3),
(41, 'Burglary House 2', 225.571, 1240.06, 1082.14, 0, 2),
(42, 'Burglary House 3', 224.288, 1289.19, 1082.14, 0, 1),
(43, 'Burglary House 4', 239.282, 1114.2, 1080.99, 0, 5),
(44, 'Burglary House 5', 295.139, 1473.37, 1080.26, 0, 15),
(45, 'Burglary House 6', 261.116, 1287.22, 1080.26, 0, 4),
(46, 'Burglary House 7', 24.3769, 1341.18, 1084.38, 0, 10),
(47, 'Burglary House 8', -262.176, 1456.62, 1084.37, 0, 4),
(48, 'Burglary House 9', 22.861, 1404.92, 1084.43, 0, 5),
(49, 'Burglary House 10', 140.368, 1367.88, 1083.86, 0, 5),
(50, 'Burglary House 11', 234.283, 1065.23, 1084.21, 0, 6),
(51, 'Burglary House 12', -68.5145, 1353.85, 1080.21, 0, 6),
(52, 'Burglary House 13', -285.251, 1471.2, 1084.38, 0, 15),
(53, 'Burglary House 14', -42.5267, 1408.23, 1084.43, 0, 8),
(54, 'Burglary House 15', 84.9244, 1324.3, 1083.86, 0, 9),
(55, 'Burglary House 16', 260.742, 1238.23, 1084.26, 0, 9),
(56, 'Budget Inn Motel Room', 446.325, 509.966, 1001.42, 0, 12),
(57, 'Crack Den', 318.565, 1118.21, 1083.88, 0, 5),
(58, 'RC War Arena', -1079.99, 1061.58, 1343.04, 0, 10),
(59, 'Racing Stadium', -1395.96, -208.197, 1051.17, 0, 7),
(60, 'Racing Stadium 2', -1424.93, -664.587, 1059.86, 0, 4),
(61, 'Bloodbowl Stadium', -1394.2, 987.62, 1023.96, 0, 15),
(62, 'Kickstart Stadium', -1410.72, 1591.16, 1052.53, 0, 14),
(63, 'Caligulas Casino', 2233.8, 1712.23, 1011.76, 0, 1),
(64, '4 Dragons Casino', 2016.27, 1017.78, 996.875, 0, 14),
(65, 'Redsands Casino', 1132.91, -9.7726, 1000.68, 0, 14),
(66, '4 Dragons Managerial Suite', 2000.67, 1015.15, 39.09, 0, 11),
(67, 'Inside Track Betting', 830.602, 5.9404, 1004.18, 0, 3),
(68, 'Caligulas Roof', 2268.52, 1647.77, 1084.23, 0, 1),
(69, 'Tattoo', -203.076, -24.1658, 1002.27, 0, 16),
(70, 'Rusty Donut''s', 378.026, -190.516, 1000.63, 0, 17),
(71, 'Zero''s RC Shop', -2240.1, 136.973, 1035.41, 0, 6),
(72, 'Sex Shop', -100.267, -22.9376, 1000.72, 0, 3),
(73, 'Dillimore Gas Station', 664.19, -570.73, 16.34, 0, 0),
(74, 'Loco Low Co.', 616.782, -74.8151, 997.635, 0, 2),
(75, 'Wheel Arch Angels', 615.285, -124.239, 997.635, 0, 3),
(76, 'Transfender', 617.538, -1.99, 1000.68, 0, 1),
(77, 'Doherty Garage', -2041.23, 178.397, 28.8465, 0, 1),
(78, 'Denises Bedroom', 245.231, 304.763, 999.148, 0, 1),
(79, 'Helena''s Barn', 290.623, 309.062, 999.148, 0, 3),
(80, 'Barbara''s Love Nest', 322.501, 303.691, 999.148, 0, 5),
(81, 'Katie''s Lovenest', 269.641, 305.951, 999.148, 0, 2),
(82, 'Michelle''s Love Nest', 306.197, 307.819, 1003.3, 0, 4),
(83, 'Millie''s Bedroom', 344.998, 307.182, 999.156, 0, 6),
(84, 'Barber Shop', 418.467, -80.4595, 1001.8, 0, 3),
(85, 'Pro-Laps', 206.463, -137.708, 1003.09, 0, 3),
(86, 'Victim', 225.031, -9.1838, 1002.22, 0, 5),
(87, 'SubUrban', 204.117, -46.8047, 1001.8, 0, 1),
(88, 'Reece''s Barber Shop', 414.299, -18.8044, 1001.8, 0, 2),
(89, 'Zip', 161.405, -94.2416, 1001.8, 0, 18),
(90, 'Didier Sachs', 204.166, -165.768, 1000.52, 0, 14),
(91, 'Binco', 207.522, -109.745, 1005.13, 0, 15),
(92, 'Barber Shop 2', 411.971, -51.9217, 1001.9, 0, 12),
(93, 'Wardrobe', 256.905, -41.6537, 1002.02, 0, 14),
(94, 'Brothel', 974.018, -9.5937, 1001.15, 0, 3),
(95, 'Brothel 2', 961.931, -51.9071, 1001.12, 0, 3),
(96, 'The Big Spread Ranch', 1212.08, -28.5799, 1000.95, 0, 3),
(97, 'Dinner', 454.985, -107.255, 999.438, 0, 5),
(98, 'World Of Coq', 445.6, -6.9823, 1000.73, 0, 1),
(99, 'The Pig Pen', 1204.93, -8.165, 1000.92, 0, 2),
(100, 'Club', 490.27, -18.426, 1000.68, 0, 17),
(101, 'Jay''s Diner', 449.017, -88.9894, 999.555, 0, 4),
(102, 'Secret Valley Diner', 442.129, -52.4782, 999.717, 0, 6),
(103, 'Fanny Batter''s Whore House', 748.462, 1438.24, 1102.95, 0, 6),
(104, 'Jizzy''s', -2637.69, 1404.24, 906.46, 0, 3),
(105, 'Burger Shot', 365.41, -73.6167, 1001.51, 0, 10),
(106, 'Well Stacked Pizza', 372.352, -131.651, 1001.49, 0, 5),
(107, 'Cluckin'' Bell', 365.716, -9.8873, 1001.85, 0, 9),
(108, 'Lil'' Probe Inn', -227.57, 1401.55, 27.7656, 0, 18),
(109, 'Los Santos Gym', 772.11, -3.9, 1000.73, 0, 5),
(110, 'San Fierro Gym', 771.863, -40.5659, 1000.69, 0, 6),
(111, 'Las Venturas Gym', 774.068, -71.8559, 1000.65, 0, 7),
(112, 'SF Police Department', 246.4, 110.84, 1003.22, 0, 10),
(113, 'LS Police Department', 246.669, 65.8039, 1003.64, 0, 6),
(114, 'LV Police Department', 288.472, 170.065, 1007.18, 0, 3),
(115, 'Planning Department', 386.526, 173.638, 1008.38, 0, 3),
(116, 'Blastin'' Fools Records', 1037.83, 0.397, 1001.28, 0, 3),
(117, 'Warehouse', 1290.41, 1.9512, 1001.02, 0, 18),
(118, 'Warehouse 2', 1411.44, -2.7966, 1000.92, 0, 1),
(119, 'Meat Factory', 963.059, 2159.76, 1011.03, 0, 1),
(120, 'Bike School', 1494.86, 1306.48, 1093.3, 0, 3),
(121, 'Driving School', -2031.12, -115.829, 1035.17, 0, 3),
(122, 'Big Smoke''s Crack Palace', 2536.53, -1294.84, 1044.12, 0, 2),
(123, 'Atrium', 1726.18, -1641, 20.23, 0, 18),
(124, 'Jefferson Motel', 2220.26, -1148.01, 1025.8, 0, 15),
(125, 'Liberty City', -750.8, 491, 1371.7, 0, 1),
(126, 'Sherman Dam', -944.24, 1886.15, 5.0051, 0, 17),
(127, 'Rosenberg''s Caligulas Office', 2182.2, 1628.58, 1043.87, 0, 2),
(128, '4 Dragons Janitors Office', 1893.07, 1017.9, 31.8828, 0, 10),
(129, 'Czyste lotnisko', 1811, -2439, 13, 0, 0),
(130, 'Bank', 2315.95, -1.61817, 26.7422, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_items`
--

CREATE TABLE IF NOT EXISTS `_items` (
  `ID` int(11) NOT NULL,
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
  `used` tinyint(1) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `rx` float NOT NULL,
  `ry` float NOT NULL,
  `rz` float NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_items`
--

INSERT INTO `_items` (`ID`, `name`, `ownerType`, `owner`, `type`, `slotID`, `val1`, `val2`, `val3`, `volume`, `created`, `lastUsed`, `lastUsedID`, `used`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`) VALUES
(1, 'Telefon', 1, 1, 8, 3, 933048, 1, '', 1, 1436348635, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Beretta 92FS', 1, 6, 1, 1, 24, 0, '3RFJBFF', 2, 1436348637, 1436457171, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Kogut policyjny', 3, 16, 20, 4, 0, 0, '0', 2, 1436348640, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Kostka do gry', 1, 1, 22, 2, 6, 0, '0', 1, 1436349021, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(7, 'Prawo jazdy', 1, 1, 17, 7, 1, 1, '[{"name": "Jeremy Simons"}]', 1, 1436349245, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 'Boombox', 1, 1, 19, 8, 18, 0, '0', 2, 1436446576, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 'Płyta CD', 1, 1, 12, 5, 0, 0, 'http://files.kusmierz.be/rmf/hopbec.pls', 1, 1436446578, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 'Telefon', 1, 8, 8, 1, 442404, 1, '', 1, 1436455313, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(20, 'Beretta 92FS', 1, 8, 1, 2, 24, 0, 'BB7FRVR', 2, 1436455319, 1436457631, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 'Kogut policyjny', 3, 21, 20, 3, 0, 0, '0', 2, 1436455320, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 'Kostka do gry', 1, 12, 22, 1, 6, 0, '0', 1, 1436455727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 'Telefon', 1, 12, 8, 2, 620568, 1, '', 1, 1436455728, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 'Telefon', 1, 6, 8, 3, 728481, 1, '', 1, 1436456990, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 'Kostka do gry', 1, 6, 22, 4, 6, 0, '0', 1, 1436456991, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 'Beretta 92FS', 1, 6, 1, 5, 24, 21, 'RF373N3', 2, 1436456992, 1436457185, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(30, 'Kogut policyjny', 1, 6, 20, 6, 0, 0, '0', 2, 1436456993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 'Boombox', 1, 6, 19, 7, 0, 0, '0', 2, 1436456993, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 'Boombox', 1, 6, 19, 8, 0, 0, '0', 2, 1436456994, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 'Płyta CD', 1, 6, 12, 9, 0, 0, '', 1, 1436456994, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 'Kogut policyjny', 3, 20, 20, 3, 0, 0, '0', 2, 1436457216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(35, 'Beretta 92FS', 1, 12, 1, 4, 24, 8, 'R77NJN7', 2, 1436457231, 1436457272, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 'Mundur LSPD', 1, 14, 3, 1, 280, 1, '1', 2, 1436457700, 1436649910, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(39, 'Broń zagłady.', 1, 8, 1, 3, 23, 960, 'cipa', 1, 1436458389, 1436458506, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(41, 'Kogut policyjny', 3, 19, 20, 7, 0, 0, '0', 2, 1436476159, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(42, 'Telefon', 1, 14, 8, 2, 197857, 1, '', 1, 1436638933, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(43, 'Boombox', 1, 14, 19, 3, 0, 0, '0', 2, 1436638939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(44, 'Płyta CD', 1, 14, 12, 4, 0, 0, '', 1, 1436638940, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(45, 'Kostka do gry', 1, 14, 22, 5, 6, 0, '0', 1, 1436638943, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(46, 'Beretta 92FS', 1, 14, 1, 6, 24, 0, '3RRFRF3', 2, 1436640642, 1436649313, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(47, 'Kogut policyjny', 3, 23, 20, 7, 0, 0, '0', 2, 1436640758, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(48, 'Kajdany', 1, 1, 18, 4, 1, 1, '1', 1, 1436645560, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(49, 'M4A4 Magpul', 1, 14, 1, 7, 31, 4962, '1', 1, 1436649465, 1436649907, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(50, 'Kimber Custom 1911l', 1, 14, 1, 8, 24, 4999, '1', 1, 1436649523, 1436649905, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(51, 'Zwłoki', 1, 1, 7, 6, 1, 1, '[{"name": "Jeremy Simons", "killerDNA": "51dbf7cf8c684c0e288ed866eb764445", "killerWeapon": "0"}]', 1, 1436649844, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(53, 'Beretta 92FS', 1, 1, 1, 1, 24, 174, 'LSPD', 2, 1436738042, 1436783910, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(58, 'Kogut policyjny', 3, 2, 20, 3, 0, 0, '0', 2, 1436745817, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_login_logs`
--

CREATE TABLE IF NOT EXISTS `_login_logs` (
  `ID` int(11) NOT NULL,
  `charID` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `serial` varchar(255) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=425 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_login_logs`
--

INSERT INTO `_login_logs` (`ID`, `charID`, `ip`, `serial`, `time`) VALUES
(1, 21, '192.192.192.192', 'ASTT5472S6T9S8V4T2A63GYSABYT33G5', 1421592909),
(2, 2, '83.9.200.67', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421593126),
(3, 2, '83.9.200.67', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421593665),
(4, 18, '83.30.191.43', 'F2AD37CAB28093F256157B5F077DEEA4', 1421601284),
(5, 16, '178.37.134.3', 'BB7A0947F0CFC156DDB851110B993EA1', 1421601676),
(6, 2, '83.9.200.67', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421601680),
(7, 18, '83.30.191.43', 'F2AD37CAB28093F256157B5F077DEEA4', 1421613811),
(8, 2, '79.185.130.107', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421687278),
(9, 18, '83.7.84.116', 'F2AD37CAB28093F256157B5F077DEEA4', 1421687460),
(10, 19, '83.24.23.233', '47E0506AE143FED71F59001F96B1A343', 1421688595),
(11, 2, '95.49.139.112', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421777857),
(12, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1421778008),
(13, 16, '178.37.134.3', 'BB7A0947F0CFC156DDB851110B993EA1', 1421780146),
(14, 18, '83.7.88.230', 'F2AD37CAB28093F256157B5F077DEEA4', 1421781068),
(15, 18, '83.30.198.48', 'F2AD37CAB28093F256157B5F077DEEA4', 1421783050),
(16, 19, '83.24.18.232', '47E0506AE143FED71F59001F96B1A343', 1421850563),
(17, 2, '95.49.139.112', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421853415),
(18, 2, '83.9.187.17', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421863668),
(19, 2, '83.9.187.17', '695AE5F2800D2C9C26C0DFDABD3E2602', 1421872632),
(20, 18, '83.7.127.157', 'F2AD37CAB28093F256157B5F077DEEA4', 1421873227),
(21, 16, '178.37.134.3', 'BB7A0947F0CFC156DDB851110B993EA1', 1421874378),
(22, 2, '83.31.57.87', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422044566),
(23, 2, '83.31.57.87', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422051286),
(24, 2, '83.9.241.77', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422108469),
(25, 2, '83.9.241.77', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422139274),
(26, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422139414),
(27, 2, '83.9.241.20', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422173704),
(28, 2, '83.9.241.20', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422177461),
(29, 2, '83.9.241.20', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422188095),
(30, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422189833),
(31, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422194319),
(32, 16, '178.37.134.3', 'BB7A0947F0CFC156DDB851110B993EA1', 1422196174),
(33, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422270832),
(34, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422270950),
(35, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422271845),
(36, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422275592),
(37, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422275600),
(38, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422275642),
(39, 19, '83.28.226.75', '47E0506AE143FED71F59001F96B1A343', 1422275870),
(40, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422292413),
(41, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422292757),
(42, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422292822),
(43, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422293074),
(44, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422293325),
(45, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422293394),
(46, 2, '83.24.191.115', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422347419),
(47, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422349630),
(48, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422350404),
(49, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422350594),
(50, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422351036),
(51, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422351381),
(52, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422351639),
(53, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422351650),
(54, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422352422),
(55, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422352478),
(56, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422353003),
(57, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422353045),
(58, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422354062),
(59, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422357890),
(60, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422363975),
(61, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422365428),
(62, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422365734),
(63, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422366511),
(64, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422366570),
(65, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422366632),
(66, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422374639),
(67, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422376359),
(68, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422376362),
(69, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422378195),
(70, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422378222),
(71, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422378788),
(72, 18, '83.5.151.109', 'F2AD37CAB28093F256157B5F077DEEA4', 1422383539),
(73, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422385984),
(74, 18, '83.5.151.109', 'F2AD37CAB28093F256157B5F077DEEA4', 1422386236),
(75, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422387579),
(76, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422392041),
(77, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422398003),
(78, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422398225),
(79, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422399092),
(80, 19, '83.28.224.46', '47E0506AE143FED71F59001F96B1A343', 1422399118),
(81, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422399205),
(82, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422402034),
(83, 18, '83.5.151.109', 'F2AD37CAB28093F256157B5F077DEEA4', 1422403242),
(84, 2, '83.24.190.48', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422405070),
(85, 19, '95.49.21.236', '47E0506AE143FED71F59001F96B1A343', 1422434414),
(86, 19, '95.49.21.236', '47E0506AE143FED71F59001F96B1A343', 1422437206),
(87, 2, '83.9.175.158', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422471564),
(88, 18, '83.7.80.118', 'F2AD37CAB28093F256157B5F077DEEA4', 1422471661),
(89, 19, '95.49.21.236', '47E0506AE143FED71F59001F96B1A343', 1422473561),
(90, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422474650),
(91, 18, '83.7.80.118', 'F2AD37CAB28093F256157B5F077DEEA4', 1422488541),
(92, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422488711),
(93, 19, '83.24.93.234', '47E0506AE143FED71F59001F96B1A343', 1422536115),
(94, 2, '83.24.108.121', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422544070),
(95, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422548876),
(96, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422551517),
(97, 2, '83.24.108.121', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422551518),
(98, 2, '83.9.167.18', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422559979),
(99, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422560618),
(100, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422564242),
(101, 2, '31.61.140.94', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422564405),
(102, 2, '95.49.136.219', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422564897),
(103, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422566504),
(104, 2, '95.49.136.219', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422566594),
(105, 18, '83.5.1.239', 'F2AD37CAB28093F256157B5F077DEEA4', 1422567691),
(106, 19, '83.24.25.125', '47E0506AE143FED71F59001F96B1A343', 1422637668),
(107, 19, '83.24.25.125', '47E0506AE143FED71F59001F96B1A343', 1422638439),
(108, 2, '83.28.249.62', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422646927),
(109, 19, '83.24.25.125', '47E0506AE143FED71F59001F96B1A343', 1422647207),
(110, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422647236),
(111, 19, '83.24.25.125', '47E0506AE143FED71F59001F96B1A343', 1422647561),
(112, 18, '83.22.141.212', 'F2AD37CAB28093F256157B5F077DEEA4', 1422648241),
(113, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1422651234),
(114, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422652018),
(115, 24, '87.205.206.14', '7C9489C13463D874AE29E5C8EC1DF292', 1422652936),
(116, 18, '83.22.141.212', 'F2AD37CAB28093F256157B5F077DEEA4', 1422659403),
(117, 24, '159.205.185.123', '7C9489C13463D874AE29E5C8EC1DF292', 1422710613),
(118, 2, '83.31.247.219', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422718905),
(119, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422718942),
(120, 2, '83.31.247.219', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422728984),
(121, 2, '83.31.247.219', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422729094),
(122, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422729229),
(123, 18, '83.7.224.124', 'F2AD37CAB28093F256157B5F077DEEA4', 1422729936),
(124, 19, '83.24.16.60', '47E0506AE143FED71F59001F96B1A343', 1422730664),
(125, 19, '83.24.25.165', '47E0506AE143FED71F59001F96B1A343', 1422731444),
(126, 18, '83.7.224.124', 'F2AD37CAB28093F256157B5F077DEEA4', 1422733263),
(127, 19, '83.24.25.165', '47E0506AE143FED71F59001F96B1A343', 1422734612),
(128, 2, '83.31.242.65', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422787415),
(129, 19, '83.24.25.165', '47E0506AE143FED71F59001F96B1A343', 1422788180),
(130, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422789990),
(131, 18, '83.7.224.124', 'F2AD37CAB28093F256157B5F077DEEA4', 1422792407),
(132, 2, '83.31.242.65', '695AE5F2800D2C9C26C0DFDABD3E2602', 1422795646),
(133, 19, '83.24.25.165', '47E0506AE143FED71F59001F96B1A343', 1422797285),
(134, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422797305),
(135, 18, '83.30.73.150', 'F2AD37CAB28093F256157B5F077DEEA4', 1422886870),
(136, 2, '83.9.167.198', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423049010),
(137, 19, '83.28.224.215', '47E0506AE143FED71F59001F96B1A343', 1423055227),
(138, 2, '83.9.167.198', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423062622),
(139, 2, '83.9.167.198', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423065277),
(140, 18, '83.30.191.136', 'F2AD37CAB28093F256157B5F077DEEA4', 1423067900),
(141, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423068154),
(142, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423068359),
(143, 2, '178.42.14.85', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423070825),
(144, 16, '77.255.193.53', 'BB7A0947F0CFC156DDB851110B993EA1', 1423072732),
(145, 2, '178.42.14.85', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423124940),
(146, 2, '31.61.129.159', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423139910),
(147, 18, '83.22.141.101', 'F2AD37CAB28093F256157B5F077DEEA4', 1423141027),
(148, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423143407),
(149, 18, '83.22.141.101', 'F2AD37CAB28093F256157B5F077DEEA4', 1423143763),
(150, 18, '83.22.141.101', 'F2AD37CAB28093F256157B5F077DEEA4', 1423143865),
(151, 2, '83.9.146.42', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423155510),
(152, 2, '83.9.146.42', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423156336),
(153, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423159660),
(154, 18, '83.22.141.101', 'F2AD37CAB28093F256157B5F077DEEA4', 1423181814),
(155, 2, '83.24.79.156', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423215518),
(156, 19, '95.49.23.205', '47E0506AE143FED71F59001F96B1A343', 1423217372),
(157, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423219402),
(158, 19, '95.49.23.205', '47E0506AE143FED71F59001F96B1A343', 1423246035),
(159, 2, '83.31.53.151', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423661016),
(160, 18, '83.29.104.137', 'F2AD37CAB28093F256157B5F077DEEA4', 1423662056),
(161, 18, '83.29.104.137', 'F2AD37CAB28093F256157B5F077DEEA4', 1423662350),
(162, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423666065),
(163, 18, '83.29.104.137', 'F2AD37CAB28093F256157B5F077DEEA4', 1423666473),
(164, 2, '83.31.53.151', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423678048),
(165, 2, '83.24.194.133', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423680867),
(166, 2, '83.24.194.133', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423682247),
(167, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423682346),
(168, 18, '83.29.104.137', 'F2AD37CAB28093F256157B5F077DEEA4', 1423682368),
(169, 18, '83.29.104.137', 'F2AD37CAB28093F256157B5F077DEEA4', 1423683457),
(170, 2, '83.31.238.1', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423739277),
(171, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423739293),
(172, 18, '83.29.6.201', 'F2AD37CAB28093F256157B5F077DEEA4', 1423743344),
(173, 2, '178.42.13.120', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423743923),
(174, 18, '83.29.6.201', 'F2AD37CAB28093F256157B5F077DEEA4', 1423744285),
(175, 2, '95.49.136.160', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423755582),
(176, 19, '83.24.94.54', '47E0506AE143FED71F59001F96B1A343', 1423755632),
(177, 18, '83.29.6.201', 'F2AD37CAB28093F256157B5F077DEEA4', 1423757494),
(178, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423757804),
(179, 2, '95.49.136.160', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423830724),
(180, 18, '83.29.92.196', 'F2AD37CAB28093F256157B5F077DEEA4', 1423832673),
(181, 19, '95.49.20.225', '47E0506AE143FED71F59001F96B1A343', 1423853301),
(182, 24, '87.205.205.175', '7C9489C13463D874AE29E5C8EC1DF292', 1423853532),
(183, 2, '83.9.239.103', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423856901),
(184, 19, '95.49.20.225', '47E0506AE143FED71F59001F96B1A343', 1423856975),
(185, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423857038),
(186, 24, '87.205.205.175', '7C9489C13463D874AE29E5C8EC1DF292', 1423857167),
(187, 19, '95.49.20.225', '47E0506AE143FED71F59001F96B1A343', 1423857185),
(188, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423857753),
(189, 2, '83.9.137.190', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423992831),
(190, 2, '83.28.249.60', '695AE5F2800D2C9C26C0DFDABD3E2602', 1423992996),
(191, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423995577),
(192, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423996846),
(193, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1423998498),
(194, 2, '83.28.249.60', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424000892),
(195, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424004938),
(196, 18, '83.29.15.193', 'F2AD37CAB28093F256157B5F077DEEA4', 1424008287),
(197, 24, '78.10.52.137', '7C9489C13463D874AE29E5C8EC1DF292', 1424010490),
(198, 2, '83.28.249.60', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424010496),
(199, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424025924),
(200, 2, '83.28.249.60', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424025992),
(201, 24, '78.10.52.137', '7C9489C13463D874AE29E5C8EC1DF292', 1424026101),
(202, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424026402),
(203, 24, '78.10.52.137', '7C9489C13463D874AE29E5C8EC1DF292', 1424026407),
(204, 2, '83.28.249.60', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424026435),
(205, 18, '83.29.15.193', 'F2AD37CAB28093F256157B5F077DEEA4', 1424026855),
(206, 24, '78.10.52.137', '7C9489C13463D874AE29E5C8EC1DF292', 1424028086),
(207, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424034379),
(208, 18, '83.29.15.193', 'F2AD37CAB28093F256157B5F077DEEA4', 1424034689),
(209, 19, '83.24.98.67', '47E0506AE143FED71F59001F96B1A343', 1424035827),
(210, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424081601),
(211, 2, '83.9.201.141', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424082263),
(212, 25, '83.31.33.161', '561090EE597AAD20E03C44E9ABE8DD94', 1424084216),
(213, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424085468),
(214, 25, '178.43.118.210', '561090EE597AAD20E03C44E9ABE8DD94', 1424087424),
(215, 18, '83.29.102.199', 'F2AD37CAB28093F256157B5F077DEEA4', 1424089887),
(216, 24, '78.10.52.137', '7C9489C13463D874AE29E5C8EC1DF292', 1424091117),
(217, 2, '83.9.201.141', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424102596),
(218, 19, '83.24.98.67', '47E0506AE143FED71F59001F96B1A343', 1424102633),
(219, 24, '87.205.169.224', '7C9489C13463D874AE29E5C8EC1DF292', 1424458243),
(220, 19, '83.24.98.12', '47E0506AE143FED71F59001F96B1A343', 1424458249),
(221, 19, '83.24.98.12', '47E0506AE143FED71F59001F96B1A343', 1424514426),
(222, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424605338),
(223, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424606298),
(224, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424606472),
(225, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424613590),
(226, 19, '95.49.29.104', '47E0506AE143FED71F59001F96B1A343', 1424618965),
(227, 19, '95.49.29.104', '47E0506AE143FED71F59001F96B1A343', 1424620475),
(228, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424622201),
(229, 19, '95.49.29.104', '47E0506AE143FED71F59001F96B1A343', 1424622245),
(230, 2, '83.9.242.226', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424622490),
(231, 19, '95.49.29.104', '47E0506AE143FED71F59001F96B1A343', 1424623146),
(232, 26, '89.69.14.59', '05E4C946457074533929AAE29005C8A2', 1424623166),
(233, 2, '178.42.18.34', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424626668),
(234, 2, '178.42.18.34', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424626942),
(235, 26, '89.69.14.59', '05E4C946457074533929AAE29005C8A2', 1424626960),
(236, 2, '178.42.18.34', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424627177),
(237, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424627549),
(238, 2, '178.42.18.34', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424628089),
(239, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424629059),
(240, 24, '159.205.221.211', '7C9489C13463D874AE29E5C8EC1DF292', 1424629539),
(241, 2, '178.42.18.34', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424629941),
(242, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424630908),
(243, 24, '159.205.221.211', '7C9489C13463D874AE29E5C8EC1DF292', 1424630973),
(244, 18, '83.29.5.150', 'F2AD37CAB28093F256157B5F077DEEA4', 1424634924),
(245, 25, '83.31.186.104', '561090EE597AAD20E03C44E9ABE8DD94', 1424640041),
(246, 25, '83.31.72.183', '561090EE597AAD20E03C44E9ABE8DD94', 1424713089),
(247, 2, '83.9.241.69', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424715162),
(248, 24, '159.205.221.211', '7C9489C13463D874AE29E5C8EC1DF292', 1424716048),
(249, 18, '83.7.59.181', 'F2AD37CAB28093F256157B5F077DEEA4', 1424717271),
(250, 19, '95.49.22.26', '47E0506AE143FED71F59001F96B1A343', 1424718566),
(251, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1424723577),
(252, 25, '83.31.186.36', '561090EE597AAD20E03C44E9ABE8DD94', 1424812280),
(253, 2, '83.9.67.17', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424894916),
(254, 18, '83.22.38.241', 'F2AD37CAB28093F256157B5F077DEEA4', 1424895458),
(255, 24, '159.205.209.150', '7C9489C13463D874AE29E5C8EC1DF292', 1424947748),
(256, 2, '178.42.17.66', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424968916),
(257, 25, '83.31.187.22', '561090EE597AAD20E03C44E9ABE8DD94', 1424972826),
(258, 2, '178.42.17.66', '695AE5F2800D2C9C26C0DFDABD3E2602', 1424982720),
(259, 25, '83.31.187.22', '561090EE597AAD20E03C44E9ABE8DD94', 1424982786),
(260, 25, '83.31.187.22', '561090EE597AAD20E03C44E9ABE8DD94', 1424983074),
(261, 26, '89.69.14.59', '05E4C946457074533929AAE29005C8A2', 1424983468),
(262, 26, '89.69.14.59', '05E4C946457074533929AAE29005C8A2', 1425048238),
(263, 2, '83.9.187.240', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425060376),
(264, 18, '83.22.36.76', 'F2AD37CAB28093F256157B5F077DEEA4', 1425062296),
(265, 18, '83.22.36.76', 'F2AD37CAB28093F256157B5F077DEEA4', 1425064573),
(266, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425199858),
(267, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425211075),
(268, 32, '83.7.65.120', 'F2AD37CAB28093F256157B5F077DEEA4', 1425219850),
(269, 32, '83.7.65.120', 'F2AD37CAB28093F256157B5F077DEEA4', 1425221999),
(270, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425222009),
(271, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425222062),
(272, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425230858),
(273, 32, '83.29.102.187', 'F2AD37CAB28093F256157B5F077DEEA4', 1425232485),
(274, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1425234474),
(275, 19, '83.24.18.44', '47E0506AE143FED71F59001F96B1A343', 1425234549),
(276, 19, '83.24.18.44', '47E0506AE143FED71F59001F96B1A343', 1425234812),
(277, 32, '83.29.102.187', 'F2AD37CAB28093F256157B5F077DEEA4', 1425234887),
(278, 25, '83.31.98.244', '561090EE597AAD20E03C44E9ABE8DD94', 1425235350),
(279, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1425235712),
(280, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425236137),
(281, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425236265),
(282, 2, '83.24.79.2', '7BDE1EAB38B3E157DE7C1ACE98C66BB3', 1425236856),
(283, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425238616),
(284, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425238678),
(285, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1425238681),
(286, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1425238703),
(287, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425238705),
(288, 2, '83.24.79.2', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425238826),
(289, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1425239488),
(290, 26, '89.69.14.59', '05E4C946457074533929AAE29005C8A2', 1425239683),
(291, 32, '83.29.102.187', 'F2AD37CAB28093F256157B5F077DEEA4', 1425242722),
(292, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1425245280),
(293, 19, '83.24.18.97', '47E0506AE143FED71F59001F96B1A343', 1425649939),
(294, 19, '83.28.63.81', '47E0506AE143FED71F59001F96B1A343', 1425917104),
(295, 2, '83.9.188.124', '695AE5F2800D2C9C26C0DFDABD3E2602', 1425933639),
(296, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1425997584),
(297, 2, '83.9.170.242', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426001768),
(298, 18, '83.29.1.118', 'F2AD37CAB28093F256157B5F077DEEA4', 1426002152),
(299, 34, '178.43.106.135', '561090EE597AAD20E03C44E9ABE8DD94', 1426002988),
(300, 2, '83.24.191.58', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426173336),
(301, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1426175937),
(302, 32, '83.29.99.197', 'F2AD37CAB28093F256157B5F077DEEA4', 1426177303),
(303, 32, '83.7.67.221', 'F2AD37CAB28093F256157B5F077DEEA4', 1426177466),
(304, 25, '83.31.197.94', '561090EE597AAD20E03C44E9ABE8DD94', 1426178512),
(305, 2, '178.42.18.86', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426194329),
(306, 34, '83.31.197.94', '561090EE597AAD20E03C44E9ABE8DD94', 1426197006),
(307, 2, '178.42.18.86', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426256135),
(308, 34, '83.24.209.37', '561090EE597AAD20E03C44E9ABE8DD94', 1426256684),
(309, 19, '83.24.20.249', '47E0506AE143FED71F59001F96B1A343', 1426258660),
(310, 2, '83.9.75.23', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426363670),
(311, 24, '78.8.80.57', '7C9489C13463D874AE29E5C8EC1DF292', 1426364940),
(312, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1426372191),
(313, 2, '83.9.75.23', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426411394),
(314, 2, '83.31.238.16', '695AE5F2800D2C9C26C0DFDABD3E2602', 1426531105),
(315, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427541007),
(316, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427541051),
(317, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427541698),
(318, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427541737),
(319, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427541801),
(320, 2, '83.31.52.52', '695AE5F2800D2C9C26C0DFDABD3E2602', 1427543269),
(321, 37, '213.238.81.199', '17B8567D5FEE11349B885FDDA85BF692', 1427584407),
(322, 37, '213.238.81.199', '17B8567D5FEE11349B885FDDA85BF692', 1427748421),
(323, 37, '213.238.81.199', '17B8567D5FEE11349B885FDDA85BF692', 1427753322),
(324, 37, '213.238.81.199', '17B8567D5FEE11349B885FDDA85BF692', 1427753403),
(325, 37, '213.238.81.199', '17B8567D5FEE11349B885FDDA85BF692', 1427990866),
(326, 2, '178.42.20.137', '695AE5F2800D2C9C26C0DFDABD3E2602', 1434700247),
(327, 2, '83.31.55.195', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436111121),
(328, 2, '83.31.55.195', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436111419),
(329, 39, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436112306),
(330, 38, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436112450),
(331, 40, '62.141.204.62', '56AAB62116832D4F9D2BC838A31604A1', 1436112544),
(332, 39, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436112606),
(333, 39, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436112932),
(334, 38, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436113784),
(335, 38, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436113811),
(336, 2, '83.31.55.195', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436119236),
(337, 38, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436123219),
(338, 38, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436132021),
(339, 2, '83.31.55.195', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436132253),
(340, 44, '159.205.46.97', '035827254B7C9038398E3B01E4D22A93', 1436132983),
(341, 42, '83.238.145.143', 'F1564E5DBAED54C952E2A16CE5B972F3', 1436133107),
(342, 49, '78.10.129.138', 'F187DF0D384E7962856A74DAC9990554', 1436133296),
(343, 2, '83.31.55.195', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436133469),
(344, 49, '78.10.129.138', 'F187DF0D384E7962856A74DAC9990554', 1436133771),
(345, 49, '78.10.129.138', 'F187DF0D384E7962856A74DAC9990554', 1436134543),
(346, 2, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436135506),
(347, 2, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436163614),
(348, 5, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436174988),
(349, 5, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436175238),
(350, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436175310),
(351, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436175381),
(352, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436175577),
(353, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436175665),
(354, 5, '159.205.177.127', '7C9489C13463D874AE29E5C8EC1DF292', 1436175888),
(355, 6, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436177452),
(356, 6, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436177503),
(357, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436181179),
(358, 6, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436181576),
(359, 6, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436182196),
(360, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436186456),
(361, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436194959),
(362, 7, '89.65.195.38', '8A16AE4CA34675EA61D36DAEF0BC7384', 1436200591),
(363, 7, '89.65.195.38', '8A16AE4CA34675EA61D36DAEF0BC7384', 1436200758),
(364, 1, '95.49.137.46', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436207579),
(365, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436214763),
(366, 8, '87.205.232.182', '035827254B7C9038398E3B01E4D22A93', 1436216346),
(367, 10, '78.9.2.127', 'F187DF0D384E7962856A74DAC9990554', 1436216721),
(368, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436216930),
(369, 10, '78.9.2.127', 'F187DF0D384E7962856A74DAC9990554', 1436240024),
(370, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436258874),
(371, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436265764),
(372, 11, '62.141.204.62', '56AAB62116832D4F9D2BC838A31604A1', 1436266016),
(373, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436270744),
(374, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436277385),
(375, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436277722),
(376, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436278667),
(377, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436278781),
(378, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436278814),
(379, 1, '83.9.185.29', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436290459),
(380, 6, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1436293381),
(381, 1, '83.9.176.204', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436294203),
(382, 1, '95.49.137.155', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436340160),
(383, 1, '37.47.39.214', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436367697),
(384, 1, '83.9.239.121', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436377795),
(385, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436382323),
(386, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436431938),
(387, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436432020),
(388, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436433728),
(389, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436434193),
(390, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436434320),
(391, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436437600),
(392, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436438048),
(393, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436438159),
(394, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436438216),
(395, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436440112),
(396, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436440727),
(397, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436441134),
(398, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436454968),
(399, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436455079),
(400, 8, '77.253.25.92', '035827254B7C9038398E3B01E4D22A93', 1436455244),
(401, 12, '78.9.2.127', 'F187DF0D384E7962856A74DAC9990554', 1436455599),
(402, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436456289),
(403, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436456732),
(404, 6, '89.79.217.0', '2EE421AC277B43704442189D037FD483', 1436458855),
(405, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436459464),
(406, 1, '178.42.18.9', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436459589),
(407, 1, '79.185.129.51', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436475989),
(408, 13, '83.24.3.194', '705784D4FB51FB1811AFC6D5529B6992', 1436477800),
(409, 7, '89.65.195.38', '8A16AE4CA34675EA61D36DAEF0BC7384', 1436543010),
(410, 1, '83.9.74.41', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436637368),
(411, 14, '83.22.44.26', 'F2AD37CAB28093F256157B5F077DEEA4', 1436638280),
(412, 1, '83.9.74.41', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436647498),
(413, 1, '83.9.74.41', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436647627),
(414, 14, '83.22.44.26', 'F2AD37CAB28093F256157B5F077DEEA4', 1436647628),
(415, 1, '83.9.74.41', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436650453),
(416, 1, '83.9.74.41', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436650578),
(417, 7, '89.65.195.38', '8A16AE4CA34675EA61D36DAEF0BC7384', 1436709789),
(418, 5, '159.205.211.185', '7C9489C13463D874AE29E5C8EC1DF292', 1436734120),
(419, 1, '83.9.136.197', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436737448),
(420, 1, '83.9.136.197', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436776578),
(421, 1, '83.9.136.197', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436777435),
(422, 1, '83.28.252.230', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436778172),
(423, 1, '83.28.252.230', '695AE5F2800D2C9C26C0DFDABD3E2602', 1436779294),
(424, 5, '159.205.211.185', '7C9489C13463D874AE29E5C8EC1DF292', 1436784604);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_objects`
--

CREATE TABLE IF NOT EXISTS `_objects` (
  `ID` int(11) NOT NULL,
  `model` int(11) NOT NULL,
  `x` int(11) NOT NULL,
  `y` int(11) NOT NULL,
  `z` int(11) NOT NULL,
  `rx` int(11) NOT NULL,
  `ry` int(11) NOT NULL,
  `rz` int(11) NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_objects`
--

INSERT INTO `_objects` (`ID`, `model`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`) VALUES
(9, 1931, 1633, -1539, 14, 0, 0, 0, 0, 0),
(12, 1649, 1799, -1742, 14, 0, 0, 180, 0, 0),
(13, 1649, 1794, -1742, 14, 0, 0, 180, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_orders`
--

CREATE TABLE IF NOT EXISTS `_orders` (
  `ID` int(11) NOT NULL,
  `orderSize` int(11) DEFAULT '1',
  `catID` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `orderType` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_orders`
--

INSERT INTO `_orders` (`ID`, `orderSize`, `catID`, `data`, `price`, `name`, `orderType`) VALUES
(1, 1, 1, '[ { "itemName": "Beretta 92FS", "itemType": 1, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 500, 'Beretta 92FS', 1),
(2, 1, 1, '[ { "itemName": "Amunicja: Beretta 92FS", "itemType": 2, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 200, 'Amunicja: Beretta 92FS', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_ordersCat`
--

CREATE TABLE IF NOT EXISTS `_ordersCat` (
  `ID` int(11) NOT NULL,
  `orderType` int(11) NOT NULL,
  `orderOwner` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_ordersCat`
--

INSERT INTO `_ordersCat` (`ID`, `orderType`, `orderOwner`, `name`) VALUES
(1, 1, 0, 'Wyposażenie LSPD');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_phone_contacts`
--

CREATE TABLE IF NOT EXISTS `_phone_contacts` (
  `ID` int(11) NOT NULL,
  `phoneID` int(11) NOT NULL,
  `number` int(6) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_phone_contacts`
--

INSERT INTO `_phone_contacts` (`ID`, `phoneID`, `number`, `name`) VALUES
(1, 60, 676076, 'Rubik to cwel'),
(2, 60, 267270, 'Dareczkowaty'),
(3, 61, 358516, 'Kubasek'),
(4, 57, 358516, 'Kubas Grubas'),
(14, 72, 358516, 'Kubas Grubas'),
(15, 60, 231313, 'Grzehoł'),
(16, 60, 561531, 'Witam test'),
(17, 60, 373988, 'Szychałe'),
(18, 25, 358516, 'Kubasowaty'),
(19, 61, 267270, 'Mój numer'),
(20, 60, 456486, 'Szychu Ciota jest'),
(21, 127, 737118, 'Kociol'),
(22, 123, 737118, 'kociol'),
(23, 122, 936113, 'Kubson.'),
(24, 122, 489399, 'Arteusz.'),
(25, 1, 654321, 'Tomeczek');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_shops`
--

CREATE TABLE IF NOT EXISTS `_shops` (
  `ID` int(11) NOT NULL,
  `shopID` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `itemName` varchar(255) NOT NULL,
  `itemType` int(11) NOT NULL,
  `itemVal1` int(11) NOT NULL,
  `itemVal2` int(11) NOT NULL,
  `itemVal3` text NOT NULL,
  `itemVolume` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_shops`
--

INSERT INTO `_shops` (`ID`, `shopID`, `price`, `itemName`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(1, 9, 20, 'Płyta CD', 12, 0, 0, '', 1),
(2, 9, 2000, 'Boombox', 19, 0, 0, '0', 2),
(3, 9, 500, 'Kogut policyjny', 20, 0, 0, '0', 2),
(5, 9, 5000, 'Beretta 92FS', 1, 24, 35, 'gun-generate', 2),
(6, 9, 600, 'Telefon', 8, 0, 1, 'phone-generate', 1),
(7, 9, 800, 'Kostka do gry', 22, 6, 0, '0', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_vehicles`
--

CREATE TABLE IF NOT EXISTS `_vehicles` (
  `ID` int(11) NOT NULL,
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
  `tireBlock` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_vehicles`
--

INSERT INTO `_vehicles` (`ID`, `name`, `ownerType`, `ownerID`, `c1r`, `c1g`, `c1b`, `c2r`, `c2g`, `c2b`, `model`, `hp`, `spawned`, `locked`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `v1`, `v2`, `fuel`, `maxfuel`, `damage`, `interior`, `dimension`, `flashType`, `distance`, `hasAlarm`, `handbrake`, `tireBlock`) VALUES
(1, 'Police LS', 2, 1, 0, 0, 0, 255, 255, 255, 596, 1000, 1, 0, 1600.46, -1683.98, 5.64609, 359.786, 0.137329, 90.1044, 0, 0, 44.1694, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0, 0),
(2, 'Bullet', 2, 1, 0, 0, 0, 255, 255, 255, 541, 1000, 1, 0, 1600.73, -1687.99, 5.51549, 359.511, 359.995, 91.8347, 0, 0, 37.4388, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0, 0),
(5, 'Bullet', 1, 7, 255, 255, 255, 255, 255, 255, 541, 546.5, 1, 0, 1310.97, -1539.37, 13.1357, 0, 0, -84.5055, 0, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 1, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 2, "door1": 3, "door5": 0, "panel6": 3, "panel2": 2, "panel1": 2, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 0 } ]', 0, 0, 0, 0, 0, 0, 0),
(6, 'Sultan', 1, 10, 255, 255, 255, 255, 255, 255, 560, 1000, 0, 1, 394.28, -407.78, 25.8954, 0, 0, 168.762, 0, 0, 8.40831, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 1, 0, 0),
(8, 'Bullet', 1, 8, 255, 255, 255, 255, 255, 255, 541, 964.5, 0, 0, 1109.45, -1427.97, 15.7969, 0, 0, -45.6063, 0, 0, 0, 50, '[ { "light4": 1, "panel7": 3, "panel3": 0, "door2": 2, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 1, "panel2": 1, "panel1": 0, "light3": 1, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0, 0),
(9, 'Super GT', 1, 10, 255, 255, 255, 255, 255, 255, 506, 1000, 0, 0, 798.959, -1356.95, 13.3828, 0, 0, 126.821, 0, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 1 } ]', 0, 0, 1, 0, 0, 0, 0),
(10, 'Police LS', 1, 10, 0, 0, 0, 255, 255, 255, 596, 1000, 0, 1, 799.454, -1344.05, 13.3828, 0, 0, -76.2202, 0, 0, 48.5637, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 0, 0, 0, 0, 0),
(11, 'Premier', 1, 10, 255, 255, 255, 255, 255, 255, 426, 753.5, 0, 0, 2163.6, -2495.57, 13.375, 0, 0, 93.3893, 0, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 2, "panel6": 1, "panel2": 0, "panel1": 1, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 2 } ]', 0, 0, 0, 0, 0, 0, 0),
(12, 'Monster 1', 1, 11, 255, 255, 255, 255, 255, 255, 444, 881, 0, 0, 1894.04, -1750.43, 13.7263, 1.24695, 3.44971, 89.9835, 0, 0, 37.6825, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 3, "door6": 0, "panel5": 1, "door1": 3, "door5": 2, "panel6": 3, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 2 } ]', 0, 0, 0, 0, 0, 0, 0),
(14, 'Dumper', 1, 11, 255, 255, 255, 255, 255, 255, 406, 643, 0, 0, 1322.42, -2546.76, 13.5469, 0, 0, -82.4825, 0, 0, 42.7967, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 2, "door5": 0, "panel6": 1, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 1 } ]', 0, 0, 0, 0, 0, 0, 0),
(17, 'Clover', 2, 1, 255, 255, 255, 255, 255, 255, 542, 897, 1, 0, 1560.53, -1308.3, 16.5936, 2.03796, 353.798, 267.583, 0, 0, 43.41, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 3, "door5": 0, "panel6": 2, "panel2": 0, "panel1": 2, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 2 } ]', 0, 0, 0, 0, 0, 0, 0),
(18, 'Dumper', 1, 11, 255, 255, 255, 255, 255, 255, 406, 859, 0, 0, 1846.54, -1331.26, 13.3926, 0, 0, -47.6663, 0, 0, 46.4771, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 2, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 0, 0, 0, 0, 0),
(21, 'Sultan', 1, 8, 255, 255, 255, 255, 255, 255, 560, 602.5, 1, 0, 1523.09, -1667.64, 13.3828, 0, 0, -48.4848, 0, 0, 0, 50, '[ { "light4": 0, "panel7": 2, "panel3": 0, "door2": 2, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 4, "door5": 3, "panel6": 2, "panel2": 0, "panel1": 2, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0, 0),
(22, 'Police LS', 1, 1, 248, 0, 0, 255, 255, 255, 596, 1000, 1, 0, 1705.27, -1728.72, 13.3828, 0, 0, 24.7018, 0, 0, 47.4329, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 1, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 2, 0, 0, 0, 0),
(23, 'Sultan', 1, 14, 164, 162, 64, 255, 255, 255, 560, 1000, 1, 0, 1672.02, -1733.83, 13.3828, 0, 0, 195.948, 0, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0, 0),
(24, 'Maverick', 1, 1, 255, 255, 255, 255, 255, 255, 487, 1000, 1, 0, 1688.96, -1729.89, 13.3869, 0, 0, 257.017, 0, 0, 49.9083, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 0, 0, 0, 0, 0);

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `forum_members`
--
ALTER TABLE `forum_members`
  ADD PRIMARY KEY (`id_member`),
  ADD KEY `member_name` (`member_name`),
  ADD KEY `real_name` (`real_name`),
  ADD KEY `date_registered` (`date_registered`),
  ADD KEY `id_group` (`id_group`),
  ADD KEY `birthdate` (`birthdate`),
  ADD KEY `posts` (`posts`),
  ADD KEY `last_login` (`last_login`),
  ADD KEY `lngfile` (`lngfile`(30)),
  ADD KEY `id_post_group` (`id_post_group`),
  ADD KEY `warning` (`warning`),
  ADD KEY `total_time_logged_in` (`total_time_logged_in`),
  ADD KEY `id_theme` (`id_theme`);

--
-- Indexes for table `_3Dtexts`
--
ALTER TABLE `_3Dtexts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_anims`
--
ALTER TABLE `_anims`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `_characters`
--
ALTER TABLE `_characters`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_clothes`
--
ALTER TABLE `_clothes`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_delivers`
--
ALTER TABLE `_delivers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_deposite`
--
ALTER TABLE `_deposite`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_doors`
--
ALTER TABLE `_doors`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_doorsPickup`
--
ALTER TABLE `_doorsPickup`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_groups`
--
ALTER TABLE `_groups`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_groups_members`
--
ALTER TABLE `_groups_members`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_groups_ranks`
--
ALTER TABLE `_groups_ranks`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_intlist`
--
ALTER TABLE `_intlist`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `_items`
--
ALTER TABLE `_items`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_login_logs`
--
ALTER TABLE `_login_logs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_objects`
--
ALTER TABLE `_objects`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_orders`
--
ALTER TABLE `_orders`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_ordersCat`
--
ALTER TABLE `_ordersCat`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_phone_contacts`
--
ALTER TABLE `_phone_contacts`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_shops`
--
ALTER TABLE `_shops`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `_vehicles`
--
ALTER TABLE `_vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `forum_members`
--
ALTER TABLE `forum_members`
  MODIFY `id_member` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=154;
--
-- AUTO_INCREMENT dla tabeli `_3Dtexts`
--
ALTER TABLE `_3Dtexts`
  MODIFY `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT dla tabeli `_anims`
--
ALTER TABLE `_anims`
  MODIFY `uid` int(3) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=128;
--
-- AUTO_INCREMENT dla tabeli `_characters`
--
ALTER TABLE `_characters`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID postaci',AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT dla tabeli `_clothes`
--
ALTER TABLE `_clothes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT dla tabeli `_delivers`
--
ALTER TABLE `_delivers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT dla tabeli `_deposite`
--
ALTER TABLE `_deposite`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_doors`
--
ALTER TABLE `_doors`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT dla tabeli `_doorsPickup`
--
ALTER TABLE `_doorsPickup`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT dla tabeli `_groups`
--
ALTER TABLE `_groups`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'UID',AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT dla tabeli `_groups_members`
--
ALTER TABLE `_groups_members`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT dla tabeli `_groups_ranks`
--
ALTER TABLE `_groups_ranks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT dla tabeli `_intlist`
--
ALTER TABLE `_intlist`
  MODIFY `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=131;
--
-- AUTO_INCREMENT dla tabeli `_items`
--
ALTER TABLE `_items`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT dla tabeli `_login_logs`
--
ALTER TABLE `_login_logs`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=425;
--
-- AUTO_INCREMENT dla tabeli `_objects`
--
ALTER TABLE `_objects`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT dla tabeli `_orders`
--
ALTER TABLE `_orders`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_ordersCat`
--
ALTER TABLE `_ordersCat`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_phone_contacts`
--
ALTER TABLE `_phone_contacts`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT dla tabeli `_shops`
--
ALTER TABLE `_shops`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla tabeli `_vehicles`
--
ALTER TABLE `_vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
