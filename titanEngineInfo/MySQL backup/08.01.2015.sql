-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 10.0.0.152
-- Czas generowania: 08 Sty 2015, 00:47
-- Wersja serwera: 5.5.40-0+wheezy1
-- Wersja PHP: 5.4.34-0+deb7u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Baza danych: `socialGaming_titanProject`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_admin_info_files`
--

CREATE TABLE IF NOT EXISTS `forum_admin_info_files` (
`id_file` tinyint(4) unsigned NOT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `path` varchar(255) NOT NULL DEFAULT '',
  `parameters` varchar(255) NOT NULL DEFAULT '',
  `data` text NOT NULL,
  `filetype` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_admin_info_files`
--

INSERT INTO `forum_admin_info_files` (`id_file`, `filename`, `path`, `parameters`, `data`, `filetype`) VALUES
(1, 'current-version.js', '/smf/', 'version=%3$s', 'window.smfVersion = "SMF 2.0.9";', 'text/javascript'),
(2, 'detailed-version.js', '/smf/', 'language=%1$s&version=%3$s', 'window.smfVersions = {\n	''SMF'': ''SMF 2.0.9'',\n	''SourcesAdmin.php'': ''2.0'',\n	''SourcesBoardIndex.php'': ''2.0'',\n	''SourcesCalendar.php'': ''2.0'',\n	''SourcesClass-Graphics.php'': ''2.0'',\n	''SourcesClass-Package.php'': ''2.0.8'',\n	''SourcesDbExtra-mysql.php'': ''2.0'',\n	''SourcesDbExtra-postgresql.php'': ''2.0'',\n	''SourcesDbExtra-sqlite.php'': ''2.0'',\n	''SourcesDbPackages-mysql.php'': ''2.0'',\n	''SourcesDbPackages-postgresql.php'': ''2.0'',\n	''SourcesDbPackages-sqlite.php'': ''2.0'',\n	''SourcesDbSearch-mysql.php'': ''2.0'',\n	''SourcesDbSearch-postgresql.php'': ''2.0.7'',\n	''SourcesDbSearch-sqlite.php'': ''2.0.7'',\n	''SourcesDisplay.php'': ''2.0.9'',\n	''SourcesDumpDatabase.php'': ''2.0'',\n	''SourcesErrors.php'': ''2.0.4'',\n	''SourcesGroups.php'': ''2.0'',\n	''SourcesHelp.php'': ''2.0'',\n	''SourcesKarma.php'': ''2.0'',\n	''SourcesLoad.php'': ''2.0.9'',\n	''SourcesLockTopic.php'': ''2.0'',\n	''SourcesLogInOut.php'': ''2.0.7'',\n	''SourcesManageAttachments.php'': ''2.0'',\n	''SourcesManageBans.php'': ''2.0'',\n	''SourcesManageBoards.php'': ''2.0'',\n	''SourcesManageCalendar.php'': ''2.0'',\n	''SourcesManageErrors.php'': ''2.0.4'',\n	''SourcesManageMail.php'': ''2.0'',\n	''SourcesManageMaintenance.php'': ''2.0.7'',\n	''SourcesManageMembergroups.php'': ''2.0.7'',\n	''SourcesManageMembers.php'': ''2.0'',\n	''SourcesManageNews.php'': ''2.0.5'',\n	''SourcesManagePaid.php'': ''2.0.3'',\n	''SourcesManagePermissions.php'': ''2.0'',\n	''SourcesManagePosts.php'': ''2.0'',\n	''SourcesManageRegistration.php'': ''2.0'',\n	''SourcesManageScheduledTasks.php'': ''2.0'',\n	''SourcesManageSearch.php'': ''2.0'',\n	''SourcesManageSearchEngines.php'': ''2.0'',\n	''SourcesManageServer.php'': ''2.0.9'',\n	''SourcesManageSettings.php'': ''2.0.6'',\n	''SourcesManageSmileys.php'': ''2.0'',\n	''SourcesMemberlist.php'': ''2.0.8'',\n	''SourcesMessageIndex.php'': ''2.0.2'',\n	''SourcesModerationCenter.php'': ''2.0.1'',\n	''SourcesModlog.php'': ''2.0.7'',\n	''SourcesMoveTopic.php'': ''2.0'',\n	''SourcesNews.php'': ''2.0.8'',\n	''SourcesNotify.php'': ''2.0'',\n	''SourcesPackageGet.php'': ''2.0.9'',\n	''SourcesPackages.php'': ''2.0.9'',\n	''SourcesPersonalMessage.php'': ''2.0.5'',\n	''SourcesPoll.php'': ''2.0'',\n	''SourcesPost.php'': ''2.0.8'',\n	''SourcesPostModeration.php'': ''2.0'',\n	''SourcesPrintpage.php'': ''2.0'',\n	''SourcesProfile.php'': ''2.0.6'',\n	''SourcesProfile-Actions.php'': ''2.0.6'',\n	''SourcesProfile-Modify.php'': ''2.0.7'',\n	''SourcesProfile-View.php'': ''2.0.5'',\n	''SourcesQueryString.php'': ''2.0.9'',\n	''SourcesRecent.php'': ''2.0'',\n	''SourcesRegister.php'': ''2.0.7'',\n	''SourcesReminder.php'': ''2.0.4'',\n	''SourcesRemoveTopic.php'': ''2.0'',\n	''SourcesRepairBoards.php'': ''2.0'',\n	''SourcesReports.php'': ''2.0'',\n	''SourcesSSI.php'': ''2.0.7'',\n	''SourcesScheduledTasks.php'': ''2.0.9'',\n	''SourcesSearch.php'': ''2.0.9'',\n	''SourcesSearchAPI-Custom.php'': ''2.0'',\n	''SourcesSearchAPI-Fulltext.php'': ''2.0'',\n	''SourcesSearchAPI-Standard.php'': ''2.0'',\n	''SourcesSecurity.php'': ''2.0.3'',\n	''SourcesSendTopic.php'': ''2.0'',\n	''SourcesSplitTopics.php'': ''2.0'',\n	''SourcesStats.php'': ''2.0'',\n	''SourcesSubs.php'': ''2.0.8'',\n	''SourcesSubs-Admin.php'': ''2.0'',\n	''SourcesSubs-Auth.php'': ''2.0.9'',\n	''SourcesSubs-BoardIndex.php'': ''2.0'',\n	''SourcesSubs-Boards.php'': ''2.0'',\n	''SourcesSubs-Calendar.php'': ''2.0'',\n	''SourcesSubs-Categories.php'' : ''2.0'',\n	''SourcesSubs-Charset.php'' : ''2.0'',\n	''SourcesSubs-Compat.php'': ''2.0'',\n	''SourcesSubs-Db-mysql.php'': ''2.0.9'',\n	''SourcesSubs-Db-postgresql.php'': ''2.0.4'',\n	''SourcesSubs-Db-sqlite.php'': ''2.0'',\n	''SourcesSubs-Editor.php'': ''2.0.8'',\n	''SourcesSubs-Graphics.php'': ''2.0.9'',\n	''SourcesSubs-List.php'': ''2.0'',\n	''SourcesSubs-Membergroups.php'': ''2.0'',\n	''SourcesSubs-Members.php'': ''2.0.7'',\n	''SourcesSubs-MembersOnline.php'': ''2.0'',\n	''SourcesSubs-Menu.php'': ''2.0.1'',\n	''SourcesSubs-MessageIndex.php'': ''2.0'',\n	''SourcesSubs-OpenID.php'': ''2.0'',\n	''SourcesSubs-Package.php'': ''2.0.9'',\n	''SourcesSubs-Post.php'': ''2.0.9'',\n	''SourcesSubs-Recent.php'': ''2.0'',\n	''SourcesSubscriptions-PayPal.php'': ''2.0.3'',\n	''Sourcessubscriptions.php'': ''2.0.2'',\n	''SourcesSubs-Sound.php'': ''2.0'',\n	''SourcesThemes.php'': ''2.0.4'',\n	''SourcesViewQuery.php'': ''2.0'',\n	''SourcesWho.php'': ''2.0.2'',\n	''SourcesXml.php'': ''2.0'',\n	''DefaultAdmin.template.php'': ''2.0'',\n	''DefaultBoardIndex.template.php'': ''2.0'',\n	''DefaultCalendar.template.php'': ''2.0'',\n	''DefaultCompat.template.php'': ''2.0'',\n	''DefaultDisplay.template.php'': ''2.0'',\n	''DefaultErrors.template.php'': ''2.0'',\n	''DefaultGenericControls.template.php'': ''2.0'',\n	''DefaultGenericList.template.php'': ''2.0'',\n	''DefaultGenericMenu.template.php'': ''2.0'',\n	''DefaultHelp.template.php'': ''2.0.6'',\n	''DefaultLogin.template.php'': ''2.0'',\n	''DefaultManageAttachments.template.php'': ''2.0'',\n	''DefaultManageBans.template.php'': ''2.0'',\n	''DefaultManageBoards.template.php'': ''2.0'',\n	''DefaultManageCalendar.template.php'': ''2.0'',\n	''DefaultManageMail.template.php'': ''2.0'',\n	''DefaultManageMaintenance.template.php'': ''2.0'',\n	''DefaultManageMembergroups.template.php'': ''2.0'',\n	''DefaultManageMembers.template.php'': ''2.0'',\n	''DefaultManageNews.template.php'': ''2.0'',\n	''DefaultManagePaid.template.php'': ''2.0'',\n	''DefaultManagePermissions.template.php'': ''2.0.9'',\n	''DefaultManageScheduledTasks.template.php'': ''2.0'',\n	''DefaultManageSearch.template.php'': ''2.0'',\n	''DefaultManageSmileys.template.php'': ''2.0'',\n	''DefaultMemberlist.template.php'': ''2.0'',\n	''DefaultMessageIndex.template.php'': ''2.0'',\n	''DefaultModerationCenter.template.php'': ''2.0'',\n	''DefaultMoveTopic.template.php'': ''2.0'',\n	''DefaultNotify.template.php'': ''2.0'',\n	''DefaultPackages.template.php'': ''2.0'',\n	''DefaultPersonalMessage.template.php'': ''2.0'',\n	''DefaultPoll.template.php'': ''2.0'',\n	''DefaultPost.template.php'': ''2.0'',\n	''DefaultPrintpage.template.php'': ''2.0'',\n	''DefaultProfile.template.php'': ''2.0'',\n	''DefaultRecent.template.php'': ''2.0'',\n	''DefaultRegister.template.php'': ''2.0'',\n	''DefaultReminder.template.php'': ''2.0'',\n	''DefaultReports.template.php'': ''2.0'',\n	''DefaultSearch.template.php'': ''2.0'',\n	''DefaultSendTopic.template.php'': ''2.0'',\n	''DefaultSettings.template.php'': ''2.0'',\n	''DefaultSplitTopics.template.php'': ''2.0'',\n	''DefaultStats.template.php'': ''2.0'',\n	''DefaultThemes.template.php'': ''2.0.7'',\n	''DefaultWho.template.php'': ''2.0'',\n	''DefaultWireless.template.php'': ''2.0'',\n	''DefaultXml.template.php'': ''2.0'',\n	''Defaultindex.template.php'': ''2.0'',\n	''TemplatesAdmin.template.php'': ''2.0'',\n	''TemplatesBoardIndex.template.php'': ''2.0'',\n	''TemplatesCalendar.template.php'': ''2.0'',\n	''TemplatesDisplay.template.php'': ''2.0'',\n	''TemplatesErrors.template.php'': ''2.0'',\n	''TemplatesGenericControls.template.php'': ''2.0'',\n	''TemplatesGenericList.template.php'': ''2.0'',\n	''TemplatesGenericMenu.template.php'': ''2.0'',\n	''TemplatesHelp.template.php'': ''2.0'',\n	''TemplatesLogin.template.php'': ''2.0'',\n	''TemplatesManageAttachments.template.php'': ''2.0'',\n	''TemplatesManageBans.template.php'': ''2.0'',\n	''TemplatesManageBoards.template.php'': ''2.0'',\n	''TemplatesManageCalendar.template.php'': ''2.0'',\n	''TemplatesManageMail.template.php'': ''2.0'',\n	''TemplatesManageMaintenance.template.php'': ''2.0'',\n	''TemplatesManageMembergroups.template.php'': ''2.0'',\n	''TemplatesManageMembers.template.php'': ''2.0'',\n	''TemplatesManageNews.template.php'': ''2.0'',\n	''TemplatesManagePaid.template.php'': ''2.0'',\n	''TemplatesManagePermissions.template.php'': ''2.0.9'',\n	''TemplatesManageSearch.template.php'': ''2.0'',\n	''TemplatesManageSmileys.template.php'': ''2.0'',\n	''TemplatesMemberlist.template.php'': ''2.0'',\n	''TemplatesMessageIndex.template.php'': ''2.0'',\n	''TemplatesModerationCenter.template.php'': ''2.0'',\n	''TemplatesModlog.template.php'': ''2.0'',\n	''TemplatesMoveTopic.template.php'': ''2.0'',\n	''TemplatesNotify.template.php'': ''2.0'',\n	''TemplatesPackages.template.php'': ''2.0'',\n	''TemplatesPersonalMessage.template.php'': ''2.0'',\n	''TemplatesPoll.template.php'': ''2.0'',\n	''TemplatesPost.template.php'': ''2.0'',\n	''TemplatesPrintpage.template.php'': ''2.0'',\n	''TemplatesProfile.template.php'': ''2.0'',\n	''TemplatesRecent.template.php'': ''2.0'',\n	''TemplatesRegister.template.php'': ''2.0'',\n	''TemplatesReminder.template.php'': ''2.0'',\n	''TemplatesReports.template.php'': ''2.0'',\n	''TemplatesSearch.template.php'': ''2.0'',\n	''TemplatesSendTopic.template.php'': ''2.0'',\n	''TemplatesSettings.template.php'': ''2.0'',\n	''TemplatesSplitTopics.template.php'': ''2.0'',\n	''TemplatesStats.template.php'': ''2.0'',\n	''TemplatesThemes.template.php'': ''2.0'',\n	''TemplatesWho.template.php'': ''2.0'',\n	''TemplatesWireless.template.php'': ''2.0'',\n	''TemplatesXml.template.php'': ''2.0'',\n	''Templatesindex.template.php'': ''2.0''\n};\n\nwindow.smfLanguageVersions = {\n	''Admin'': ''2.0'',\n	''EmailTemplates'': ''2.0'',\n	''Errors'': ''2.0'',\n	''Help'': ''2.0'',\n	''index'': ''2.0.8'',\n	''Install'': ''2.0'',\n	''Login'': ''2.0'',\n	''ManageBoards'': ''2.0'',\n	''ManageCalendar'': ''2.0'',\n	''ManageMail'': ''2.0'',\n	''ManageMaintenance'': ''2.0'',\n	''ManageMembers'': ''2.0'',\n	''ManagePaid'': ''2.0'',\n	''ManagePermissions'': ''2.0'',\n	''ManageScheduledTasks'': ''2.0'',\n	''ManageSettings'': ''2.0'',\n	''ManageSmileys'': ''2.0'',\n	''Manual'': ''2.0'',\n	''ModerationCenter'': ''2.0'',\n	''Modifications'': ''2.0'',\n	''Modlog'': ''2.0'',\n	''Packages'': ''2.0'',\n	''PersonalMessage'': ''2.0'',\n	''Post'': ''2.0'',\n	''Profile'': ''2.0'',\n	''Reports'': ''2.0'',\n	''Search'': ''2.0'',\n	''Settings'': ''2.0'',\n	''Stats'': ''2.0'',\n	''Themes'': ''2.0'',\n	''Who'': ''2.0'',\n	''Wireless'': ''2.0''\n};\n', 'text/javascript'),
(3, 'latest-news.js', '/smf/', 'language=%1$s&format=%2$s', '\nwindow.smfAnnouncements = [\n	{\n		subject: ''SMF 2.1 Beta 1 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=530233.0'',\n		time: ''November 20, 2014, 07:40:06 PM'',\n		author: ''Oldiesmann'',\n		message: ''Simple Machines is proud to announce the first beta of the next version of SMF, with many improvements and new features!''\n	},\n	{\n		subject: ''SMF 2.0.9 and 1.1.20 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=528448.0'',\n		time: ''October 02, 2014, 07:13:50 PM'',\n		author: ''Oldiesmann'',\n		message: ''Critical security patches have been released, addressing a few vulnerabilities in SMF 2.0.x and SMF 1.1.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.8 released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=524016.0'',\n		time: ''June 18, 2014, 10:11:32 AM'',\n		author: ''Oldiesmann'',\n		message: ''A patch has been released, addressing memory issues with 2.0.7, MySQL 5.6 compatibility issues and a rare memberlist search bug. We urge all forum administrators to upgrade to SMF 2.0.8&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.7 released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=517205.0'',\n		time: ''January 20, 2014, 09:48:07 PM'',\n		author: ''Oldiesmann'',\n		message: ''A patch has been released, addressing several bugs, including PHP 5.5 compatibility.  We urge all forum administrators to upgrade to SMF 2.0.7&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.6 and 1.1.19 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=512964.0'',\n		time: ''October 22, 2013, 09:00:00 AM'',\n		author: ''Illori'',\n		message: ''Critical security patches have been released, addressing few vulnerabilities in SMF 2.0.x and SMF 1.1.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.5 security patches has been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=509417.0'',\n		time: ''August 12, 2013, 08:34:06 PM'',\n		author: ''Oldiesmann'',\n		message: ''A critical security patch has been released, addressing a few vulnerabilities in SMF 2.0.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.4 and 1.1.18 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=496403.0'',\n		time: ''February 01, 2013, 05:27:00 PM'',\n		author: ''emanuele'',\n		message: ''Critical security patches have been released, addressing few vulnerabilities in SMF 2.0.x and SMF 1.1.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.3, 1.1.17 and 1.0.23 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=492786.0'',\n		time: ''December 16, 2012, 11:41:05 PM'',\n		author: ''emanuele'',\n		message: ''Security patches have been released, addressing a vulnerability in SMF 2.0.x, SMF 1.1.x and SMF 1.0.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.2 and 1.1.16 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=463103.0'',\n		time: ''December 23, 2011, 12:41:31 AM'',\n		author: ''Norv'',\n		message: ''Critical security patches have been released, addressing vulnerabilities in SMF 2.0.x and SMF 1.1.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0.1 and 1.1.15 security patches have been released.'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=452888.0'',\n		time: ''September 18, 2011, 04:48:18 PM'',\n		author: ''Norv'',\n		message: ''Critical security patches have been released, addressing vulnerabilities in SMF 2.0 and SMF 1.1.x. We urge all administrators to upgrade as soon as possible. Just visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0 Gold'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=421547.0'',\n		time: ''June 04, 2011, 05:00:00 PM'',\n		author: ''Norv'',\n		message: ''SMF 2.0 has gone Gold! Please upgrade your forum from older versions, as 2.0 is now the stable version, and mods and themes will be built on it.''\n	},\n	{\n		subject: ''SMF 1.1.13, 2.0 RC4 security patch and SMF 2.0 RC5 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=421547.0'',\n		time: ''February 11, 2011, 03:16:35 PM'',\n		author: ''Norv'',\n		message: ''Simple Machines announces the release of important security patches for SMF 1.1.x and SMF 2.0 RC4, along with the fifth Release Candidate of SMF 2.0. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 2.0 RC4 and SMF 1.1.12 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=407256.0'',\n		time: ''November 01, 2010, 12:14:21 PM'',\n		author: ''Norv'',\n		message: ''Simple Machines is pleased to announce the release of the fourth Release Candidate of SMF 2.0, along with an important security patch for SMF 1.1.x. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 2.0 RC3 Public released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=369616.0'',\n		time: ''March 08, 2010, 06:03:11 PM'',\n		author: ''Aaron'',\n		message: ''Simple Machines is pleased to announce the release of the third Release Candidate of SMF 2.0. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 1.1.11 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=351341.0'',\n		time: ''December 01, 2009, 05:59:19 PM'',\n		author: ''SleePy'',\n		message: ''A patch has been released, addressing multiple vulnerabilites.  We urge all forum administrators to upgrade to 1.1.11. Simply visit the package manager to install the patch. Also for those still using the 1.0 branch, version 1.0.19 has been released.''\n	},\n	{\n		subject: ''SMF 2.0 RC2 Public released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=346813.0'',\n		time: ''November 08, 2009, 07:10:03 PM'',\n		author: ''Aaron'',\n		message: ''Simple Machines is very pleased to announce the release of the second Release Candidate of SMF 2.0. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 1.1.10 and 2.0 RC1.2 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=324169.0'',\n		time: ''July 14, 2009, 07:05:19 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released, addressing a few security vulnerabilites.  We urge all forum administrators to upgrade to either 1.1.10 or 2.0 RC1.2, depending on the current version. Simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1.9 and 2.0 RC1-1 released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=311899.0'',\n		time: ''May 20, 2009, 08:40:41 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released, addressing multiple security vulnerabilites.  We urge all forum administrators to upgrade to either 1.1.9 or 2.0 RC1-1, depending on the current version. Simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0 RC1 Public Released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=290609.0'',\n		time: ''February 04, 2009, 11:10:01 PM'',\n		author: ''Compuart'',\n		message: ''Simple Machines are very pleased to announce the release of the first Release Candidate of SMF 2.0. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 1.1.8'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=290608.0'',\n		time: ''February 04, 2009, 11:08:44 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released, addressing multiple security vulnerabilites.  We urge all forum administrators to upgrade to SMF 1.1.8&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1.7'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=272861.0'',\n		time: ''November 07, 2008, 02:15:36 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released, addressing multiple security vulnerabilites.  We urge all forum administrators to upgrade to SMF 1.1.7&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1.6'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=260145.0'',\n		time: ''September 07, 2008, 04:38:05 AM'',\n		author: ''Compuart'',\n		message: ''A patch has been released fixing a few bugs and addressing a security vulnerability.  We urge all forum administrators to upgrade to SMF 1.1.6&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1.5'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=236816.0'',\n		time: ''April 20, 2008, 09:56:14 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released fixing a few bugs and addressing some security vulnerabilities.  We urge all forum administrators to upgrade to SMF 1.1.5&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0 Beta 3 Public Released'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=228921.0'',\n		time: ''March 17, 2008, 03:20:21 PM'',\n		author: ''Grudge'',\n		message: ''Simple Machines are very pleased to announce the release of the first public beta of SMF 2.0. Please visit the Simple Machines site for more information on how you can help test this new release.''\n	},\n	{\n		subject: ''SMF 1.1.4'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=196380.0'',\n		time: ''September 24, 2007, 09:07:36 PM'',\n		author: ''Compuart'',\n		message: ''A patch has been released to address some security vulnerabilities discovered in SMF 1.1.3.  We urge all forum administrators to upgrade to SMF 1.1.4&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 2.0 Beta 1 Released to Charter Members'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=190812.0'',\n		time: ''August 25, 2007, 07:29:25 AM'',\n		author: ''Grudge'',\n		message: ''Simple Machines are pleased to announce the first beta of SMF 2.0 has been released to our Charter Members. Visit the Simple Machines site for information on what\\''s new''\n	},\n	{\n		subject: ''SMF 1.1.3'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=178757.0'',\n		time: ''June 24, 2007, 09:52:40 PM'',\n		author: ''Thantos'',\n		message: ''A number of small bugs and a potential security issue have been discovered in SMF 1.1.2.  We urge all forum administrators to upgrade to SMF 1.1.3&mdash;simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1.2'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=149553.0'',\n		time: ''February 11, 2007, 08:35:45 AM'',\n		author: ''Grudge'',\n		message: ''A patch has been released to address a number of outstanding bugs in SMF 1.1.1, including several around UTF-8 language support. In addition this patch offers improved image verification support and fixes a couple of low risk security related bugs. If you need any help upgrading please visit our forum.''\n	},\n	{\n		subject: ''SMF 1.1.1'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=134971.0'',\n		time: ''December 17, 2006, 09:33:41 AM'',\n		author: ''Grudge'',\n		message: ''A number of small bugs and a potential security issue have been discovered in SMF 1.1. We urge all forum administrators to upgrade to SMF 1.1.1 - simply visit the package manager to install the patch.''\n	},\n	{\n		subject: ''SMF 1.1'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=131008.0'',\n		time: ''December 02, 2006, 02:53:16 PM'',\n		author: ''Grudge'',\n		message: ''SMF 1.1 has gone gold!  If you are using an older version, please upgrade as soon as possible - many things have been changed and fixed, and mods and packages will expect you to be using 1.1.  If you need any help upgrading custom modifications to the new version, please feel free to ask us at our forum.''\n	},\n	{\n		subject: ''SMF 1.0.9 and patch for SMF 1.1 RC3'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=123285.0'',\n		time: ''October 29, 2006, 05:57:14 AM'',\n		author: ''Compuart'',\n		message: ''A security issue has been discovered in both SMF 1.0 and SMF 1.1. Therefore a patch has been released that will upgrade SMF 1.0.8 to 1.0.9 and update SMF 1.1 RC3. You are encouraged to update immediately, using the package manager or otherwise.''\n	},\n	{\n		subject: ''SMF 1.1 RC3'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=107112.0'',\n		time: ''August 21, 2006, 07:32:19 PM'',\n		author: ''Grudge'',\n		message: ''Release Candidate 3 of SMF 1.1 has been released! This is the final update to SMF 1.1 before it goes final - and includes UTF support as well as numerous bug fixes. Please read the announcement for details - and only upgrade if you are comfortable running software yet to go gold.''\n	},\n	{\n		subject: ''SMF 1.0.8'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=107135.0'',\n		time: ''August 21, 2006, 07:32:19 PM'',\n		author: ''Compuart'',\n		message: ''A security issue has been reported in PHP causing a vulnerability in SMF. A patch has been released to upgrade Simple Machines Forum from 1.0.7 to 1.0.8. You are encouraged to update immediately, using the package manager or otherwise.''\n	},\n	{\n		subject: ''SMF 1.0.7 and patch for SMF 1.1 RC2'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=78841.0'',\n		time: ''March 29, 2006, 05:32:12 PM'',\n		author: ''Compuart'',\n		message: ''A security issue has been discovered in both SMF 1.0 and SMF 1.1. Therefor a patch has been released that will upgrade SMF 1.0.6 to 1.0.7 and update SMF 1.1 RC2. You are encouraged to update immediately, using the package manager or otherwise.''\n	},\n	{\n		subject: ''SMF 1.0.6'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=68110.0'',\n		time: ''January 28, 2006, 06:36:25 AM'',\n		author: ''Grudge'',\n		message: ''SMF 1.0.6 has been released.  This release addresses a potential security issue as well as a few minor bugs found since the 1.0.5 release. You are encouraged to update immediately, using the package manager or otherwise. This update does not apply to the 1.1 line!''\n	},\n	{\n		subject: ''Bug in Firefox 1.5'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=66862.0'',\n		time: ''January 24, 2006, 08:09:45 AM'',\n		author: ''Grudge'',\n		message: ''There is a bug in Firefox 1.5 which can cause server issues for forums running SMF 1.1 (RC1/RC2). There is a simple fix which can be downloaded from the Simple Machines forum.''\n	},\n	{\n		subject: ''SMF 1.1 RC2'',\n		href: ''http://www.simplemachines.org/community/index.php?topic=62731.0'',\n		time: ''December 31, 2005, 02:58:20 PM'',\n		author: ''Grudge'',\n		message: ''The second (and final) Release Candidate of SMF 1.1 has been released! Please read the announcement for details - and please update only if you are certain you are comfortable with software that hasn\\''t gone gold yet. There is no package manager style update for this version.''\n	}\n];\nif (window.smfVersion < "SMF 1.1")\n{\n	window.smfUpdateNotice = ''SMF 1.1 Final has now been released. To take advantage of the improvements available in SMF 1.1 we recommend upgrading as soon as is practical.'';\n	window.smfUpdateCritical = false;\n}\n\nif (document.getElementById("yourVersion"))\n{\n	var yourVersion = getInnerHTML(document.getElementById("yourVersion"));\n	if (yourVersion == "SMF 1.0.4")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_1-0-5_package.tar.gz";\n	else if (yourVersion == "SMF 1.0.5" || yourVersion == "SMF 1.0.6")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz";\n		window.smfUpdateCritical = false;\n	}\n	else if (yourVersion == "SMF 1.0.7")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_1-0-8_package.tar.gz";\n	else if (yourVersion == "SMF 1.0.8")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1-0-9_1-1-rc3-1.tar.gz";\n	else if (yourVersion == "SMF 1.0.9")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_1-0-10_patch.tar.gz";\n	else if (yourVersion == "SMF 1.0.10" || yourVersion == "SMF 1.1.2")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.3_1.0.11.tar.gz";\n	else if (yourVersion == "SMF 1.0.11" || yourVersion == "SMF 1.1.3" || yourVersion == "SMF 2.0 beta 1")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.0.12" || yourVersion == "SMF 1.1.4" || yourVersion == "SMF 2.0 beta 3 Public")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip";\n	else if (yourVersion == "SMF 1.0.13" || yourVersion == "SMF 1.1.5")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.14_1.1.6.zip";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.0.14" || yourVersion == "SMF 1.1.6")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.15_1.1.7.zip";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.0.15" || yourVersion == "SMF 1.1.7")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.16_1.1.8.zip";\n		window.smfUpdateCritical = false;\n	}\n	else if (yourVersion == "SMF 1.0.16" || yourVersion == "SMF 1.1.8" || yourVersion == "SMF 2.0 RC1")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip";\n	else if (yourVersion == "SMF 1.0.17" || yourVersion == "SMF 1.1.9" || yourVersion == "SMF 2.0 RC1-1")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2.zip";\n	else if (yourVersion == "SMF 1.0.18" || yourVersion == "SMF 1.1.10")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.19_1.1.11.zip";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.0.19" || yourVersion == "SMF 1.1.11")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.20_1.1.12.tar.gz";\n	}\n	else if (yourVersion == "SMF 1.0.20" || yourVersion == "SMF 1.1.12")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.21_1.1.13.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.14")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.15.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 2.0")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.1.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.15" || yourVersion == "SMF 1.0.21")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.22_1.1.16.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 2.0.1")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.2.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.16" || yourVersion == "SMF 1.0.22")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.23_1.1.17.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.17")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.18.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 2.0.2")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.3.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 2.0.3")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.4.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 2.0.4")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.5.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.18" || yourVersion == "SMF 2.0.5")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.19_2.0.6.tar.gz";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1.19" || yourVersion == "SMF 2.0.8")\n	{\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.20_2.0.9.zip";\n		window.smfUpdateCritical = true;\n	}\n	else if (yourVersion == "SMF 1.1")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_1-1-1_patch.tar.gz";\n	else if (yourVersion == "SMF 1.1.1")\n		window.smfUpdatePackage = "http://custom.simplemachines.org/mods/downloads/smf_1-1-2_patch.tar.gz";\n}\n\nif (document.getElementById(''credits''))\n	setInnerHTML(document.getElementById(''credits''), getInnerHTML(document.getElementById(''credits'')).replace(/anyone we may have missed/, ''<span title="And you thought you had escaped the credits, hadn\\''t you, Zef Hemel?">anyone we may have missed</span>''));\n', 'text/javascript');
INSERT INTO `forum_admin_info_files` (`id_file`, `filename`, `path`, `parameters`, `data`, `filetype`) VALUES
(4, 'latest-packages.js', '/smf/', 'language=%1$s&version=%3$s', 'var actionurl = ''?action=admin;area=packages;sa=download;get;package='';if (typeof(window.smfForum_sessionvar) == "undefined")\n	window.smfForum_sessionvar = ''sesc'';\n\nif (typeof(window.smfVersion) != "undefined")\n{\n	var version = window.smfVersion;\n\n	// We might need this...\n	var smf_modificationInfo = {};\n	\n	switch (version)\n	{\n		case "SMF 1.0":\n			window.smfLatestPackages = ''As was inevitable, a few small mistakes have been found in 1.0.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-1_update.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.1":\n			window.smfLatestPackages = ''A few problems have been found in the package manager\\''s modification code, among a few other issues.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-2_update.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.2":\n			window.smfLatestPackages = ''A problem has been found in the system that sends critical database messages.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-3_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.3":\n			window.smfLatestPackages = ''A few bugs have been fixed since SMF 1.0.3, and a problem with parsing nested BBC tags addressed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-4_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.4":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.4.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-5_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.5":\n			window.smfLatestPackages = ''A bbc security issue has been identified in SMF 1.0.5.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.6":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.6.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.7":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.7.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-8_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.8":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.8.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1-0-9_1-1-rc3-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.9":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.9.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-10_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.10":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.10.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.3_1.0.11.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.11":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.11 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.12":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.12 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.13":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.13 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.14_1.1.6.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.14.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.14":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.14. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.15_1.1.7.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.15.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.15":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.15. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.16_1.1.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.16.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.16":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.16. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.17.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.17":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.17. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.18":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.18. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.19_1.1.11.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.19.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.19":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.19. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.20_1.1.12.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.20.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.20":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.20. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.21_1.1.13.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.21.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.21":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.21. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.22_1.1.16.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.22.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.22":\n			window.smfLatestPackages = ''A security vulnerability has been identified in SMF 1.0.22. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.23_1.1.17.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.23.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.23":\n			window.smfLatestPackages = ''SMF 1.0 was released to the world in December 2004 and has been supported for more than eight years. Starting from the 1st of January 2013 it will not receive security updates any more. Anyone still using a 1.0 release should investigate migrating to the latest SMF version. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1 Beta 2":\n			window.smfLatestPackages = ''A few bugs have been fixed since SMF 1.1 Beta 2, and a problem with parsing nested BBC tags addressed.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-beta2-fix1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily fix the problem.<br /><br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> or in the helpdesk if you need more help.'';\n			break;\n		case "SMF 1.1 RC2":\n			if (!in_array("smf:smf_1-1-rc2-2", window.smfInstalledPackages))\n				window.smfLatestPackages = ''A security issue has been identified in SMF 1.1 RC2. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			else\n				showLatestPackages();\n			break;\n		case "SMF 1.1":\n			window.smfLatestPackages = ''A number of small bugs and a security issue have been identified in SMF 1.1 Final. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-1_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.1":\n			window.smfLatestPackages = ''A number of bugs and a couple of low risk security issues have been identified in SMF 1.1.1 - and some improvements have been made to the visual verification images on registration. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-2_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.2.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.2":\n			window.smfLatestPackages = ''A number of bugs and a couple of low risk security issues have been identified in SMF 1.1.2 - and some improvements have been made to the package manager. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.3_1.0.11.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.3.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.3":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.3 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.4.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.4":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.4 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.5.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.5":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.5 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.14_1.1.6.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.6.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.6":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.6. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.15_1.1.7.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.7.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.7":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.7. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.16_1.1.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.8.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.8":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.8. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.9.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.9":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.9. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.10.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.10":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.10. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.19_1.1.11.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.11.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.11":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.11. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.20_1.1.12.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.12":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.12. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.21_1.1.13.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.13.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.13":\n			window.smfLatestPackages = ''A security vulnerability have been identified in SMF 1.1.13. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.14.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.14.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.14":\n			window.smfLatestPackages = ''A security vulnerability have been identified in SMF 1.1.14. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.15.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.15.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.15":\n			window.smfLatestPackages = ''A couple of security vulnerabilities have been identified in SMF 1.1.15. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.22_1.1.16.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.16.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.16":\n			window.smfLatestPackages = ''A security vulnerability has been identified in SMF 1.1.16. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.23_1.1.17.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.17.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.17":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.17. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.18.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.18":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.18. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.19_2.0.6.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.19":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.19. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.20_2.0.9.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.20.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 Beta 1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 beta 1 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0 beta 1.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 Beta 3 Public":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 beta 3 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0 beta 3.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC1. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0-RC1-1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC1-1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC1-1. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0-RC1.2 .<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC4":\n			if (typeof(window.smfRC4patch) == "undefined")\n				window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC4. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0-RC4_security.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to install the security patch for SMF 2.0 RC4.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			else\n				showLatestPackages();\n			break;\n		case "SMF 2.0":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.1":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.1 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.2.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.2":\n			window.smfLatestPackages = ''A security vulnerability and few bugs in SMF 2.0.2 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.3.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.3":\n			window.smfLatestPackages = ''A few security vulnerabilities in SMF 2.0.3 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.4.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.4":\n			window.smfLatestPackages = ''A few security vulnerabilities in SMF 2.0.4 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.5.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.5":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.5 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.19_2.0.6.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.6":\n			window.smfLatestPackages = ''PHP 5.5 compatibility issues and several other bugs have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.7.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.7.<br /><br />If you have any problems applying it, you can try to use the upgrade file posted on the downloads page - although, any modifications you have installed will need to be uninstalled when you use that method.<br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.7":\n			window.smfLatestPackages = ''Memory issues encountered with SMF 2.0.7, some MySQL 5.6 compatibility issues and a rare bug with the memberlist search feature have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.8.<br /><br />If you have any problems applying it, you can try to use the upgrade file posted on the downloads page - although, any modifications you have installed will need to be uninstalled when you use that method.<br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.8":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.8 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.20_2.0.9.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.9.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		default:\n			showLatestPackages();\n			break;\n	}\n}\nelse\n{\n	window.smfLatestPackages = ''For the package manager to function properly, please upgrade to the latest version of SMF.'';\n}\n\n// This function shows latest mods when there isn''t anything else to display\nfunction showLatestPackages()\n{\n	smf_modificationInfo = {\n	\n		4016: {\n			name: ''Modified No Topics Message 1.0'',\n			versions: [''80''],\n			desc: ''<hr /><div align="center"><span style="color: red;" class="bbc_color"><span style="font-size: 16pt;" class="bbc_size"><strong>MODIFIED NO TOPICS MESSAGE v1.0</strong></span></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=253913" class="bbc_link" target="_blank"><strong>By Dougiefresh</strong></a> -&gt; <a href="http://custom.simplemachines.org/mods/index.php?mod=4016" class="bbc_link" target="_blank">Link to Mod</a><br /></div><hr /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Introduction</span></span></strong></span><br />This mod modifies the MessageIndex template so that it is clearer (at least to me) that there are no topics or posts to view in the board.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Admin Settings</span></span></strong></span><br />There are no admin settings to this mod.&nbsp; To disable, you must uninstall this mod.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Compatibility Notes</span></span></strong></span><br />This mod was tested on SMF 2.0.9, but should work on SMF 2.0 and up.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Changelog</span></span></strong></span><br /><div class="quoteheader"><div class="topslice_quote">Quote</div></div><blockquote class="bbc_standard_quote">v1.0 - December 23th, 2014<br />o Initial Release of the mod<br /></blockquote><div class="quotefooter"><div class="botslice_quote"></div></div><br /><hr /><a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank"><img src="http://i.creativecommons.org/l/by/3.0/80x15.png" alt="" class="bbc_img" /></a><br />This work is licensed under a <a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank">Creative Commons Attribution 3.0 Unported License</a><br />'',\n			file: ''Modified_No_Topic_Msg_v1.0.zip''\n		},\n		4015: {\n			name: ''List Of Users In Topic or Board 1.0'',\n			versions: [''80''],\n			desc: ''<hr /><div align="center"><span style="color: red;" class="bbc_color"><span style="font-size: 16pt;" class="bbc_size"><strong>LIST OF USERS IN TOPIC OR BOARD v1.0</strong></span></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=253913" class="bbc_link" target="_blank"><strong>By Dougiefresh</strong></a> -&gt; <a href="http://custom.simplemachines.org/mods/index.php?mod=4015" class="bbc_link" target="_blank">Link to Mod</a><br /></div><hr /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Introduction</span></span></strong></span><br />This mod modifies the Message Index and Post Display templates so that list of users in the board or topic is moved <strong>from</strong> above the topic list or start of the post <strong>to</strong> just above the Quick Reply box, and adds phpBB-like styling to the list.<br /><br />The &quot;Show who is viewing the board index and posts&quot; option in <strong>Theme Settings</strong> has been removed, in favor of permissions, which have been added to allow membergroups to be able to view the list for the Message Index and Post Display.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Admin Settings</span></span></strong></span><br />Permissions to enable the mod for each membergroup is available in the Admin Center.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Compatibility Notes</span></span></strong></span><br />This mod was tested on SMF 2.0.9, but should work on SMF 2.0 and up.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Translations</span></span></strong></span><br />o Dutch translation by Fixit over at the <a href="http://www.xptsp.com/board/" class="bbc_link" target="_blank">XPtsp.com forum</a>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Changelog</span></span></strong></span><br /><div class="quoteheader"><div class="topslice_quote">Quote</div></div><blockquote class="bbc_standard_quote"><strong><span class="bbc_u">v1.0 - December 20th, 2014</span></strong><br />o Initial Release of the mod<br /></blockquote><div class="quotefooter"><div class="botslice_quote"></div></div><br /><hr /><a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank"><img src="http://i.creativecommons.org/l/by/3.0/80x15.png" alt="" class="bbc_img" /></a><br />This work is licensed under a <a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank">Creative Commons Attribution 3.0 Unported License</a><br />'',\n			file: ''List_Of_Users_In_Topic_or_Board_v1.0.zip''\n		},\n		4014: {\n			name: ''AMSP - Add Member&#039;s Signature Permission (Partially Hook!) 100'',\n			versions: [''80''],\n			desc: ''<span style="font-size: 14pt;" class="bbc_size"><strong><span style="color: maroon;" class="bbc_color">AMSP - Add Member&#039;s Signature Permission<br /></span></strong></span><br />- For SMF 2.0.x<br />- Partially using hook, modifications on three files.<br /><br />1. Please do your own backup though every installation is backed up automatically.<br />2. By default, forum members are usually allowed to have their own signatures (to advertise).<br />3. These signatures are shown at display (post), personal messsage, profile summary etc (are there any more?).<br />4. Some signatures are anoying and forum admins / owners dislike this (or they want to charge some payment for them <img src="http://media.simplemachinesweb.com/smf/smileys/default/tongue.gif" alt="&#58;P" title="Tongue" class="smiley" />). <br />5. Using this mod added permission, forum admins / owners can decide which groups are allowed to have their signatures.<br />6. This mod will automatically stop displaying all members&#039; signatures (other than admin groups), until permission is given.<br />7. You can test it in all lower SMF 2.0.x version too as IMO it should work just fine. <img src="http://media.simplemachinesweb.com/smf/smileys/default/wink.gif" alt=";&#41;" title="Wink" class="smiley" /><br /><br /><br />Thank you for using/testing it.<br /><br /><br />Yours friendly,<br />Abu Fahim Ismail.<br /><br /><span style="color: red;" class="bbc_color">BSD License.</span> Feel free to modify accordingly but keep original and current authors&#039; link(s) if it is in there somewhere. <img src="http://media.simplemachinesweb.com/smf/smileys/default/wink.gif" alt=";&#41;" title="Wink" class="smiley" /><br /><br />Github link: <a href="https://github.com/ahrasis/AMSP-Add-Members-Signature-Permission-Mod" class="bbc_link" target="_blank">ahrasis/AMSP-Add-Members-Signature-Permission-Mod</a><br /><br /><img src="http://validator.w3.org/images/valid_icons/valid-xhtml10" alt="" class="bbc_img" />&nbsp; <img src="http://jigsaw.w3.org/css-validator/images/vcss" alt="" class="bbc_img" /><br /><br /><strong><span class="bbc_u">#Change Logs</span></strong><br /><br /><span class="bbc_u">@Version 1.0.0</span><br />- Initial release.'',\n			file: ''AMSP.partiallyhooks.v.100.zip''\n		},\n		3058: {\n			name: ''Guest Closed Topic 1.0.2'',\n			versions: [''61'', ''63'', ''65''],\n			desc: ''<div align="center"><span style="font-size: 10pt;" class="bbc_size"><span style="color: green;" class="bbc_color"><strong>Guest Closed Topic</strong></span></span></div><br />This modification prohibits unregistered users from browsing the topics you have selected.<br /><br /><span style="color: blue;" class="bbc_color"><strong>Settings:</strong></span><br /><ul class="bbc_list"><li>Enter selected topic IDs into the admin panel and save.</li><li>Choose the way content is displayed - &quot;Main window&quot;, &quot;Pop-up&quot;</li></ul><br /><span style="color: blue;" class="bbc_color"><strong>Languages Supported:</strong></span><br /><ul class="bbc_list"><li>English</li><li>Russian</li><li>Romanian</li></ul><br /><strong>v.1.0.2</strong><br />v.1.0.2 Updated for support SMF 2.0.1.<br /><br /><strong>v.1.0.1</strong><br />Add:<br />+ Romanian<br /><br /><a href="http://www.simplemachines.ru/index.php?board=47.0" class="bbc_link" target="_blank"><span style="color: green;" class="bbc_color">Discussion|support mod</span></a>'',\n			file: ''Closed_Topic_v1.0.2.tar.gz''\n		}	};\n	var smf_latestModifications = [4016, 4015, 4014];\n	\n	window.smfLatestPackages = ''\\\n		<div id="smfLatestPackagesWindow"style="overflow: auto;">\\\n			<h3 style="margin: 0; padding: 4px;">New Packages:</h3>\\\n			<img src="http://www.simplemachines.org/smf/images/package.png" width="102" height="98" style="float: right; margin: 4px;" alt="(package)" />\\\n			<ul style="list-style: none; margin-top: 3px; padding: 0 4px;">'';\n	\n	for (var i = 0; i < smf_latestModifications.length; i++)\n	{\n		var id_mod = smf_latestModifications[i];\n	\n		window.smfLatestPackages += ''<li><a href="javascript:smf_packagesMoreInfo('' + id_mod + '');void(0);">'' + smf_modificationInfo[id_mod].name + ''</a></li>'';\n	}\n	\n	window.smfLatestPackages += ''\\\n			</ul>'';\n	\n	if (typeof(window.smfVersion) != "undefined" && (window.smfVersion < "SMF 1.0.6" || (window.smfVersion == "SMF 1.1 RC2" && !in_array(''smf:smf-1.0.7'', window.smfInstalledPackages))))\n		window.smfLatestPackages += ''\\\n			<h3 class="error" style="margin: 0; padding: 4px;">Updates for SMF:</h3>\\\n			<div style="padding: 0 4px;">\\\n				<a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Security update (X-Forwarded-For header vulnerability)</a>\\\n			</div>'';\n	else\n		window.smfLatestPackages += ''\\\n			<h3 style="margin: 0; padding: 4px;">Package of the Moment:</h3>\\\n			<div style="padding: 0 4px;">\\\n				<a href="javascript:smf_packagesMoreInfo(3058);void(0);">Guest Closed Topic 1.0.2</a>\\\n			</div>'';\n	\n	window.smfLatestPackages += ''\\\n		</div>'';\n}\n\nfunction findTop(el)\n{\n	if (typeof(el.tagName) == "undefined")\n		return 0;\n\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\n\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\n		return skipMe ? 0 : el.offsetTop;\n	else\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\n}\n\nfunction in_array(item, array)\n{\n	for (var i in array)\n	{\n		if (array[i] == item)\n			return true;\n	}\n\n	return false;\n}\n\nfunction smf_packagesMoreInfo(id)\n{\n	window.smfLatestPackages_temp = document.getElementById("smfLatestPackagesWindow").innerHTML;\n\n	setInnerHTML(document.getElementById("smfLatestPackagesWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_modificationInfo[id].name + ''</h3>\\\n		<h4 style="padding: 4px; margin: 0;"><a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/'' + id + ''/'' + smf_modificationInfo[id].file + '';'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Install Now!</a></h4>\\\n		<div style="margin: 4px;">'' + smf_modificationInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\n		<div class="titlebg" style="padding: 4px; margin: 0;"><a href="javascript:smf_packagesBack();void(0);">(go back)</a></div>'');\n}\n\nfunction smf_packagesBack()\n{\n	setInnerHTML(document.getElementById("smfLatestPackagesWindow"), window.smfLatestPackages_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestPackagesWindow")) - 10);\n}', 'text/javascript');
INSERT INTO `forum_admin_info_files` (`id_file`, `filename`, `path`, `parameters`, `data`, `filetype`) VALUES
(5, 'latest-smileys.js', '/smf/', 'language=%1$s&version=%3$s', 'var actionurl = ''?action=admin;area=smileys;sa=install;set_gz='';\nif (typeof(window.smfForum_sessionvar) == "undefined")\n	window.smfForum_sessionvar = ''sesc'';\n\nvar smf_smileysInfo = {\n\n	3840: {\n		name: ''Android smileys 1.0'',\n		versions: [''78''],\n		desc: ''This is just a simple modification that adds new smileys set to your forum.<br />The icons were made by Google for Android system and are under open-source license.'',\n		file: ''Android_smileys_1.0.zip''\n	},\n	3628: {\n		name: ''BBPh Smileys 1.0'',\n		versions: [''72'', ''73''],\n		desc: ''Made to easily replace default ones.<br /><br /><img src="http://dl.dropbox.com/u/1684364/arc/bbph.gif" alt="" class="bbc_img" /><br /><br />These are just my favorites since the first forum I ever lived on was based on phpBB. Some are animated. package-info.xml included.<br /><br />Original smileys belong to phpBB. Some minor mods by me.'',\n		file: ''bbph.zip''\n	},\n	3290: {\n		name: ''Blue Smiley Animation 2.0'',\n		versions: [''67'', ''72'', ''68'', ''73''],\n		desc: ''<div align="center"><span style="font-size: 1.45em;" class="bbc_size"><span style="color: green;" class="bbc_color"><strong>Blue Smiley Animation</strong></span></span></div><div align="center"><a href="http://www.simplemachines.org/community/index.php?topic=464629.0" class="bbc_link" target="_blank">English Support</a> | <a href="http://smf-portal.hu" class="bbc_link" target="_blank">Hungarian Support</a> | <a href="http://custom.simplemachines.org/mods/index.php?action=profile;u=221448" class="bbc_link" target="_blank">My Mods</a></div><hr /><br /><strong>Autor:</strong><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=221448" class="bbc_link" target="_blank">WasdMan</a> and Cserrobi<br /><br /><strong>Description (Hungarian):</strong> <br />Kék mosolygó arcok<br /><br /><strong>Description (English):</strong><br />Blue Smiley package<br /><br /><img src="http://smf-portal.hu/Download/Egyeb/keksmiley.png" alt="" width="600" height="237" class="bbc_img resized" /><br /><br /><strong>Compatibility: </strong><br /><ul class="bbc_list"><li>1.0 - 1.99.99</li><li>2.0 - 2.99.99</li></ul>'',\n		file: ''BlueSmileyAnimation_2.1_UNI.zip''\n	},\n	388: {\n		name: ''Smiley Alignment fix 1.0'',\n		versions: [''16'', ''17''],\n		desc: ''This small mod will fix the vertical alignment of your posted emoticons in the forum.<br />I know alot of people need this, just like I do.<br /><br />This has been tested on 1.1 RC2 but i imagine it should install nicely on all other SMF versions!<br /><br />For more great stuff please visit: <a href="http://tpvgames.co.uk" class="bbc_link" target="_blank">http://tpvgames.co.uk</a>'',\n		file: ''fixsmileys.zip''\n	},};\nvar smf_latestSmileys = [3840, 3628, 3290];\n\nfunction smf_packagesMoreInfo(id)\n{\n	window.smfLatestSmileys_temp = document.getElementById("smfLatestSmileysWindow").innerHTML;\n\n	setInnerHTML(document.getElementById("smfLatestSmileysWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_smileysInfo[id].name + ''</h3>\\\n		<h4 style="padding: 4px; margin: 0;"><a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/'' + id + ''/'' + smf_smileysInfo[id].file + '';'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Install Now!</a></h4>\\\n		<div style="margin: 4px;">'' + smf_smileysInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\n		<div class="titlebg" style="padding: 4px; margin: 0;"><a href="javascript:smf_packagesBack();void(0);">(go back)</a></div>'');\n}\n\nfunction smf_packagesBack()\n{\n	setInnerHTML(document.getElementById("smfLatestSmileysWindow"), window.smfLatestSmileys_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestSmileysWindow")) - 10);\n}\n\nwindow.smfLatestSmileys = ''\\\n	<div id="smfLatestSmileysWindow" style="overflow: auto;">\\\n		<img src="http://www.simplemachines.org/smf/images/smileys.png" width="102" height="98" style="float: right; margin: 4px;" alt="(package)" />\\\n		<h3 style="margin: 0; padding: 4px;">Smiley of the Moment:</h3>\\\n		<div style="padding: 0 4px;">\\\n			<a href="javascript:smf_packagesMoreInfo(388);void(0);">Smiley Alignment fix 1.0</a>\\\n		</div>'';\n\nwindow.smfLatestSmileys += ''\\\n		<h3 style="margin: 0; padding: 4px;">New Smileys:</h3>\\\n		<ul style="list-style: none; margin-top: 3px; padding: 0 4px;">'';\n\nfor (var i = 0; i < smf_latestSmileys.length; i++)\n{\n	var id_mod = smf_latestSmileys[i];\n\n	window.smfLatestSmileys += ''<li><a href="javascript:smf_packagesMoreInfo('' + id_mod + '');void(0);">'' + smf_smileysInfo[id_mod].name + ''</a></li>'';\n}\n\nwindow.smfLatestSmileys += ''\\\n		</ul>'';\n\nwindow.smfLatestSmileys += ''\\\n	</div>'';\n\nfunction findTop(el)\n{\n	if (typeof(el.tagName) == "undefined")\n		return 0;\n\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\n\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\n		return skipMe ? 0 : el.offsetTop;\n	else\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\n}\n\nfunction in_array(item, array)\n{\n	for (var i in array)\n	{\n		if (array[i] == item)\n			return true;\n	}\n\n	return false;\n}', 'text/javascript'),
(6, 'latest-support.js', '/smf/', 'language=%1$s&version=%3$s', 'window.smfLatestSupport = ''<div style="font-size: 0.85em;"><div style="font-weight: bold;">SMF 2.0.9</div>This version fixes several minor bugs and security issues.  Please <a href="http://www.simplemachines.org/download.php">try it</a> before requesting support.</div>'';\n\nif (document.getElementById(''credits''))\n	setInnerHTML(document.getElementById(''credits''), getInnerHTML(document.getElementById(''credits'')).replace(/thank you!/, ''<span onclick="alert(\\''Kupo!\\'');">thank you!</span>''));\n', 'text/javascript'),
(7, 'latest-themes.js', '/smf/', 'language=%1$s&version=%3$s', '\r\nvar smf_themeInfo = {\r\n	2520: {\r\n		name: ''Theme Christmas Carol'',\r\n		desc: ''<span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Theme Christmas Carol</span></span><br /><hr /><strong> By : Ricky.&nbsp; |&nbsp; <a href="http://ifandbut.com/talk/index.php?topic=168.0" class="bbc_link" target="_blank">Theme Support</a> | <a href="http://custom.simplemachines.org/themes/index.php?action=profile;u=34192" class="bbc_link" target="_blank">My More Themes</a> <br />For SMF 2.0 , SMF 2.0.1<br /></strong><br /><br />A colorful theme specially for the celebration of Christmas. A fixed width theme with menu on left side of the forum giving your forum a unique layout along with combination of bright colors. Suitable for any kind of forum celebrating X-mas. This theme gives you beautiful looks yet with professional touch. Theme also allows you mention your custom copyright in footer. <br /><br /><strong>You can change theme features at : <br />SMF Admin --&gt; Configuration --&gt; Current Theme </strong><br />(Assuming that <strong>Theme Christmas Carol</strong> has been selected as overall smf theme on your forum). <br /><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Features</span></span><br /><hr /><ul class="bbc_list"><li>Vertical menu in Sidebar</li><li>A fixed width theme</li><li>Bright colored</li><li>Allow you add your own logo from them Admin Menu</li><li>Utilizing CSS3 supported by all modern browser</li><li>Allows you to add custom copyright in footer</li></ul><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">In the Last</span></span><br /><hr />If you liked my theme or use my theme then please have some moment here and give <strong>your valuable comments</strong>, those comments serves as encouragement for my future themes and work. <br /><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Some Screenshots</span></span><br /><hr /><div align="center"><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191441;image" alt="" class="bbc_img" /><br /><br /><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191445;image" alt="" class="bbc_img" /><br /><br /><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191443;image" alt="" class="bbc_img" /><br /><br /></div>'',\r\n		file: ''christmas-carol.zip'',\r\n		author: ''Ricky.''\r\n	},\r\n	2824: {\r\n		name: ''BeCool'',\r\n		desc: ''<a href="http://demo.studiocrimes.com/index.php?theme=25" class="bbc_link" target="_blank">Live demo</a> available!<br /><br />Newest free theme from <a href="http://studiocrimes.com" class="bbc_link" target="_blank">studioCRIMES.com</a>'',\r\n		file: ''BeCool_2.0.x.zip'',\r\n		author: ''CrimeS''\r\n	},\r\n	2823: {\r\n		name: ''Raki!!'',\r\n		desc: ''<strong>Raki </strong>is a simple theme with blues and greys to create a curve based coresque feel. The theme uses CSS3 so may not work on all browsers.<br /><br /><strong>Terms of use:</strong><br /><br />This theme is free for personal and commercial use. You are allowed to use it in your projects, change it and adapt for your purposes. You are not allowed to remove the authors copyright.<br /><br /><strong>Disclaimer</strong>: Support is not guaranteed on this theme!'',\r\n		file: ''raki.zip'',\r\n		author: ''Runic''\r\n	},\r\n	2822: {\r\n		name: ''Two Minutes'',\r\n		desc: ''<strong>Two Minutes</strong> is a professional theme with a grey yet colourful feel. Perfect for those that want to relax.<br /><br /><strong>Terms of use</strong>:<br /><br />This theme is free for personal and commercial use. You are allowed to use it in your projects, change it and adapt for your purposes. You are not allowed to remove the authors copyright.<br /><br /><strong>Disclaimer</strong>: Support is not guaranteed on this theme!'',\r\n		file: ''twominutes.zip'',\r\n		author: ''Runic''\r\n	},\r\n	1202: {\r\n		name: ''Zionna Theme'',\r\n		desc: ''Zionna theme<br />-----------------------------------------------------------------------------------------------------------<br />Professional SMF Themes<br /><a href="http://mtlserver.com/smf/index.php?theme=60;language=english" class="bbc_link" target="_blank">English Demo</a><br />user:demo pass:101010<br />Support Theme : <a href="http://www.smfgrup.com/" class="bbc_link" target="_blank">http://www.smfgrup.com/</a><br /><br />------------------------------------------------------------------<br />Profesyonel SMF Teması<br /><a href="http://mtlserver.com/smf/index.php?theme=60;language=turkish" class="bbc_link" target="_blank">Türkçe Demo</a><br />kullanıcı:demo şifre:101010<br />tema destek :&nbsp; <a href="http://www.smfgrup.com/" class="bbc_link" target="_blank">http://www.smfgrup.com/</a><br />-------------------------------------------<br /><br />Zionna Theme By FriedeKind And Cadosoas&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <br /><br /><br /><br /><span style="color: green;" class="bbc_color">special thanks to&nbsp;&nbsp; MTLServer&nbsp; for hosting</span>'',\r\n		file: ''zionna.zip'',\r\n		author: ''•● FяiєdєKiηd™ ●•''\r\n	}\r\n};\r\nvar smf_featured = 2520;\r\nvar smf_random = 1202;\r\nvar smf_latestThemes = [2824, 2823, 2822];\r\nfunction smf_themesMoreInfo(id)\r\n{\r\n	window.smfLatestThemes_temp = document.getElementById("smfLatestThemesWindow").innerHTML;\n\n	// !!! Why not just always auto?\n	document.getElementById("smfLatestThemesWindow").style.overflow = "auto";\n	setInnerHTML(document.getElementById("smfLatestThemesWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_themeInfo[id].name + ''</h3>\\\r\n		<h4 style="margin: 0;padding: 4px;"><a href="http://custom.simplemachines.org/themes/index.php?lemma='' + id + ''">View Theme Now!</a></h4>\\\r\n		<div style="overflow: auto;">\\\r\n			<img src="http://custom.simplemachines.org/themes/index.php?action=download;lemma=''+id+'';image=thumb" alt="" style="float: right; margin: 10px;" />\\\r\n			<div style="padding:8px;">'' + smf_themeInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\r\n		</div>\\\r\n		<div style="padding: 4px;" class="smalltext"><a href="javascript:smf_themesBack();void(0);">(go back)</a></div>'');\n}\r\n\r\nfunction smf_themesBack()\r\n{\r\n	document.getElementById("smfLatestThemesWindow").style.overflow = "";\n	setInnerHTML(document.getElementById("smfLatestThemesWindow"), window.smfLatestThemes_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestThemesWindow")) - 10);\r\n}\r\n\r\nwindow.smfLatestThemes = ''\\\r\n	<div id="smfLatestThemesWindow">\\\r\n		<div>\\\r\n			<img src="http://www.simplemachines.org/smf/images/themes.png" width="102" height="98" style="float: right; margin: 0 0 10px 10px;" alt="(package)" />\\\r\n			<ul style="list-style: none; padding: 0; margin: 0 0 0 5px;">'';\r\nfor(var i=0; i < smf_latestThemes.length; i++)\r\n{\r\n	var id_theme = smf_latestThemes[i];\r\n	window.smfLatestThemes += ''\\\r\n				<li style="list-style: none;"><a href="javascript:smf_themesMoreInfo('' + id_theme + '');void(0);">'' + smf_themeInfo[id_theme].name + '' by '' + smf_themeInfo[id_theme].author + ''</a></li>'';\r\n}\r\n\r\nwindow.smfLatestThemes += ''\\\r\n			</ul>'';\r\nif ( smf_featured !=0 || smf_random != 0 )\r\n{\r\n\r\n	if ( smf_featured != 0 )\r\n		window.smfLatestThemes += ''\\\r\n				<h4 style="padding: 4px 4px 0 4px; margin: 0;">Featured Theme</h4>\\\r\n				<p style="padding: 0 4px; margin: 0;">\\\r\n					<a href="javascript:smf_themesMoreInfo(''+smf_featured+'');void(0);">''+smf_themeInfo[smf_featured].name + '' by '' + smf_themeInfo[smf_featured].author+''</a>\\\r\n				</p>'';\r\n	if ( smf_random != 0 )\r\n		window.smfLatestThemes += ''\\\r\n				<h4 style="padding: 4px 4px 0 4px;margin: 0;">Theme of the Moment</h4>\\\r\n				<p style="padding: 0 4px; margin: 0;">\\\r\n					<a href="javascript:smf_themesMoreInfo(''+smf_random+'');void(0);">''+smf_themeInfo[smf_random].name + '' by '' + smf_themeInfo[smf_random].author+''</a>\\\r\n				</p>'';\r\n}\r\nwindow.smfLatestThemes += ''\\\r\n		</div>\\\r\n	</div>'';\r\n\r\nfunction findTop(el)\r\n{\r\n	if (typeof(el.tagName) == "undefined")\r\n		return 0;\r\n\r\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\r\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\r\n\r\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\r\n		return skipMe ? 0 : el.offsetTop;\r\n	else\r\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\r\n}\r\n\r\nfunction in_array(item, array)\r\n{\r\n	for (var i in array)\r\n	{\r\n		if (array[i] == item)\r\n			return true;\r\n	}\r\n\r\n	return false;\r\n}', 'text/javascript');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_approval_queue`
--

CREATE TABLE IF NOT EXISTS `forum_approval_queue` (
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_attach` int(10) unsigned NOT NULL DEFAULT '0',
  `id_event` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_attachments`
--

CREATE TABLE IF NOT EXISTS `forum_attachments` (
`id_attach` int(10) unsigned NOT NULL,
  `id_thumb` int(10) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_folder` tinyint(3) NOT NULL DEFAULT '1',
  `attachment_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `file_hash` varchar(40) NOT NULL DEFAULT '',
  `fileext` varchar(8) NOT NULL DEFAULT '',
  `size` int(10) unsigned NOT NULL DEFAULT '0',
  `downloads` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `width` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `height` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `mime_type` varchar(20) NOT NULL DEFAULT '',
  `approved` tinyint(3) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_ban_groups`
--

CREATE TABLE IF NOT EXISTS `forum_ban_groups` (
`id_ban_group` mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL DEFAULT '',
  `ban_time` int(10) unsigned NOT NULL DEFAULT '0',
  `expire_time` int(10) unsigned DEFAULT NULL,
  `cannot_access` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cannot_register` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cannot_post` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cannot_login` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `reason` varchar(255) NOT NULL DEFAULT '',
  `notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_ban_items`
--

CREATE TABLE IF NOT EXISTS `forum_ban_items` (
`id_ban` mediumint(8) unsigned NOT NULL,
  `id_ban_group` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ip_low1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_high1` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_low2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_high2` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_low3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_high3` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_low4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ip_high4` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `hostname` varchar(255) NOT NULL DEFAULT '',
  `email_address` varchar(255) NOT NULL DEFAULT '',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `hits` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_boards`
--

CREATE TABLE IF NOT EXISTS `forum_boards` (
`id_board` smallint(5) unsigned NOT NULL,
  `id_cat` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `child_level` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `id_parent` smallint(5) unsigned NOT NULL DEFAULT '0',
  `board_order` smallint(5) NOT NULL DEFAULT '0',
  `id_last_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_msg_updated` int(10) unsigned NOT NULL DEFAULT '0',
  `member_groups` varchar(255) NOT NULL DEFAULT '-1,0',
  `id_profile` smallint(5) unsigned NOT NULL DEFAULT '1',
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `num_topics` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num_posts` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `count_posts` tinyint(4) NOT NULL DEFAULT '0',
  `id_theme` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `override_theme` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `unapproved_posts` smallint(5) NOT NULL DEFAULT '0',
  `unapproved_topics` smallint(5) NOT NULL DEFAULT '0',
  `redirect` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_board_permissions`
--

CREATE TABLE IF NOT EXISTS `forum_board_permissions` (
  `id_group` smallint(5) NOT NULL DEFAULT '0',
  `id_profile` smallint(5) unsigned NOT NULL DEFAULT '0',
  `permission` varchar(30) NOT NULL DEFAULT '',
  `add_deny` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_board_permissions`
--

INSERT INTO `forum_board_permissions` (`id_group`, `id_profile`, `permission`, `add_deny`) VALUES
(-1, 1, 'poll_view', 1),
(0, 1, 'remove_own', 1),
(0, 1, 'lock_own', 1),
(0, 1, 'mark_any_notify', 1),
(0, 1, 'mark_notify', 1),
(0, 1, 'modify_own', 1),
(0, 1, 'poll_add_own', 1),
(0, 1, 'poll_edit_own', 1),
(0, 1, 'poll_lock_own', 1),
(0, 1, 'poll_post', 1),
(0, 1, 'poll_view', 1),
(0, 1, 'poll_vote', 1),
(0, 1, 'post_attachment', 1),
(0, 1, 'post_new', 1),
(0, 1, 'post_reply_any', 1),
(0, 1, 'post_reply_own', 1),
(0, 1, 'post_unapproved_topics', 1),
(0, 1, 'post_unapproved_replies_any', 1),
(0, 1, 'post_unapproved_replies_own', 1),
(0, 1, 'post_unapproved_attachments', 1),
(0, 1, 'delete_own', 1),
(0, 1, 'report_any', 1),
(0, 1, 'send_topic', 1),
(0, 1, 'view_attachments', 1),
(2, 1, 'moderate_board', 1),
(2, 1, 'post_new', 1),
(2, 1, 'post_reply_own', 1),
(2, 1, 'post_reply_any', 1),
(2, 1, 'post_unapproved_topics', 1),
(2, 1, 'post_unapproved_replies_any', 1),
(2, 1, 'post_unapproved_replies_own', 1),
(2, 1, 'post_unapproved_attachments', 1),
(2, 1, 'poll_post', 1),
(2, 1, 'poll_add_any', 1),
(2, 1, 'poll_remove_any', 1),
(2, 1, 'poll_view', 1),
(2, 1, 'poll_vote', 1),
(2, 1, 'poll_lock_any', 1),
(2, 1, 'poll_edit_any', 1),
(2, 1, 'report_any', 1),
(2, 1, 'lock_own', 1),
(2, 1, 'send_topic', 1),
(2, 1, 'mark_any_notify', 1),
(2, 1, 'mark_notify', 1),
(2, 1, 'delete_own', 1),
(2, 1, 'modify_own', 1),
(2, 1, 'make_sticky', 1),
(2, 1, 'lock_any', 1),
(2, 1, 'remove_any', 1),
(2, 1, 'move_any', 1),
(2, 1, 'merge_any', 1),
(2, 1, 'split_any', 1),
(2, 1, 'delete_any', 1),
(2, 1, 'modify_any', 1),
(2, 1, 'approve_posts', 1),
(2, 1, 'post_attachment', 1),
(2, 1, 'view_attachments', 1),
(3, 1, 'moderate_board', 1),
(3, 1, 'post_new', 1),
(3, 1, 'post_reply_own', 1),
(3, 1, 'post_reply_any', 1),
(3, 1, 'post_unapproved_topics', 1),
(3, 1, 'post_unapproved_replies_any', 1),
(3, 1, 'post_unapproved_replies_own', 1),
(3, 1, 'post_unapproved_attachments', 1),
(3, 1, 'poll_post', 1),
(3, 1, 'poll_add_any', 1),
(3, 1, 'poll_remove_any', 1),
(3, 1, 'poll_view', 1),
(3, 1, 'poll_vote', 1),
(3, 1, 'poll_lock_any', 1),
(3, 1, 'poll_edit_any', 1),
(3, 1, 'report_any', 1),
(3, 1, 'lock_own', 1),
(3, 1, 'send_topic', 1),
(3, 1, 'mark_any_notify', 1),
(3, 1, 'mark_notify', 1),
(3, 1, 'delete_own', 1),
(3, 1, 'modify_own', 1),
(3, 1, 'make_sticky', 1),
(3, 1, 'lock_any', 1),
(3, 1, 'remove_any', 1),
(3, 1, 'move_any', 1),
(3, 1, 'merge_any', 1),
(3, 1, 'split_any', 1),
(3, 1, 'delete_any', 1),
(3, 1, 'modify_any', 1),
(3, 1, 'approve_posts', 1),
(3, 1, 'post_attachment', 1),
(3, 1, 'view_attachments', 1),
(-1, 2, 'poll_view', 1),
(0, 2, 'remove_own', 1),
(0, 2, 'lock_own', 1),
(0, 2, 'mark_any_notify', 1),
(0, 2, 'mark_notify', 1),
(0, 2, 'modify_own', 1),
(0, 2, 'poll_view', 1),
(0, 2, 'poll_vote', 1),
(0, 2, 'post_attachment', 1),
(0, 2, 'post_new', 1),
(0, 2, 'post_reply_any', 1),
(0, 2, 'post_reply_own', 1),
(0, 2, 'post_unapproved_topics', 1),
(0, 2, 'post_unapproved_replies_any', 1),
(0, 2, 'post_unapproved_replies_own', 1),
(0, 2, 'post_unapproved_attachments', 1),
(0, 2, 'delete_own', 1),
(0, 2, 'report_any', 1),
(0, 2, 'send_topic', 1),
(0, 2, 'view_attachments', 1),
(2, 2, 'moderate_board', 1),
(2, 2, 'post_new', 1),
(2, 2, 'post_reply_own', 1),
(2, 2, 'post_reply_any', 1),
(2, 2, 'post_unapproved_topics', 1),
(2, 2, 'post_unapproved_replies_any', 1),
(2, 2, 'post_unapproved_replies_own', 1),
(2, 2, 'post_unapproved_attachments', 1),
(2, 2, 'poll_post', 1),
(2, 2, 'poll_add_any', 1),
(2, 2, 'poll_remove_any', 1),
(2, 2, 'poll_view', 1),
(2, 2, 'poll_vote', 1),
(2, 2, 'poll_lock_any', 1),
(2, 2, 'poll_edit_any', 1),
(2, 2, 'report_any', 1),
(2, 2, 'lock_own', 1),
(2, 2, 'send_topic', 1),
(2, 2, 'mark_any_notify', 1),
(2, 2, 'mark_notify', 1),
(2, 2, 'delete_own', 1),
(2, 2, 'modify_own', 1),
(2, 2, 'make_sticky', 1),
(2, 2, 'lock_any', 1),
(2, 2, 'remove_any', 1),
(2, 2, 'move_any', 1),
(2, 2, 'merge_any', 1),
(2, 2, 'split_any', 1),
(2, 2, 'delete_any', 1),
(2, 2, 'modify_any', 1),
(2, 2, 'approve_posts', 1),
(2, 2, 'post_attachment', 1),
(2, 2, 'view_attachments', 1),
(3, 2, 'moderate_board', 1),
(3, 2, 'post_new', 1),
(3, 2, 'post_reply_own', 1),
(3, 2, 'post_reply_any', 1),
(3, 2, 'post_unapproved_topics', 1),
(3, 2, 'post_unapproved_replies_any', 1),
(3, 2, 'post_unapproved_replies_own', 1),
(3, 2, 'post_unapproved_attachments', 1),
(3, 2, 'poll_post', 1),
(3, 2, 'poll_add_any', 1),
(3, 2, 'poll_remove_any', 1),
(3, 2, 'poll_view', 1),
(3, 2, 'poll_vote', 1),
(3, 2, 'poll_lock_any', 1),
(3, 2, 'poll_edit_any', 1),
(3, 2, 'report_any', 1),
(3, 2, 'lock_own', 1),
(3, 2, 'send_topic', 1),
(3, 2, 'mark_any_notify', 1),
(3, 2, 'mark_notify', 1),
(3, 2, 'delete_own', 1),
(3, 2, 'modify_own', 1),
(3, 2, 'make_sticky', 1),
(3, 2, 'lock_any', 1),
(3, 2, 'remove_any', 1),
(3, 2, 'move_any', 1),
(3, 2, 'merge_any', 1),
(3, 2, 'split_any', 1),
(3, 2, 'delete_any', 1),
(3, 2, 'modify_any', 1),
(3, 2, 'approve_posts', 1),
(3, 2, 'post_attachment', 1),
(3, 2, 'view_attachments', 1),
(-1, 3, 'poll_view', 1),
(0, 3, 'remove_own', 1),
(0, 3, 'lock_own', 1),
(0, 3, 'mark_any_notify', 1),
(0, 3, 'mark_notify', 1),
(0, 3, 'modify_own', 1),
(0, 3, 'poll_view', 1),
(0, 3, 'poll_vote', 1),
(0, 3, 'post_attachment', 1),
(0, 3, 'post_reply_any', 1),
(0, 3, 'post_reply_own', 1),
(0, 3, 'post_unapproved_replies_any', 1),
(0, 3, 'post_unapproved_replies_own', 1),
(0, 3, 'post_unapproved_attachments', 1),
(0, 3, 'delete_own', 1),
(0, 3, 'report_any', 1),
(0, 3, 'send_topic', 1),
(0, 3, 'view_attachments', 1),
(2, 3, 'moderate_board', 1),
(2, 3, 'post_new', 1),
(2, 3, 'post_reply_own', 1),
(2, 3, 'post_reply_any', 1),
(2, 3, 'post_unapproved_topics', 1),
(2, 3, 'post_unapproved_replies_any', 1),
(2, 3, 'post_unapproved_replies_own', 1),
(2, 3, 'post_unapproved_attachments', 1),
(2, 3, 'poll_post', 1),
(2, 3, 'poll_add_any', 1),
(2, 3, 'poll_remove_any', 1),
(2, 3, 'poll_view', 1),
(2, 3, 'poll_vote', 1),
(2, 3, 'poll_lock_any', 1),
(2, 3, 'poll_edit_any', 1),
(2, 3, 'report_any', 1),
(2, 3, 'lock_own', 1),
(2, 3, 'send_topic', 1),
(2, 3, 'mark_any_notify', 1),
(2, 3, 'mark_notify', 1),
(2, 3, 'delete_own', 1),
(2, 3, 'modify_own', 1),
(2, 3, 'make_sticky', 1),
(2, 3, 'lock_any', 1),
(2, 3, 'remove_any', 1),
(2, 3, 'move_any', 1),
(2, 3, 'merge_any', 1),
(2, 3, 'split_any', 1),
(2, 3, 'delete_any', 1),
(2, 3, 'modify_any', 1),
(2, 3, 'approve_posts', 1),
(2, 3, 'post_attachment', 1),
(2, 3, 'view_attachments', 1),
(3, 3, 'moderate_board', 1),
(3, 3, 'post_new', 1),
(3, 3, 'post_reply_own', 1),
(3, 3, 'post_reply_any', 1),
(3, 3, 'post_unapproved_topics', 1),
(3, 3, 'post_unapproved_replies_any', 1),
(3, 3, 'post_unapproved_replies_own', 1),
(3, 3, 'post_unapproved_attachments', 1),
(3, 3, 'poll_post', 1),
(3, 3, 'poll_add_any', 1),
(3, 3, 'poll_remove_any', 1),
(3, 3, 'poll_view', 1),
(3, 3, 'poll_vote', 1),
(3, 3, 'poll_lock_any', 1),
(3, 3, 'poll_edit_any', 1),
(3, 3, 'report_any', 1),
(3, 3, 'lock_own', 1),
(3, 3, 'send_topic', 1),
(3, 3, 'mark_any_notify', 1),
(3, 3, 'mark_notify', 1),
(3, 3, 'delete_own', 1),
(3, 3, 'modify_own', 1),
(3, 3, 'make_sticky', 1),
(3, 3, 'lock_any', 1),
(3, 3, 'remove_any', 1),
(3, 3, 'move_any', 1),
(3, 3, 'merge_any', 1),
(3, 3, 'split_any', 1),
(3, 3, 'delete_any', 1),
(3, 3, 'modify_any', 1),
(3, 3, 'approve_posts', 1),
(3, 3, 'post_attachment', 1),
(3, 3, 'view_attachments', 1),
(-1, 4, 'poll_view', 1),
(0, 4, 'mark_any_notify', 1),
(0, 4, 'mark_notify', 1),
(0, 4, 'poll_view', 1),
(0, 4, 'poll_vote', 1),
(0, 4, 'report_any', 1),
(0, 4, 'send_topic', 1),
(0, 4, 'view_attachments', 1),
(2, 4, 'moderate_board', 1),
(2, 4, 'post_new', 1),
(2, 4, 'post_reply_own', 1),
(2, 4, 'post_reply_any', 1),
(2, 4, 'post_unapproved_topics', 1),
(2, 4, 'post_unapproved_replies_any', 1),
(2, 4, 'post_unapproved_replies_own', 1),
(2, 4, 'post_unapproved_attachments', 1),
(2, 4, 'poll_post', 1),
(2, 4, 'poll_add_any', 1),
(2, 4, 'poll_remove_any', 1),
(2, 4, 'poll_view', 1),
(2, 4, 'poll_vote', 1),
(2, 4, 'poll_lock_any', 1),
(2, 4, 'poll_edit_any', 1),
(2, 4, 'report_any', 1),
(2, 4, 'lock_own', 1),
(2, 4, 'send_topic', 1),
(2, 4, 'mark_any_notify', 1),
(2, 4, 'mark_notify', 1),
(2, 4, 'delete_own', 1),
(2, 4, 'modify_own', 1),
(2, 4, 'make_sticky', 1),
(2, 4, 'lock_any', 1),
(2, 4, 'remove_any', 1),
(2, 4, 'move_any', 1),
(2, 4, 'merge_any', 1),
(2, 4, 'split_any', 1),
(2, 4, 'delete_any', 1),
(2, 4, 'modify_any', 1),
(2, 4, 'approve_posts', 1),
(2, 4, 'post_attachment', 1),
(2, 4, 'view_attachments', 1),
(3, 4, 'moderate_board', 1),
(3, 4, 'post_new', 1),
(3, 4, 'post_reply_own', 1),
(3, 4, 'post_reply_any', 1),
(3, 4, 'post_unapproved_topics', 1),
(3, 4, 'post_unapproved_replies_any', 1),
(3, 4, 'post_unapproved_replies_own', 1),
(3, 4, 'post_unapproved_attachments', 1),
(3, 4, 'poll_post', 1),
(3, 4, 'poll_add_any', 1),
(3, 4, 'poll_remove_any', 1),
(3, 4, 'poll_view', 1),
(3, 4, 'poll_vote', 1),
(3, 4, 'poll_lock_any', 1),
(3, 4, 'poll_edit_any', 1),
(3, 4, 'report_any', 1),
(3, 4, 'lock_own', 1),
(3, 4, 'send_topic', 1),
(3, 4, 'mark_any_notify', 1),
(3, 4, 'mark_notify', 1),
(3, 4, 'delete_own', 1),
(3, 4, 'modify_own', 1),
(3, 4, 'make_sticky', 1),
(3, 4, 'lock_any', 1),
(3, 4, 'remove_any', 1),
(3, 4, 'move_any', 1),
(3, 4, 'merge_any', 1),
(3, 4, 'split_any', 1),
(3, 4, 'delete_any', 1),
(3, 4, 'modify_any', 1),
(3, 4, 'approve_posts', 1),
(3, 4, 'post_attachment', 1),
(3, 4, 'view_attachments', 1),
(9, 1, 'poll_post', 1),
(9, 1, 'poll_view', 1),
(9, 1, 'modify_own', 1),
(9, 1, 'modify_any', 1),
(9, 1, 'report_any', 1),
(9, 1, 'approve_posts', 1),
(9, 1, 'send_topic', 1),
(9, 1, 'post_reply_any', 1),
(9, 1, 'poll_edit_own', 1),
(9, 1, 'poll_vote', 1),
(9, 1, 'delete_own', 1),
(9, 1, 'post_new', 1),
(9, 1, 'poll_edit_any', 1),
(9, 1, 'poll_lock_any', 1),
(9, 1, 'delete_any', 1),
(9, 1, 'post_reply_own', 1),
(9, 1, 'poll_add_own', 1),
(9, 1, 'poll_add_any', 1),
(9, 1, 'poll_remove_any', 1),
(9, 1, 'mark_any_notify', 1),
(9, 1, 'mark_notify', 1),
(9, 1, 'view_attachments', 1),
(9, 1, 'post_attachment', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_calendar`
--

CREATE TABLE IF NOT EXISTS `forum_calendar` (
`id_event` smallint(5) unsigned NOT NULL,
  `start_date` date NOT NULL DEFAULT '0001-01-01',
  `end_date` date NOT NULL DEFAULT '0001-01-01',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL DEFAULT '',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_calendar_holidays`
--

CREATE TABLE IF NOT EXISTS `forum_calendar_holidays` (
`id_holiday` smallint(5) unsigned NOT NULL,
  `event_date` date NOT NULL DEFAULT '0001-01-01',
  `title` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_calendar_holidays`
--

INSERT INTO `forum_calendar_holidays` (`id_holiday`, `event_date`, `title`) VALUES
(1, '0004-01-01', 'New Year''s'),
(2, '0004-12-25', 'Christmas'),
(3, '0004-02-14', 'Valentine''s Day'),
(4, '0004-03-17', 'St. Patrick''s Day'),
(5, '0004-04-01', 'April Fools'),
(6, '0004-04-22', 'Earth Day'),
(7, '0004-10-24', 'United Nations Day'),
(8, '0004-10-31', 'Halloween'),
(9, '2010-05-09', 'Mother''s Day'),
(10, '2011-05-08', 'Mother''s Day'),
(11, '2012-05-13', 'Mother''s Day'),
(12, '2013-05-12', 'Mother''s Day'),
(13, '2014-05-11', 'Mother''s Day'),
(14, '2015-05-10', 'Mother''s Day'),
(15, '2016-05-08', 'Mother''s Day'),
(16, '2017-05-14', 'Mother''s Day'),
(17, '2018-05-13', 'Mother''s Day'),
(18, '2019-05-12', 'Mother''s Day'),
(19, '2020-05-10', 'Mother''s Day'),
(20, '2008-06-15', 'Father''s Day'),
(21, '2009-06-21', 'Father''s Day'),
(22, '2010-06-20', 'Father''s Day'),
(23, '2011-06-19', 'Father''s Day'),
(24, '2012-06-17', 'Father''s Day'),
(25, '2013-06-16', 'Father''s Day'),
(26, '2014-06-15', 'Father''s Day'),
(27, '2015-06-21', 'Father''s Day'),
(28, '2016-06-19', 'Father''s Day'),
(29, '2017-06-18', 'Father''s Day'),
(30, '2018-06-17', 'Father''s Day'),
(31, '2019-06-16', 'Father''s Day'),
(32, '2020-06-21', 'Father''s Day'),
(33, '2010-06-21', 'Summer Solstice'),
(34, '2011-06-21', 'Summer Solstice'),
(35, '2012-06-20', 'Summer Solstice'),
(36, '2013-06-21', 'Summer Solstice'),
(37, '2014-06-21', 'Summer Solstice'),
(38, '2015-06-21', 'Summer Solstice'),
(39, '2016-06-20', 'Summer Solstice'),
(40, '2017-06-20', 'Summer Solstice'),
(41, '2018-06-21', 'Summer Solstice'),
(42, '2019-06-21', 'Summer Solstice'),
(43, '2020-06-20', 'Summer Solstice'),
(44, '2010-03-20', 'Vernal Equinox'),
(45, '2011-03-20', 'Vernal Equinox'),
(46, '2012-03-20', 'Vernal Equinox'),
(47, '2013-03-20', 'Vernal Equinox'),
(48, '2014-03-20', 'Vernal Equinox'),
(49, '2015-03-20', 'Vernal Equinox'),
(50, '2016-03-19', 'Vernal Equinox'),
(51, '2017-03-20', 'Vernal Equinox'),
(52, '2018-03-20', 'Vernal Equinox'),
(53, '2019-03-20', 'Vernal Equinox'),
(54, '2020-03-19', 'Vernal Equinox'),
(55, '2010-12-21', 'Winter Solstice'),
(56, '2011-12-22', 'Winter Solstice'),
(57, '2012-12-21', 'Winter Solstice'),
(58, '2013-12-21', 'Winter Solstice'),
(59, '2014-12-21', 'Winter Solstice'),
(60, '2015-12-21', 'Winter Solstice'),
(61, '2016-12-21', 'Winter Solstice'),
(62, '2017-12-21', 'Winter Solstice'),
(63, '2018-12-21', 'Winter Solstice'),
(64, '2019-12-21', 'Winter Solstice'),
(65, '2020-12-21', 'Winter Solstice'),
(66, '2010-09-22', 'Autumnal Equinox'),
(67, '2011-09-23', 'Autumnal Equinox'),
(68, '2012-09-22', 'Autumnal Equinox'),
(69, '2013-09-22', 'Autumnal Equinox'),
(70, '2014-09-22', 'Autumnal Equinox'),
(71, '2015-09-23', 'Autumnal Equinox'),
(72, '2016-09-22', 'Autumnal Equinox'),
(73, '2017-09-22', 'Autumnal Equinox'),
(74, '2018-09-22', 'Autumnal Equinox'),
(75, '2019-09-23', 'Autumnal Equinox'),
(76, '2020-09-22', 'Autumnal Equinox'),
(77, '0004-07-04', 'Independence Day'),
(78, '0004-05-05', 'Cinco de Mayo'),
(79, '0004-06-14', 'Flag Day'),
(80, '0004-11-11', 'Veterans Day'),
(81, '0004-02-02', 'Groundhog Day'),
(82, '2010-11-25', 'Thanksgiving'),
(83, '2011-11-24', 'Thanksgiving'),
(84, '2012-11-22', 'Thanksgiving'),
(85, '2013-11-28', 'Thanksgiving'),
(86, '2014-11-27', 'Thanksgiving'),
(87, '2015-11-26', 'Thanksgiving'),
(88, '2016-11-24', 'Thanksgiving'),
(89, '2017-11-23', 'Thanksgiving'),
(90, '2018-11-22', 'Thanksgiving'),
(91, '2019-11-28', 'Thanksgiving'),
(92, '2020-11-26', 'Thanksgiving'),
(93, '2010-05-31', 'Memorial Day'),
(94, '2011-05-30', 'Memorial Day'),
(95, '2012-05-28', 'Memorial Day'),
(96, '2013-05-27', 'Memorial Day'),
(97, '2014-05-26', 'Memorial Day'),
(98, '2015-05-25', 'Memorial Day'),
(99, '2016-05-30', 'Memorial Day'),
(100, '2017-05-29', 'Memorial Day'),
(101, '2018-05-28', 'Memorial Day'),
(102, '2019-05-27', 'Memorial Day'),
(103, '2020-05-25', 'Memorial Day'),
(104, '2010-09-06', 'Labor Day'),
(105, '2011-09-05', 'Labor Day'),
(106, '2012-09-03', 'Labor Day'),
(107, '2013-09-02', 'Labor Day'),
(108, '2014-09-01', 'Labor Day'),
(109, '2015-09-07', 'Labor Day'),
(110, '2016-09-05', 'Labor Day'),
(111, '2017-09-04', 'Labor Day'),
(112, '2018-09-03', 'Labor Day'),
(113, '2019-09-02', 'Labor Day'),
(114, '2020-09-07', 'Labor Day'),
(115, '0004-06-06', 'D-Day');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_categories`
--

CREATE TABLE IF NOT EXISTS `forum_categories` (
`id_cat` tinyint(4) unsigned NOT NULL,
  `cat_order` tinyint(4) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  `can_collapse` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_categories`
--

INSERT INTO `forum_categories` (`id_cat`, `cat_order`, `name`, `can_collapse`) VALUES
(1, 0, 'General Category', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_collapsed_categories`
--

CREATE TABLE IF NOT EXISTS `forum_collapsed_categories` (
  `id_cat` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_custom_fields`
--

CREATE TABLE IF NOT EXISTS `forum_custom_fields` (
`id_field` smallint(5) NOT NULL,
  `col_name` varchar(12) NOT NULL DEFAULT '',
  `field_name` varchar(40) NOT NULL DEFAULT '',
  `field_desc` varchar(255) NOT NULL DEFAULT '',
  `field_type` varchar(8) NOT NULL DEFAULT 'text',
  `field_length` smallint(5) NOT NULL DEFAULT '255',
  `field_options` text NOT NULL,
  `mask` varchar(255) NOT NULL DEFAULT '',
  `show_reg` tinyint(3) NOT NULL DEFAULT '0',
  `show_display` tinyint(3) NOT NULL DEFAULT '0',
  `show_profile` varchar(20) NOT NULL DEFAULT 'forumprofile',
  `private` tinyint(3) NOT NULL DEFAULT '0',
  `active` tinyint(3) NOT NULL DEFAULT '1',
  `bbc` tinyint(3) NOT NULL DEFAULT '0',
  `can_search` tinyint(3) NOT NULL DEFAULT '0',
  `default_value` varchar(255) NOT NULL DEFAULT '',
  `enclose` text NOT NULL,
  `placement` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_group_moderators`
--

CREATE TABLE IF NOT EXISTS `forum_group_moderators` (
  `id_group` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_actions`
--

CREATE TABLE IF NOT EXISTS `forum_log_actions` (
`id_action` int(10) unsigned NOT NULL,
  `id_log` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(16) NOT NULL DEFAULT '',
  `action` varchar(30) NOT NULL DEFAULT '',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `extra` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_activity`
--

CREATE TABLE IF NOT EXISTS `forum_log_activity` (
  `date` date NOT NULL DEFAULT '0001-01-01',
  `hits` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `topics` smallint(5) unsigned NOT NULL DEFAULT '0',
  `posts` smallint(5) unsigned NOT NULL DEFAULT '0',
  `registers` smallint(5) unsigned NOT NULL DEFAULT '0',
  `most_on` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_activity`
--

INSERT INTO `forum_log_activity` (`date`, `hits`, `topics`, `posts`, `registers`, `most_on`) VALUES
('2014-12-03', 0, 2, 5, 2, 4),
('2014-12-05', 0, 0, 0, 3, 7),
('2014-12-09', 0, 0, 0, 1, 3),
('2014-12-10', 0, 0, 0, 1, 3),
('2014-12-11', 0, 0, 0, 0, 1),
('2014-12-12', 0, 0, 0, 0, 2),
('2014-12-13', 0, 0, 0, 0, 1),
('2014-12-23', 0, 0, 0, 0, 2),
('2015-01-02', 0, 0, 0, 1, 2),
('2015-01-03', 0, 0, 0, 0, 1),
('2015-01-04', 0, 0, 0, 2, 1),
('2015-01-05', 0, 0, 0, 0, 1),
('2015-01-06', 0, 0, 0, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_banned`
--

CREATE TABLE IF NOT EXISTS `forum_log_banned` (
`id_ban_log` mediumint(8) unsigned NOT NULL,
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(16) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_boards`
--

CREATE TABLE IF NOT EXISTS `forum_log_boards` (
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_comments`
--

CREATE TABLE IF NOT EXISTS `forum_log_comments` (
`id_comment` mediumint(8) unsigned NOT NULL,
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `member_name` varchar(80) NOT NULL DEFAULT '',
  `comment_type` varchar(8) NOT NULL DEFAULT 'warning',
  `id_recipient` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `recipient_name` varchar(255) NOT NULL DEFAULT '',
  `log_time` int(10) NOT NULL DEFAULT '0',
  `id_notice` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `counter` tinyint(3) NOT NULL DEFAULT '0',
  `body` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_digest`
--

CREATE TABLE IF NOT EXISTS `forum_log_digest` (
  `id_topic` mediumint(8) unsigned NOT NULL,
  `id_msg` int(10) unsigned NOT NULL,
  `note_type` varchar(10) NOT NULL DEFAULT 'post',
  `daily` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `exclude` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_digest`
--

INSERT INTO `forum_log_digest` (`id_topic`, `id_msg`, `note_type`, `daily`, `exclude`) VALUES
(1, 2, 'reply', 0, 0),
(2, 3, 'topic', 0, 1),
(2, 4, 'reply', 0, 0),
(2, 5, 'reply', 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_errors`
--

CREATE TABLE IF NOT EXISTS `forum_log_errors` (
`id_error` mediumint(8) unsigned NOT NULL,
  `log_time` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `ip` char(16) NOT NULL DEFAULT '',
  `url` text NOT NULL,
  `message` text NOT NULL,
  `session` char(32) NOT NULL DEFAULT '',
  `error_type` char(15) NOT NULL DEFAULT 'general',
  `file` varchar(255) NOT NULL DEFAULT '',
  `line` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_errors`
--

INSERT INTO `forum_log_errors` (`id_error`, `log_time`, `id_member`, `ip`, `url`, `message`, `session`, `error_type`, `file`, `line`) VALUES
(30, 1420307793, 1, '83.24.189.238', '?action=admin', 'Administration login attempt!<br />Referer: http://forum.sgaming.pl/index.php?action=admin<br />User agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0<br />IP: 83.24.189.238', 'fab7ccb9b21c12d87b5a4e12c9d4c4e7', 'critical', '', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_floodcontrol`
--

CREATE TABLE IF NOT EXISTS `forum_log_floodcontrol` (
  `ip` char(16) NOT NULL DEFAULT '',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0',
  `log_type` varchar(8) NOT NULL DEFAULT 'post'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_floodcontrol`
--

INSERT INTO `forum_log_floodcontrol` (`ip`, `log_time`, `log_type`) VALUES
('46.118.173.8', 1420673961, 'login'),
('178.187.108.75', 1420541868, 'register'),
('83.9.76.135', 1417597654, 'post');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_group_requests`
--

CREATE TABLE IF NOT EXISTS `forum_log_group_requests` (
`id_request` mediumint(8) unsigned NOT NULL,
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_group` smallint(5) unsigned NOT NULL DEFAULT '0',
  `time_applied` int(10) unsigned NOT NULL DEFAULT '0',
  `reason` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_karma`
--

CREATE TABLE IF NOT EXISTS `forum_log_karma` (
  `id_target` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_executor` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0',
  `action` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_mark_read`
--

CREATE TABLE IF NOT EXISTS `forum_log_mark_read` (
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_member_notices`
--

CREATE TABLE IF NOT EXISTS `forum_log_member_notices` (
`id_notice` mediumint(8) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_notify`
--

CREATE TABLE IF NOT EXISTS `forum_log_notify` (
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sent` tinyint(1) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_online`
--

CREATE TABLE IF NOT EXISTS `forum_log_online` (
  `session` varchar(32) NOT NULL DEFAULT '',
  `log_time` int(10) NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_spider` smallint(5) unsigned NOT NULL DEFAULT '0',
  `ip` int(10) unsigned NOT NULL DEFAULT '0',
  `url` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_online`
--

INSERT INTO `forum_log_online` (`session`, `log_time`, `id_member`, `id_spider`, `ip`, `url`) VALUES
('ip46.118.173.8', 1420673963, 0, 0, 779529480, 'a:1:{s:10:"USER_AGENT";s:108:"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";}');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_packages`
--

CREATE TABLE IF NOT EXISTS `forum_log_packages` (
`id_install` int(10) NOT NULL,
  `filename` varchar(255) NOT NULL DEFAULT '',
  `package_id` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `version` varchar(255) NOT NULL DEFAULT '',
  `id_member_installed` mediumint(8) NOT NULL DEFAULT '0',
  `member_installed` varchar(255) NOT NULL DEFAULT '',
  `time_installed` int(10) NOT NULL DEFAULT '0',
  `id_member_removed` mediumint(8) NOT NULL DEFAULT '0',
  `member_removed` varchar(255) NOT NULL DEFAULT '',
  `time_removed` int(10) NOT NULL DEFAULT '0',
  `install_state` tinyint(3) NOT NULL DEFAULT '1',
  `failed_steps` text NOT NULL,
  `themes_installed` varchar(255) NOT NULL DEFAULT '',
  `db_changes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_polls`
--

CREATE TABLE IF NOT EXISTS `forum_log_polls` (
  `id_poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_choice` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_reported`
--

CREATE TABLE IF NOT EXISTS `forum_log_reported` (
`id_report` mediumint(8) unsigned NOT NULL,
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `membername` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `time_started` int(10) NOT NULL DEFAULT '0',
  `time_updated` int(10) NOT NULL DEFAULT '0',
  `num_reports` mediumint(6) NOT NULL DEFAULT '0',
  `closed` tinyint(3) NOT NULL DEFAULT '0',
  `ignore_all` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_reported_comments`
--

CREATE TABLE IF NOT EXISTS `forum_log_reported_comments` (
`id_comment` mediumint(8) unsigned NOT NULL,
  `id_report` mediumint(8) NOT NULL DEFAULT '0',
  `id_member` mediumint(8) NOT NULL,
  `membername` varchar(255) NOT NULL DEFAULT '',
  `email_address` varchar(255) NOT NULL DEFAULT '',
  `member_ip` varchar(255) NOT NULL DEFAULT '',
  `comment` varchar(255) NOT NULL DEFAULT '',
  `time_sent` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_scheduled_tasks`
--

CREATE TABLE IF NOT EXISTS `forum_log_scheduled_tasks` (
`id_log` mediumint(8) NOT NULL,
  `id_task` smallint(5) NOT NULL DEFAULT '0',
  `time_run` int(10) NOT NULL DEFAULT '0',
  `time_taken` float NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_log_scheduled_tasks`
--

INSERT INTO `forum_log_scheduled_tasks` (`id_log`, `id_task`, `time_run`, `time_taken`) VALUES
(67, 1, 1420553758, 0),
(66, 7, 1420501393, 11),
(65, 1, 1420497491, 0),
(64, 1, 1420444391, 0),
(63, 1, 1420408365, 0),
(62, 3, 1420393708, 0),
(61, 7, 1420393675, 4),
(60, 1, 1420393663, 0),
(59, 1, 1420307794, 0),
(58, 9, 1420307787, 0),
(11, 1, 1417719431, 0),
(12, 5, 1417719433, 0),
(13, 1, 1417727470, 0),
(14, 7, 1417780044, 4),
(15, 1, 1417798515, 0),
(16, 1, 1417805500, 0),
(17, 1, 1417809625, 0),
(18, 1, 1417817454, 0),
(19, 1, 1417844728, 0),
(20, 5, 1417853336, 0),
(21, 3, 1417862758, 0),
(22, 1, 1417862768, 0),
(23, 1, 1417873901, 0),
(24, 1, 1417894152, 0),
(25, 7, 1417900161, 5),
(26, 1, 1417919854, 0),
(27, 5, 1417921490, 0),
(28, 3, 1417943326, 0),
(29, 1, 1417992105, 0),
(30, 7, 1417995220, 4),
(31, 1, 1418015988, 0),
(32, 5, 1418036453, 0),
(33, 3, 1418080027, 0),
(34, 1, 1418115881, 0),
(35, 7, 1418144998, 4),
(36, 5, 1418150771, 0),
(37, 1, 1418150779, 0),
(38, 1, 1418160347, 0),
(39, 1, 1418244635, 0),
(40, 2, 1418244647, 0),
(41, 6, 1418244653, 0),
(42, 9, 1418244654, 0),
(43, 3, 1418244688, 0),
(44, 7, 1418244716, 7),
(45, 1, 1418253195, 0),
(46, 5, 1418415752, 0),
(47, 1, 1418416880, 0),
(48, 7, 1418416895, 4),
(49, 3, 1418416912, 0),
(50, 1, 1418470124, 0),
(51, 1, 1418486656, 0),
(52, 1, 1418497418, 0),
(53, 5, 1420200718, 0),
(54, 7, 1420200718, 4),
(55, 3, 1420200735, 0),
(56, 2, 1420200749, 0),
(57, 6, 1420307600, 0),
(68, 5, 1420553763, 0),
(69, 3, 1420553767, 0),
(70, 1, 1420574014, 0),
(71, 7, 1420583776, 10),
(72, 1, 1420601787, 0),
(73, 1, 1420628964, 0),
(74, 1, 1420650273, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_search_messages`
--

CREATE TABLE IF NOT EXISTS `forum_log_search_messages` (
  `id_search` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_search_results`
--

CREATE TABLE IF NOT EXISTS `forum_log_search_results` (
  `id_search` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `relevance` smallint(5) unsigned NOT NULL DEFAULT '0',
  `num_matches` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_search_subjects`
--

CREATE TABLE IF NOT EXISTS `forum_log_search_subjects` (
  `word` varchar(20) NOT NULL DEFAULT '',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_search_topics`
--

CREATE TABLE IF NOT EXISTS `forum_log_search_topics` (
  `id_search` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_spider_hits`
--

CREATE TABLE IF NOT EXISTS `forum_log_spider_hits` (
`id_hit` int(10) unsigned NOT NULL,
  `id_spider` smallint(5) unsigned NOT NULL DEFAULT '0',
  `log_time` int(10) unsigned NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `processed` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_spider_stats`
--

CREATE TABLE IF NOT EXISTS `forum_log_spider_stats` (
  `id_spider` smallint(5) unsigned NOT NULL DEFAULT '0',
  `page_hits` smallint(5) unsigned NOT NULL DEFAULT '0',
  `last_seen` int(10) unsigned NOT NULL DEFAULT '0',
  `stat_date` date NOT NULL DEFAULT '0001-01-01'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_subscribed`
--

CREATE TABLE IF NOT EXISTS `forum_log_subscribed` (
`id_sublog` int(10) unsigned NOT NULL,
  `id_subscribe` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_member` int(10) NOT NULL DEFAULT '0',
  `old_id_group` smallint(5) NOT NULL DEFAULT '0',
  `start_time` int(10) NOT NULL DEFAULT '0',
  `end_time` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(3) NOT NULL DEFAULT '0',
  `payments_pending` tinyint(3) NOT NULL DEFAULT '0',
  `pending_details` text NOT NULL,
  `reminder_sent` tinyint(3) NOT NULL DEFAULT '0',
  `vendor_ref` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_log_topics`
--

CREATE TABLE IF NOT EXISTS `forum_log_topics` (
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_msg` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_mail_queue`
--

CREATE TABLE IF NOT EXISTS `forum_mail_queue` (
`id_mail` int(10) unsigned NOT NULL,
  `time_sent` int(10) NOT NULL DEFAULT '0',
  `recipient` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `headers` text NOT NULL,
  `send_html` tinyint(3) NOT NULL DEFAULT '0',
  `priority` tinyint(3) NOT NULL DEFAULT '1',
  `private` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_membergroups`
--

CREATE TABLE IF NOT EXISTS `forum_membergroups` (
`id_group` smallint(5) unsigned NOT NULL,
  `group_name` varchar(80) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `online_color` varchar(20) NOT NULL DEFAULT '',
  `min_posts` mediumint(9) NOT NULL DEFAULT '-1',
  `max_messages` smallint(5) unsigned NOT NULL DEFAULT '0',
  `stars` varchar(255) NOT NULL DEFAULT '',
  `group_type` tinyint(3) NOT NULL DEFAULT '0',
  `hidden` tinyint(3) NOT NULL DEFAULT '0',
  `id_parent` smallint(5) NOT NULL DEFAULT '-2'
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_membergroups`
--

INSERT INTO `forum_membergroups` (`id_group`, `group_name`, `description`, `online_color`, `min_posts`, `max_messages`, `stars`, `group_type`, `hidden`, `id_parent`) VALUES
(1, 'Administrator', '', '#FF0000', -1, 0, '', 0, 0, -2),
(2, 'Global Moderator', '', '#0000FF', -1, 0, '', 0, 0, -2),
(3, 'Moderator', '', '', -1, 0, '', 0, 0, -2),
(4, 'Newbie', '', '', 0, 0, '1#star.gif', 0, 0, -2),
(5, 'Jr. Member', '', '', 50, 0, '2#star.gif', 0, 0, -2),
(6, 'Full Member', '', '', 100, 0, '3#star.gif', 0, 0, -2),
(7, 'Sr. Member', '', '', 250, 0, '4#star.gif', 0, 0, -2),
(8, 'Hero Member', '', '', 500, 0, '5#star.gif', 0, 0, -2),
(9, 'Ekipa', '', '', -1, 0, '', 0, 0, -2);

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
  `admin` int(11) NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_members`
--

INSERT INTO `forum_members` (`id_member`, `member_name`, `date_registered`, `posts`, `id_group`, `lngfile`, `last_login`, `real_name`, `instant_messages`, `unread_messages`, `new_pm`, `buddy_list`, `pm_ignore_list`, `pm_prefs`, `mod_prefs`, `message_labels`, `passwd`, `openid_uri`, `email_address`, `personal_text`, `gender`, `birthdate`, `website_title`, `website_url`, `location`, `icq`, `aim`, `yim`, `msn`, `hide_email`, `show_online`, `time_format`, `signature`, `time_offset`, `avatar`, `pm_email_notify`, `karma_bad`, `karma_good`, `usertitle`, `notify_announcements`, `notify_regularity`, `notify_send_body`, `notify_types`, `member_ip`, `member_ip2`, `secret_question`, `secret_answer`, `id_theme`, `is_activated`, `validation_code`, `id_msg_last_visit`, `additional_groups`, `smiley_set`, `id_post_group`, `total_time_logged_in`, `password_salt`, `ignore_boards`, `warning`, `passwd_flood`, `pm_receive_from`, `inGame`, `admin`) VALUES
(1, 'Kubas', 1417596022, 4, 1, '', 1420554085, 'Kubas', 0, 0, 0, '', '', 0, '', '', '27223ed8980dd8ed1c85e67570121a6b17d5d3c0', '', 'kubasgc@icloud.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, '', 1, 1, 0, 2, '178.42.14.172', '108.162.230.197', '', '', 4, 1, '', 0, '', '', 4, 5275, '5044', '', 0, '', 1, 0, 3),
(14, 'Envoyer', 0, 0, 0, '', 0, 'Envoyer', 0, 0, 0, '', '', 0, '', '', '962b439da7dab511c4a42a66ab045153a39abf96', '', 'ethan133@wp.pl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 0, 0, 0, 'Envoyer', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0),
(15, 'kofeTymn', 1420515290, 0, 0, '', 1420515290, 'kofeTymn', 0, 0, 0, '', '', 0, '', '', '219453fc24acb7f7b213024134ad2c39caf01b4e', '', 'xbiovxekhll@rambler.ru', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '89.178.82.79', '141.101.104.216', '', '', 4, 1, '', 0, '', '', 4, 0, '274c', '', 0, '', 1, 0, 0),
(3, 'Szychu', 1417817515, 0, 0, '', 1418253210, 'Szychu', 0, 0, 0, '', '', 0, '', '', 'fec530892325bae24d6ba90516479ff748477f9f', '', 'SzychuTM@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.30.148.72', '141.101.89.145', '', '', 4, 1, '', 0, '', '', 4, 703, '701b', '', 0, '', 1, 0, 2),
(4, 'Rubik', 1417817576, 0, 0, '', 1417818827, 'Rubik', 0, 0, 0, '', '', 0, '', '', 'c2e7c368d54804449f1387ef5cf29f5023aa4dc0', '', 'rubiikk221@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '89.79.217.0', '141.101.89.162', '', '', 4, 1, '', 0, '', '', 4, 122, '2c7e', '', 0, '', 1, 0, 3),
(5, 'Piteriuz', 1417817972, 0, 0, '', 1417818036, 'Piteriuz', 0, 0, 0, '', '', 0, '', '', '95fa0ed33d49c5fb1c2ddc57f677ac08b9233915', '', 'piteriuz@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.28.154.188', '108.162.254.145', '', '', 4, 1, '', 0, '', '', 4, 99, 'faa9', '', 0, '', 1, 0, 2),
(6, 'Kaizi', 1418160453, 0, 0, '', 1418162401, 'Kaizi', 0, 0, 0, '', '', 0, '', '', 'e8c4532e47c8ccd6fe4d46423fc128dee0500b8a', '', 'kaizi94@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '77.255.65.33', '141.101.89.105', '', '', 4, 1, '', 0, '', '', 4, 807, 'c774', '', 0, '', 1, 0, 3),
(7, 'Grzegorz', 1418244708, 0, 0, '', 1418244708, 'Grzegorz', 0, 0, 0, '', '', 0, '', '', '383b02c255a6b2a2f340144403dd6494002951d3', '', 'Grzegorz_Grzeholek@o2.pl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '77.254.139.160', '141.101.89.146', '', '', 4, 1, '', 0, '', '', 4, 0, 'bb86', '', 0, '', 1, 0, 0),
(8, 'Msk', 1420200734, 0, 0, '', 1420200748, 'Msk', 0, 0, 0, '', '', 0, '', '', 'fd066441621ad87e61dd3098352ae57f52c8f642', '', 'msk@firstclassgaming.net', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.31.215.60', '141.101.89.111', '', '', 4, 1, '', 0, '', '', 4, 0, 'c7e4', '', 0, '', 1, 0, 0),
(9, 'KennethNami', 1420329511, 0, 0, '', 1420673961, 'KennethNami', 0, 0, 0, '', '', 0, '', '', '64eeb8732672786f6bc5c93c3b55460d29c2a027', '', 'carlosteroristos@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '46.118.173.8', '108.162.254.234', '', '', 4, 1, '', 0, '', '', 4, 0, 'bc43', '', 0, '', 1, 0, 0),
(10, 'Tester', 0, 0, 0, '', 0, 'Tester', 0, 0, 0, '', '', 0, '', '', '5bfdb9d2aa3e5a96ab796bf3bee19d15208e4111', '', 'test@test.te', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, '', 1, 1, 0, 2, '46.118.173.60', '46.118.173.60', '', '', 4, 1, '', 0, '', '', 4, 0, '09da', '', 0, '', 1, 0, 0),
(11, 'DanielEvok', 1420399329, 0, 0, '', 1420666483, 'DanielEvok', 0, 0, 0, '', '', 0, '', '', 'c108982e58f6e6a67503a80c489b9b46d996af78', '', 'vasalx@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '176.8.3.1', '108.162.230.101', '', '', 4, 1, '', 0, '', '', 4, 0, '984c', '', 0, '', 1, 0, 0),
(12, 'Testora', 0, 0, 0, '', 0, 'Testora', 0, 0, 0, '', '', 0, '', '', 'f6ac17d9794ffebfa271e446623034f9fc4f69c1', '', 'bool@bool.bl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Tytul', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0),
(13, 'Testor', 0, 0, 0, '', 0, 'Testor', 0, 0, 0, '', '', 0, '', '', '89de9000646e586b6cb7063d6179047a0e3e4c26', '', 'bool@bool.bla', '', 1, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 0, 0, 0, 'Ramon.', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0),
(16, 'fautytaiMaL', 1420541868, 0, 0, '', 1420541868, 'fautytaiMaL', 0, 0, 0, '', '', 0, '', '', 'a1f48748ff04e1661d2ea7ec6071089874179526', '', 'cedricpam@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '178.187.108.75', '141.101.99.78', '', '', 4, 1, '', 0, '', '', 4, 0, '0ed2', '', 0, '', 1, 0, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_messages`
--

CREATE TABLE IF NOT EXISTS `forum_messages` (
`id_msg` int(10) unsigned NOT NULL,
  `id_topic` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `poster_time` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_msg_modified` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `poster_name` varchar(255) NOT NULL DEFAULT '',
  `poster_email` varchar(255) NOT NULL DEFAULT '',
  `poster_ip` varchar(255) NOT NULL DEFAULT '',
  `smileys_enabled` tinyint(4) NOT NULL DEFAULT '1',
  `modified_time` int(10) unsigned NOT NULL DEFAULT '0',
  `modified_name` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL,
  `icon` varchar(16) NOT NULL DEFAULT 'xx',
  `approved` tinyint(3) NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_message_icons`
--

CREATE TABLE IF NOT EXISTS `forum_message_icons` (
`id_icon` smallint(5) unsigned NOT NULL,
  `title` varchar(80) NOT NULL DEFAULT '',
  `filename` varchar(80) NOT NULL DEFAULT '',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `icon_order` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_message_icons`
--

INSERT INTO `forum_message_icons` (`id_icon`, `title`, `filename`, `id_board`, `icon_order`) VALUES
(1, 'Standard', 'xx', 0, 0),
(2, 'Thumb Up', 'thumbup', 0, 1),
(3, 'Thumb Down', 'thumbdown', 0, 2),
(4, 'Exclamation point', 'exclamation', 0, 3),
(5, 'Question mark', 'question', 0, 4),
(6, 'Lamp', 'lamp', 0, 5),
(7, 'Smiley', 'smiley', 0, 6),
(8, 'Angry', 'angry', 0, 7),
(9, 'Cheesy', 'cheesy', 0, 8),
(10, 'Grin', 'grin', 0, 9),
(11, 'Sad', 'sad', 0, 10),
(12, 'Wink', 'wink', 0, 11);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_moderators`
--

CREATE TABLE IF NOT EXISTS `forum_moderators` (
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_openid_assoc`
--

CREATE TABLE IF NOT EXISTS `forum_openid_assoc` (
  `server_url` text NOT NULL,
  `handle` varchar(255) NOT NULL DEFAULT '',
  `secret` text NOT NULL,
  `issued` int(10) NOT NULL DEFAULT '0',
  `expires` int(10) NOT NULL DEFAULT '0',
  `assoc_type` varchar(64) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_package_servers`
--

CREATE TABLE IF NOT EXISTS `forum_package_servers` (
`id_server` smallint(5) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_package_servers`
--

INSERT INTO `forum_package_servers` (`id_server`, `name`, `url`) VALUES
(1, 'Simple Machines Third-party Mod Site', 'http://custom.simplemachines.org/packages/mods');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_permissions`
--

CREATE TABLE IF NOT EXISTS `forum_permissions` (
  `id_group` smallint(5) NOT NULL DEFAULT '0',
  `permission` varchar(30) NOT NULL DEFAULT '',
  `add_deny` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_permissions`
--

INSERT INTO `forum_permissions` (`id_group`, `permission`, `add_deny`) VALUES
(-1, 'search_posts', 1),
(-1, 'calendar_view', 1),
(-1, 'view_stats', 1),
(-1, 'profile_view_any', 1),
(0, 'view_mlist', 1),
(0, 'search_posts', 1),
(0, 'profile_view_own', 1),
(0, 'profile_view_any', 1),
(0, 'pm_read', 1),
(0, 'pm_send', 1),
(0, 'calendar_view', 1),
(0, 'view_stats', 1),
(0, 'who_view', 1),
(0, 'profile_identity_own', 1),
(0, 'profile_extra_own', 1),
(0, 'profile_remove_own', 1),
(0, 'profile_server_avatar', 1),
(0, 'profile_upload_avatar', 1),
(0, 'profile_remote_avatar', 1),
(0, 'karma_edit', 1),
(2, 'view_mlist', 1),
(2, 'search_posts', 1),
(2, 'profile_view_own', 1),
(2, 'profile_view_any', 1),
(2, 'pm_read', 1),
(2, 'pm_send', 1),
(2, 'calendar_view', 1),
(2, 'view_stats', 1),
(2, 'who_view', 1),
(2, 'profile_identity_own', 1),
(2, 'profile_extra_own', 1),
(2, 'profile_remove_own', 1),
(2, 'profile_server_avatar', 1),
(2, 'profile_upload_avatar', 1),
(2, 'profile_remote_avatar', 1),
(2, 'profile_title_own', 1),
(2, 'calendar_post', 1),
(2, 'calendar_edit_any', 1),
(2, 'karma_edit', 1),
(2, 'access_mod_center', 1),
(9, 'profile_remote_avatar', 1),
(9, 'profile_upload_avatar', 1),
(9, 'profile_remove_own', 1),
(9, 'profile_title_any', 1),
(9, 'profile_extra_any', 1),
(9, 'profile_extra_own', 1),
(9, 'profile_identity_any', 1),
(9, 'profile_identity_own', 1),
(9, 'profile_view_any', 1),
(9, 'profile_view_own', 1),
(9, 'pm_send', 1),
(9, 'pm_read', 1),
(9, 'issue_warning', 1),
(9, 'calendar_edit_any', 1),
(9, 'calendar_edit_own', 1),
(9, 'calendar_post', 1),
(9, 'calendar_view', 1),
(9, 'karma_edit', 1),
(9, 'search_posts', 1),
(9, 'who_view', 1),
(9, 'view_mlist', 1),
(9, 'view_stats', 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_permission_profiles`
--

CREATE TABLE IF NOT EXISTS `forum_permission_profiles` (
`id_profile` smallint(5) NOT NULL,
  `profile_name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_permission_profiles`
--

INSERT INTO `forum_permission_profiles` (`id_profile`, `profile_name`) VALUES
(1, 'default'),
(2, 'no_polls'),
(3, 'reply_only'),
(4, 'read_only');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_personal_messages`
--

CREATE TABLE IF NOT EXISTS `forum_personal_messages` (
`id_pm` int(10) unsigned NOT NULL,
  `id_pm_head` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member_from` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `deleted_by_sender` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `from_name` varchar(255) NOT NULL DEFAULT '',
  `msgtime` int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `body` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_pm_recipients`
--

CREATE TABLE IF NOT EXISTS `forum_pm_recipients` (
  `id_pm` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `labels` varchar(60) NOT NULL DEFAULT '-1',
  `bcc` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_read` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_pm_rules`
--

CREATE TABLE IF NOT EXISTS `forum_pm_rules` (
`id_rule` int(10) unsigned NOT NULL,
  `id_member` int(10) unsigned NOT NULL DEFAULT '0',
  `rule_name` varchar(60) NOT NULL,
  `criteria` text NOT NULL,
  `actions` text NOT NULL,
  `delete_pm` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `is_or` tinyint(3) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_polls`
--

CREATE TABLE IF NOT EXISTS `forum_polls` (
`id_poll` mediumint(8) unsigned NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `voting_locked` tinyint(1) NOT NULL DEFAULT '0',
  `max_votes` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `expire_time` int(10) unsigned NOT NULL DEFAULT '0',
  `hide_results` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `change_vote` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `guest_vote` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `num_guest_voters` int(10) unsigned NOT NULL DEFAULT '0',
  `reset_poll` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member` mediumint(8) NOT NULL DEFAULT '0',
  `poster_name` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_poll_choices`
--

CREATE TABLE IF NOT EXISTS `forum_poll_choices` (
  `id_poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_choice` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `label` varchar(255) NOT NULL DEFAULT '',
  `votes` smallint(5) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_scheduled_tasks`
--

CREATE TABLE IF NOT EXISTS `forum_scheduled_tasks` (
`id_task` smallint(5) NOT NULL,
  `next_time` int(10) NOT NULL DEFAULT '0',
  `time_offset` int(10) NOT NULL DEFAULT '0',
  `time_regularity` smallint(5) NOT NULL DEFAULT '0',
  `time_unit` varchar(1) NOT NULL DEFAULT 'h',
  `disabled` tinyint(3) NOT NULL DEFAULT '0',
  `task` varchar(24) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_scheduled_tasks`
--

INSERT INTO `forum_scheduled_tasks` (`id_task`, `next_time`, `time_offset`, `time_regularity`, `time_unit`, `disabled`, `task`) VALUES
(1, 1420660800, 0, 2, 'h', 0, 'approval_notification'),
(2, 1420761600, 0, 7, 'd', 0, 'auto_optimize'),
(3, 1420675260, 60, 1, 'd', 0, 'daily_maintenance'),
(5, 1420675200, 0, 1, 'd', 0, 'daily_digest'),
(6, 1420848000, 0, 1, 'w', 0, 'weekly_digest'),
(7, 1420661040, 158678, 1, 'd', 0, 'fetchSMfiles'),
(8, 0, 0, 1, 'd', 1, 'birthdayemails'),
(9, 1420848000, 0, 1, 'w', 0, 'weekly_maintenance'),
(10, 0, 120, 1, 'd', 1, 'paid_subscriptions');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_sessions`
--

CREATE TABLE IF NOT EXISTS `forum_sessions` (
  `session_id` char(32) NOT NULL,
  `last_update` int(10) unsigned NOT NULL,
  `data` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_sessions`
--

INSERT INTO `forum_sessions` (`session_id`, `last_update`, `data`) VALUES
('vbqknrke9t1nat1u35hmcor6g7', 1420673963, 'session_value|s:32:"5922f8f7491025924333fbbf4e83d2a2";session_var|s:11:"a52cbdbeb33";mc|a:7:{s:4:"time";i:1420673963;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420673963;s:9:"id_member";i:0;s:2:"ip";s:12:"46.118.173.8";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1420673963;timeOnlineUpdated|i:1420673963;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('fl01lc072v1g6et9bro4vt8vm7', 1420667969, 'session_value|s:32:"0406d22215256df2097de5fab7ccb44b";session_var|s:8:"bad1b1da";mc|a:7:{s:4:"time";i:1420667967;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420667969;s:9:"id_member";i:0;s:2:"ip";s:12:"46.118.173.8";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1420667967;timeOnlineUpdated|i:1420667967;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36";'),
('as2urgnnec4vmd5gddd8ge0ki7', 1420669633, 'session_value|s:32:"f4cfea4f7f50ee713b9b213eefa7cb93";session_var|s:7:"a3c7a2d";mc|a:7:{s:4:"time";i:1420669631;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420669633;s:9:"id_member";i:0;s:2:"ip";s:12:"46.118.173.8";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1420669632;timeOnlineUpdated|i:1420669632;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:76:"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:33.0) Gecko/20100101 Firefox/33.0";'),
('ms3si5fl9ct3hrmvkkfap9lfl6', 1420666484, 'session_value|s:32:"63d9c3d7581863ed605d5706aa3cb88d";session_var|s:11:"ff58d3af373";mc|a:7:{s:4:"time";i:1420666483;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420666484;s:9:"id_member";i:0;s:2:"ip";s:9:"176.8.3.1";s:3:"ip2";s:15:"108.162.230.101";s:5:"email";s:0:"";}log_time|i:1420666483;timeOnlineUpdated|i:1420666483;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 6.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('hi184be5tqelvnchiidjt76d40', 1420656104, 'session_value|s:32:"8869854ed507b4989ad9412c6b5ceb34";session_var|s:9:"bf7afbf70";mc|a:7:{s:4:"time";i:1420656102;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420656103;s:9:"id_member";i:0;s:2:"ip";s:12:"46.118.173.8";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1420656103;timeOnlineUpdated|i:1420656103;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('g0cgg0j3r1c0rb4utjvfr6bkj0', 1420658246, 'session_value|s:32:"69c89c2e143c0a8c8ef85b066e867ab5";session_var|s:10:"c1617bea1e";mc|a:7:{s:4:"time";i:1420658245;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420658246;s:9:"id_member";i:0;s:2:"ip";s:14:"87.206.240.118";s:3:"ip2";s:14:"141.101.88.146";s:5:"email";s:0:"";}log_time|i:1420658245;timeOnlineUpdated|i:1420658245;old_url|s:49:"http://forum.sgaming.pl/index.php?action=register";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('tej8shq1dqhtvfagkaui6ktnk5', 1420657962, 'session_value|s:32:"2cad3754bb382cb7415e6a3f5a6b74ec";session_var|s:8:"c93629fc";mc|a:7:{s:4:"time";i:1420657962;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420657962;s:9:"id_member";i:0;s:2:"ip";s:12:"46.118.173.8";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1420657962;timeOnlineUpdated|i:1420657962;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:109:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.111 Safari/537.36";'),
('a6olte9ejs1u310irqfh3dav62', 1420653545, 'session_value|s:32:"fa7577e1385b8fff0791d3027b51586d";session_var|s:12:"b653202f4330";mc|a:7:{s:4:"time";i:1420653544;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420653545;s:9:"id_member";i:0;s:2:"ip";s:9:"176.8.3.1";s:3:"ip2";s:15:"108.162.230.101";s:5:"email";s:0:"";}log_time|i:1420653544;timeOnlineUpdated|i:1420653544;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.65 Safari/537.36";'),
('8kl7m3p41tskvlg4pbbg2vvf12', 1420650285, 'session_value|s:32:"75a4f7dac68a483a7aa665bfc4a872ba";session_var|s:8:"f5bcba08";mc|a:7:{s:4:"time";i:1420650284;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420650284;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.69.76";s:3:"ip2";s:15:"108.162.216.185";s:5:"email";s:0:"";}log_time|i:1420650285;timeOnlineUpdated|i:1420650285;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('cb7qfjoarmqt846o9ckv078322', 1420650274, 'session_value|s:32:"494c094725c223ac5d2ee53ed70e3040";session_var|s:11:"e437bf7de06";mc|a:7:{s:4:"time";i:1420650273;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420650273;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.156";s:5:"email";s:0:"";}log_time|i:1420650274;timeOnlineUpdated|i:1420650274;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('pi2f3s7dv0dqrhfg1fiual8lu5', 1420628976, 'session_value|s:32:"e5e72d157d0db82a2b50bd6e804c4e2c";session_var|s:12:"ec63bfd935df";mc|a:7:{s:4:"time";i:1420628975;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420628975;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.185";s:5:"email";s:0:"";}log_time|i:1420628976;timeOnlineUpdated|i:1420628976;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('v8guqeenvv8f24hn1l06ccb8l6', 1420628965, 'session_value|s:32:"e99ce04f8fddbb438f0c3fd896ebe924";session_var|s:12:"d6cdd0422d9b";mc|a:7:{s:4:"time";i:1420628964;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420628964;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.156";s:5:"email";s:0:"";}log_time|i:1420628965;timeOnlineUpdated|i:1420628965;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('04rkk5ne99bf4jf9a10h2uug30', 1420601915, 'session_value|s:32:"49e9c732a219d132271623521e13e0ae";session_var|s:12:"ff2529946afb";mc|a:7:{s:4:"time";i:1420601914;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420601914;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.140";s:3:"ip2";s:15:"108.162.216.185";s:5:"email";s:0:"";}log_time|i:1420601915;timeOnlineUpdated|i:1420601915;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('jl0r0e48hlkmvq73mm1smgtu03', 1420601788, 'session_value|s:32:"a6df443f63c4ace9108d57dc2586eba3";session_var|s:11:"ad2048ade7c";mc|a:7:{s:4:"time";i:1420601787;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420601787;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.140";s:3:"ip2";s:15:"108.162.216.156";s:5:"email";s:0:"";}log_time|i:1420601788;timeOnlineUpdated|i:1420601788;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('j38m2m5dem2r4n43s77907qhc6', 1420583776, 'session_value|s:32:"4094958c9f8d023824b282d01315990d";session_var|s:9:"d4936456f";mc|a:7:{s:4:"time";i:1420583765;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420583776;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.69.76";s:3:"ip2";s:15:"108.162.216.156";s:5:"email";s:0:"";}log_time|i:1420583776;timeOnlineUpdated|i:1420583776;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('o6dtnl0c6619j9f899lbub2844', 1420574014, 'session_value|s:32:"bca89b6bb129b156168ef6214a63471f";session_var|s:11:"f5e21a38ba5";mc|a:7:{s:4:"time";i:1420574014;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420574014;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.154";s:5:"email";s:0:"";}log_time|i:1420574014;timeOnlineUpdated|i:1420574014;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('v765nigkmee3b0sos16ecvc8q2', 1420554085, 'session_value|s:32:"ff8817627805c9975adb2f34f6f33aec";session_var|s:8:"f8d70a71";mc|a:7:{s:4:"time";i:1420553804;s:2:"id";s:1:"1";s:2:"gq";s:3:"1=1";s:2:"bq";s:3:"1=1";s:2:"ap";a:1:{i:0;i:0;}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420553804;s:9:"id_member";i:0;s:2:"ip";s:13:"178.42.14.172";s:3:"ip2";s:15:"108.162.230.197";s:5:"email";s:0:"";}log_time|i:1420554080;timeOnlineUpdated|i:1420553757;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36";login_SMFCookie215|s:95:"a:4:{i:0;s:1:"1";i:1;s:40:"1f89c99c04f1c430f72feec8f9fde162d1370bb6";i:2;i:1609769804;i:3;i:0;}";admin_time|i:1420553804;id_msg_last_visit|s:1:"0";rc|a:3:{s:2:"id";s:1:"1";s:4:"time";i:1420553804;s:7:"reports";s:1:"0";}unread_messages|i:0;pm_selected|a:0:{}'),
('v1bl3nmebn567qsnaaf40ed5a6', 1420541869, 'session_value|s:32:"fb362881e6d3ecb0c99bd785e735bd1b";session_var|s:9:"a272c8db0";mc|a:7:{s:4:"time";i:1420541868;s:2:"id";s:2:"16";s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420541869;s:9:"id_member";s:2:"16";s:2:"ip";s:14:"178.187.108.75";s:3:"ip2";s:13:"141.101.99.78";s:5:"email";s:21:"cedricpam@outlook.com";}log_time|i:1420541865;timeOnlineUpdated|i:1420541865;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:33.0) Gecko/20100101 Firefox/33.0";register_vv|a:5:{s:5:"count";i:4;s:6:"errors";i:1;s:8:"did_pass";b:1;s:1:"q";a:0:{}s:4:"code";s:6:"FVNTXC";}registration_agreed|b:1;just_registered|i:1;login_SMFCookie215|s:92:"a:4:{i:0;i:16;i:1;s:40:"72cbf2c1739e986f5d34ee629a57693b665b356a";i:2;i:1420545468;i:3;i:0;}";id_msg_last_visit|s:1:"0";unread_messages|i:0;'),
('vghcrass34en6slp54l796fnj0', 1420554091, 'session_value|s:32:"db8ef356f7616ca7048fffa4c39fdced";session_var|s:10:"ebcc2688dd";mc|a:7:{s:4:"time";i:1420554091;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420554091;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.93.224";s:3:"ip2";s:13:"173.245.54.62";s:5:"email";s:0:"";}log_time|i:1420554091;timeOnlineUpdated|i:1420554091;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:78:"Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0 Google favicon";'),
('2nfgrqba2ngscnq9h51krkcho0', 1420515291, 'session_value|s:32:"f248ddcfd7146bc43d2bbbd15768c84f";session_var|s:9:"a6a8652bf";mc|a:7:{s:4:"time";i:1420515290;s:2:"id";s:2:"15";s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420515291;s:9:"id_member";s:2:"15";s:2:"ip";s:12:"89.178.82.79";s:3:"ip2";s:15:"141.101.104.216";s:5:"email";s:22:"xbiovxekhll@rambler.ru";}log_time|i:1420515288;timeOnlineUpdated|i:1420515288;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";register_vv|a:5:{s:5:"count";i:3;s:6:"errors";i:0;s:8:"did_pass";b:1;s:1:"q";a:0:{}s:4:"code";s:6:"KHAGHY";}registration_agreed|b:1;just_registered|i:1;login_SMFCookie215|s:92:"a:4:{i:0;i:15;i:1;s:40:"af8041839ecec8f64dd8d4ebb426db2551d19085";i:2;i:1420518890;i:3;i:0;}";id_msg_last_visit|s:1:"0";unread_messages|i:0;'),
('8v1320j28m5plon3ecqpsak4p5', 1420502289, 'session_value|s:32:"fbb5f5dc0f4e39b6677428aa76e4dced";session_var|s:9:"c50db797a";mc|a:7:{s:4:"time";i:1420502289;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502289;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.69.92";s:3:"ip2";s:15:"108.162.216.155";s:5:"email";s:0:"";}log_time|i:1420502289;timeOnlineUpdated|i:1420502289;old_url|s:78:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=showposts;sa=attach";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('2iu2c2bh3jj12et6aibclaqi11', 1420502220, 'session_value|s:32:"cd97a9060ae61dd59e64c9b1fe25f2e0";session_var|s:11:"c2a0e4600ab";mc|a:7:{s:4:"time";i:1420502220;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502220;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.69.92";s:3:"ip2";s:15:"108.162.216.179";s:5:"email";s:0:"";}log_time|i:1420502220;timeOnlineUpdated|i:1420502220;old_url|s:80:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=showposts;sa=messages";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('s5d8ukrat4ktvt515k56po4mg6', 1420502161, 'session_value|s:32:"8241ef3ca9010f9c0e0a3438cd7ea2a7";session_var|s:7:"fb72e7a";mc|a:7:{s:4:"time";i:1420502161;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502161;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.180";s:5:"email";s:0:"";}log_time|i:1420502161;timeOnlineUpdated|i:1420502161;old_url|s:94:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=showposts;sa=attach;sort=posted;asc";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('0grh6gckp7m695vc1rjh9h2kl6', 1420502101, 'session_value|s:32:"2b64618aba22078b3dce2ff720b3d8eb";session_var|s:12:"db9a84b60a64";mc|a:7:{s:4:"time";i:1420502101;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502101;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.180";s:5:"email";s:0:"";}log_time|i:1420502101;timeOnlineUpdated|i:1420502101;old_url|s:68:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=showposts";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('kqn69286loh83vtvt82q997b64', 1420502072, 'session_value|s:32:"5d510a9692541a3a0003ab176a5dad56";session_var|s:12:"df150fd1dc55";mc|a:7:{s:4:"time";i:1420502072;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502072;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.140";s:3:"ip2";s:15:"108.162.216.204";s:5:"email";s:0:"";}log_time|i:1420502072;timeOnlineUpdated|i:1420502072;old_url|s:78:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=showposts;sa=topics";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('62njbj0l8rpqsvivpm45oaio43', 1420502071, 'session_value|s:32:"3ad702a64b272ce0712f6ed676e44875";session_var|s:12:"ee97a34154a7";mc|a:7:{s:4:"time";i:1420502070;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502070;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:14:"108.162.216.48";s:5:"email";s:0:"";}log_time|i:1420502071;timeOnlineUpdated|i:1420502071;old_url|s:69:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=statistics";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('1mc2oh199ve5futl5ipd1bo0l5', 1420502000, 'session_value|s:32:"337a9737cb852da779f4bc3e60c14f15";session_var|s:9:"db07694e9";mc|a:7:{s:4:"time";i:1420502000;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420502000;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.207";s:5:"email";s:0:"";}log_time|i:1420502000;timeOnlineUpdated|i:1420502000;old_url|s:78:"http://forum.sgaming.pl/index.php?action=profile;area=showposts;sa=topics;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('3r7sgemapoaeg8ekpcspi8lkq3', 1420501965, 'session_value|s:32:"251709e94515d6292886846b42bc3924";session_var|s:7:"a8d348a";mc|a:7:{s:4:"time";i:1420501965;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501965;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.184";s:5:"email";s:0:"";}log_time|i:1420501965;timeOnlineUpdated|i:1420501965;old_url|s:80:"http://forum.sgaming.pl/index.php?action=profile;area=showposts;sa=messages;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('s87vp8hruhf61igm0qbfc2g7p5', 1420501936, 'session_value|s:32:"6167f116833bbc659a28f50613afd4fb";session_var|s:8:"bbb0c23a";mc|a:7:{s:4:"time";i:1420501936;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501936;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.173";s:5:"email";s:0:"";}log_time|i:1420501936;timeOnlineUpdated|i:1420501936;old_url|s:78:"http://forum.sgaming.pl/index.php?action=profile;area=showposts;sa=attach;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('ecjcpla1obkh3q4bs0dp42b8d5', 1420501921, 'session_value|s:32:"5a68db114951556df8eda69569c9516f";session_var|s:7:"f2c55fc";mc|a:7:{s:4:"time";i:1420501921;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501921;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.178";s:5:"email";s:0:"";}log_time|i:1420501921;timeOnlineUpdated|i:1420501921;old_url|s:69:"http://forum.sgaming.pl/index.php?action=profile;area=statistics;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('5vusrtd8icm5oabpah832qmme7', 1420501907, 'session_value|s:32:"7f22576b130ed4388c59d52a9adc0ffb";session_var|s:8:"b78c67b0";mc|a:7:{s:4:"time";i:1420501907;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501907;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.178";s:5:"email";s:0:"";}log_time|i:1420501907;timeOnlineUpdated|i:1420501907;old_url|s:68:"http://forum.sgaming.pl/index.php?action=profile;area=showposts;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('hgjrapbonh3efgh0snt4c69rc2', 1420501896, 'session_value|s:32:"83c32160872e63f6d33558463ce76606";session_var|s:12:"b724b8869e39";mc|a:7:{s:4:"time";i:1420501895;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501895;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.202";s:5:"email";s:0:"";}log_time|i:1420501896;timeOnlineUpdated|i:1420501896;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;area=summary;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('rr8n6d521mau7rrt0as0gosc44', 1420501885, 'session_value|s:32:"2b510698cb5f5a8ae07423c2532ed2ea";session_var|s:8:"c1791054";mc|a:7:{s:4:"time";i:1420501885;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501885;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.186";s:5:"email";s:0:"";}log_time|i:1420501885;timeOnlineUpdated|i:1420501885;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('ccj36iilu3eco39s3ue2s68da3', 1420501513, 'session_value|s:32:"bbd0459e6fc9b7df85036340fb37c2ed";session_var|s:9:"e26a735ed";mc|a:7:{s:4:"time";i:1420501512;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501512;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.124";s:3:"ip2";s:15:"108.162.216.185";s:5:"email";s:0:"";}log_time|i:1420501513;timeOnlineUpdated|i:1420501513;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('9r79j9tq9tspgbns9mdu3plhg2', 1420501393, 'session_value|s:32:"61def3f0b86451a50bf05aca4db0555a";session_var|s:10:"fdc2b38504";mc|a:7:{s:4:"time";i:1420501382;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420501393;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.69.108";s:3:"ip2";s:15:"108.162.216.156";s:5:"email";s:0:"";}log_time|i:1420501393;timeOnlineUpdated|i:1420501393;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('ahis0g4k71qgsqjsih2jv9qnd1', 1420497491, 'session_value|s:32:"046a0e2a8d29f2b23593dc6ed26aceb5";session_var|s:9:"e3c8d3f7f";mc|a:7:{s:4:"time";i:1420497491;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420497491;s:9:"id_member";i:0;s:2:"ip";s:12:"77.255.67.68";s:3:"ip2";s:14:"141.101.89.158";s:5:"email";s:0:"";}log_time|i:1420497491;timeOnlineUpdated|i:1420497491;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36";'),
('nlvpp82ru4fpu3uo6gqkafq3g7', 1420444393, 'session_value|s:32:"7e9761409d5c9158b765d0a4b31ff6dd";session_var|s:10:"d781f43f6f";mc|a:7:{s:4:"time";i:1420444392;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420444392;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:14:"199.27.133.190";s:5:"email";s:0:"";}log_time|i:1420444393;timeOnlineUpdated|i:1420444393;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:114:"Mozilla/5.0 (compatible; CloudFlare-AlwaysOnline/1.0; +http://www.cloudflare.com/always-online) AppleWebKit/534.34";'),
('bvkg8pr1rt5nqkcmrg2isulqh7', 1420444422, 'session_value|s:32:"016327d0b74622ce639036fca709d6e6";session_var|s:7:"b8d5427";mc|a:7:{s:4:"time";i:1420444392;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420444422;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:13:"173.245.56.61";s:5:"email";s:0:"";}log_time|i:1420444421;timeOnlineUpdated|i:1420444393;old_url|s:75:"http://forum.sgaming.pl/index.php?PHPSESSID=bvkg8pr1rt5nqkcmrg2isulqh7&wap2";USER_AGENT|s:114:"Mozilla/5.0 (compatible; CloudFlare-AlwaysOnline/1.0; +http://www.cloudflare.com/always-online) AppleWebKit/534.34";register_vv|a:5:{s:5:"count";i:1;s:6:"errors";i:0;s:8:"did_pass";b:0;s:1:"q";a:0:{}s:4:"code";s:6:"AWBGKT";}expanded_stats|a:1:{i:2015;a:1:{i:0;i:1;}}'),
('69ejudmkhidvvddlk3o1h19r06', 1420398509, 'session_value|s:32:"e1ccd94e9415bdebbe12d44def6366eb";session_var|s:7:"d3038c5";mc|a:7:{s:4:"time";i:1420393662;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420393708;s:9:"id_member";i:0;s:2:"ip";s:12:"178.43.18.28";s:3:"ip2";s:14:"141.101.88.143";s:5:"email";s:0:"";}log_time|i:1420393708;timeOnlineUpdated|i:1420393662;old_url|s:46:"http://forum.sgaming.pl/index.php?action=login";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36";register_vv|a:5:{s:5:"count";i:2;s:6:"errors";i:0;s:8:"did_pass";b:0;s:1:"q";a:0:{}s:4:"code";s:6:"XTFPCR";}registration_agreed|b:1;'),
('uob6sifsjrkj3fp4k9utvf1pr0', 1420399332, 'session_value|s:32:"257c6b400e89fb888fe9286e0fa4d73e";session_var|s:8:"c6990266";mc|a:7:{s:4:"time";i:1420399330;s:2:"id";s:2:"11";s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420399332;s:9:"id_member";s:2:"11";s:2:"ip";s:14:"134.249.36.184";s:3:"ip2";s:15:"108.162.254.140";s:5:"email";s:18:"vasalx@outlook.com";}log_time|i:1420399327;timeOnlineUpdated|i:1420399327;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";register_vv|a:5:{s:5:"count";i:3;s:6:"errors";i:0;s:8:"did_pass";b:1;s:1:"q";a:0:{}s:4:"code";s:6:"VMHWAB";}registration_agreed|b:1;just_registered|i:1;login_SMFCookie215|s:92:"a:4:{i:0;i:11;i:1;s:40:"b060cb14e83ff4fa41f5e8fb0a56bf3ac0a7e155";i:2;i:1420402930;i:3;i:0;}";id_msg_last_visit|s:1:"0";unread_messages|i:0;'),
('901uoipcphc3hukci5elfdpnn5', 1420408364, 'session_value|s:32:"bae36cfac637e239c88cf15acc512026";session_var|s:7:"fde1ac7";mc|a:7:{s:4:"time";i:1420408364;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420408364;s:9:"id_member";i:0;s:2:"ip";s:12:"78.8.123.136";s:3:"ip2";s:14:"141.101.89.155";s:5:"email";s:0:"";}log_time|i:1420408364;timeOnlineUpdated|i:1420408364;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:72:"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0";'),
('qai9vin20i2cn7u2hbsnugt0c4', 1420444391, 'session_value|s:32:"3961e036e3c612e573f85759612bf237";session_var|s:7:"e8a502f";mc|a:7:{s:4:"time";i:1420444391;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1420444391;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:14:"199.27.133.190";s:5:"email";s:0:"";}log_time|i:1420444391;timeOnlineUpdated|i:1420444391;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:60:"python-requests/2.4.3 CPython/2.7.3 Linux/3.14.18-cloudflare";');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_settings`
--

CREATE TABLE IF NOT EXISTS `forum_settings` (
  `variable` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_settings`
--

INSERT INTO `forum_settings` (`variable`, `value`) VALUES
('smfVersion', '2.0.9'),
('news', 'SMF - Just Installed!'),
('compactTopicPagesContiguous', '5'),
('compactTopicPagesEnable', '1'),
('enableStickyTopics', '1'),
('todayMod', '1'),
('karmaMode', '0'),
('karmaTimeRestrictAdmins', '1'),
('enablePreviousNext', '1'),
('pollMode', '1'),
('enableVBStyleLogin', '1'),
('enableCompressedOutput', '1'),
('karmaWaitTime', '1'),
('karmaMinPosts', '0'),
('karmaLabel', 'Karma:'),
('karmaSmiteLabel', '[smite]'),
('karmaApplaudLabel', '[applaud]'),
('attachmentSizeLimit', '128'),
('attachmentPostLimit', '192'),
('attachmentNumPerPostLimit', '4'),
('attachmentDirSizeLimit', '10240'),
('attachmentUploadDir', '/home/sites/forum.sgaming.pl/public_html/attachments'),
('attachmentExtensions', 'doc,gif,jpg,mpg,pdf,png,txt,zip'),
('attachmentCheckExtensions', '0'),
('attachmentShowImages', '1'),
('attachmentEnable', '1'),
('attachmentEncryptFilenames', '1'),
('attachmentThumbnails', '1'),
('attachmentThumbWidth', '150'),
('attachmentThumbHeight', '150'),
('censorIgnoreCase', '1'),
('mostOnline', '7'),
('mostOnlineToday', '1'),
('mostDate', '1417818197'),
('allow_disableAnnounce', '1'),
('trackStats', '1'),
('userLanguage', '1'),
('titlesEnable', '1'),
('topicSummaryPosts', '15'),
('enableErrorLogging', '1'),
('max_image_width', '0'),
('max_image_height', '0'),
('onlineEnable', '0'),
('cal_enabled', '0'),
('cal_maxyear', '2020'),
('cal_minyear', '2008'),
('cal_daysaslink', '0'),
('cal_defaultboard', ''),
('cal_showholidays', '1'),
('cal_showbdays', '1'),
('cal_showevents', '1'),
('cal_showweeknum', '0'),
('cal_maxspan', '7'),
('smtp_host', 'mailng.az.pl'),
('smtp_port', '25'),
('smtp_username', 'info@mail.sgaming.pl'),
('smtp_password', 'SzFkMW9MRTVsTVJy'),
('mail_type', '1'),
('timeLoadPageEnable', '0'),
('totalMembers', '12'),
('totalTopics', '0'),
('totalMessages', '0'),
('simpleSearch', '0'),
('censor_vulgar', ''),
('censor_proper', ''),
('enablePostHTML', '0'),
('theme_allow', '1'),
('theme_default', '1'),
('theme_guests', '4'),
('enableEmbeddedFlash', '0'),
('xmlnews_enable', '1'),
('xmlnews_maxlen', '255'),
('hotTopicPosts', '15'),
('hotTopicVeryPosts', '25'),
('registration_method', '0'),
('send_validation_onChange', '0'),
('send_welcomeEmail', '1'),
('allow_editDisplayName', '1'),
('allow_hideOnline', '1'),
('guest_hideContacts', '1'),
('spamWaitTime', '5'),
('pm_spam_settings', '10,5,20'),
('reserveWord', '0'),
('reserveCase', '1'),
('reserveUser', '1'),
('reserveName', '1'),
('reserveNames', 'Admin\nWebmaster\nGuest\nroot'),
('autoLinkUrls', '1'),
('banLastUpdated', '0'),
('smileys_dir', '/home/sites/forum.sgaming.pl/public_html/Smileys'),
('smileys_url', 'http://forum.sgaming.pl/Smileys'),
('avatar_directory', '/home/sites/forum.sgaming.pl/public_html/avatars'),
('avatar_url', 'http://forum.sgaming.pl/avatars'),
('avatar_max_height_external', '65'),
('avatar_max_width_external', '65'),
('avatar_action_too_large', 'option_html_resize'),
('avatar_max_height_upload', '65'),
('avatar_max_width_upload', '65'),
('avatar_resize_upload', '1'),
('avatar_download_png', '1'),
('failed_login_threshold', '3'),
('oldTopicDays', '120'),
('edit_wait_time', '90'),
('edit_disable_time', '0'),
('autoFixDatabase', '1'),
('allow_guestAccess', '1'),
('time_format', '%B %d, %Y, %I:%M:%S %p'),
('number_format', '1234.00'),
('enableBBC', '1'),
('max_messageLength', '20000'),
('signature_settings', '1,300,0,0,0,0,0,0:'),
('autoOptMaxOnline', '0'),
('defaultMaxMessages', '15'),
('defaultMaxTopics', '20'),
('defaultMaxMembers', '30'),
('enableParticipation', '1'),
('recycle_enable', '0'),
('recycle_board', '0'),
('maxMsgID', '0'),
('enableAllMessages', '0'),
('fixLongWords', '0'),
('knownThemes', '1,2,3,4'),
('who_enabled', '1'),
('time_offset', '0'),
('cookieTime', '60'),
('lastActive', '15'),
('smiley_sets_known', 'default,aaron,akyhne'),
('smiley_sets_names', 'Alienine''s Set\nAaron''s Set\nAkyhne''s Set'),
('smiley_sets_default', 'default'),
('cal_days_for_index', '7'),
('requireAgreement', '1'),
('unapprovedMembers', '0'),
('default_personal_text', ''),
('package_make_backups', '1'),
('databaseSession_enable', '1'),
('databaseSession_loose', '1'),
('databaseSession_lifetime', '2880'),
('search_cache_size', '50'),
('search_results_per_page', '30'),
('search_weight_frequency', '30'),
('search_weight_age', '25'),
('search_weight_length', '20'),
('search_weight_subject', '15'),
('search_weight_first_message', '10'),
('search_max_results', '1200'),
('search_floodcontrol_time', '5'),
('permission_enable_deny', '0'),
('permission_enable_postgroups', '0'),
('mail_next_send', '0'),
('mail_recent', '0000000000|0'),
('settings_updated', '1417628096'),
('next_task_time', '1420660800'),
('warning_settings', '1,20,0'),
('warning_watch', '10'),
('warning_moderate', '35'),
('warning_mute', '60'),
('admin_features', ''),
('last_mod_report_action', '0'),
('pruningOptions', '30,180,180,180,30,0'),
('cache_enable', '1'),
('reg_verification', '1'),
('visual_verification_type', '3'),
('enable_buddylist', '1'),
('birthday_email', 'karlbenson1'),
('dont_repeat_theme_core', '1'),
('dont_repeat_smileys_20', '1'),
('dont_repeat_buddylists', '1'),
('attachment_image_reencode', '1'),
('attachment_image_paranoid', '0'),
('attachment_thumb_png', '1'),
('avatar_reencode', '1'),
('avatar_paranoid', '0'),
('global_character_set', 'UTF-8'),
('default_timezone', 'Europe/Warsaw'),
('memberlist_updated', '1420541868'),
('latestMember', '16'),
('latestRealName', 'fautytaiMaL'),
('rand_seed', '43638174'),
('mostOnlineUpdated', '2015-01-06'),
('calendar_updated', '1417627298'),
('package_path', '/forum.sgaming.pl/public_html');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_smileys`
--

CREATE TABLE IF NOT EXISTS `forum_smileys` (
`id_smiley` smallint(5) unsigned NOT NULL,
  `code` varchar(30) NOT NULL DEFAULT '',
  `filename` varchar(48) NOT NULL DEFAULT '',
  `description` varchar(80) NOT NULL DEFAULT '',
  `smiley_row` tinyint(4) unsigned NOT NULL DEFAULT '0',
  `smiley_order` smallint(5) unsigned NOT NULL DEFAULT '0',
  `hidden` tinyint(4) unsigned NOT NULL DEFAULT '0'
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_smileys`
--

INSERT INTO `forum_smileys` (`id_smiley`, `code`, `filename`, `description`, `smiley_row`, `smiley_order`, `hidden`) VALUES
(1, ':)', 'smiley.gif', 'Smiley', 0, 0, 0),
(2, ';)', 'wink.gif', 'Wink', 0, 1, 0),
(3, ':D', 'cheesy.gif', 'Cheesy', 0, 2, 0),
(4, ';D', 'grin.gif', 'Grin', 0, 3, 0),
(5, '>:(', 'angry.gif', 'Angry', 0, 4, 0),
(6, ':(', 'sad.gif', 'Sad', 0, 5, 0),
(7, ':o', 'shocked.gif', 'Shocked', 0, 6, 0),
(8, '8)', 'cool.gif', 'Cool', 0, 7, 0),
(9, '???', 'huh.gif', 'Huh?', 0, 8, 0),
(10, '::)', 'rolleyes.gif', 'Roll Eyes', 0, 9, 0),
(11, ':P', 'tongue.gif', 'Tongue', 0, 10, 0),
(12, ':-[', 'embarrassed.gif', 'Embarrassed', 0, 11, 0),
(13, ':-X', 'lipsrsealed.gif', 'Lips Sealed', 0, 12, 0),
(14, ':-\\', 'undecided.gif', 'Undecided', 0, 13, 0),
(15, ':-*', 'kiss.gif', 'Kiss', 0, 14, 0),
(16, ':''(', 'cry.gif', 'Cry', 0, 15, 0),
(17, '>:D', 'evil.gif', 'Evil', 0, 16, 1),
(18, '^-^', 'azn.gif', 'Azn', 0, 17, 1),
(19, 'O0', 'afro.gif', 'Afro', 0, 18, 1),
(20, ':))', 'laugh.gif', 'Laugh', 0, 19, 1),
(21, 'C:-)', 'police.gif', 'Police', 0, 20, 1),
(22, 'O:-)', 'angel.gif', 'Angel', 0, 21, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_spiders`
--

CREATE TABLE IF NOT EXISTS `forum_spiders` (
`id_spider` smallint(5) unsigned NOT NULL,
  `spider_name` varchar(255) NOT NULL DEFAULT '',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `ip_info` varchar(255) NOT NULL DEFAULT ''
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_spiders`
--

INSERT INTO `forum_spiders` (`id_spider`, `spider_name`, `user_agent`, `ip_info`) VALUES
(1, 'Google', 'googlebot', ''),
(2, 'Yahoo!', 'slurp', ''),
(3, 'MSN', 'msnbot', ''),
(4, 'Google (Mobile)', 'Googlebot-Mobile', ''),
(5, 'Google (Image)', 'Googlebot-Image', ''),
(6, 'Google (AdSense)', 'Mediapartners-Google', ''),
(7, 'Google (Adwords)', 'AdsBot-Google', ''),
(8, 'Yahoo! (Mobile)', 'YahooSeeker/M1A1-R2D2', ''),
(9, 'Yahoo! (Image)', 'Yahoo-MMCrawler', ''),
(10, 'MSN (Mobile)', 'MSNBOT_Mobile', ''),
(11, 'MSN (Media)', 'msnbot-media', ''),
(12, 'Cuil', 'twiceler', ''),
(13, 'Ask', 'Teoma', ''),
(14, 'Baidu', 'Baiduspider', ''),
(15, 'Gigablast', 'Gigabot', ''),
(16, 'InternetArchive', 'ia_archiver-web.archive.org', ''),
(17, 'Alexa', 'ia_archiver', ''),
(18, 'Omgili', 'omgilibot', ''),
(19, 'EntireWeb', 'Speedy Spider', '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_subscriptions`
--

CREATE TABLE IF NOT EXISTS `forum_subscriptions` (
`id_subscribe` mediumint(8) unsigned NOT NULL,
  `name` varchar(60) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `cost` text NOT NULL,
  `length` varchar(6) NOT NULL DEFAULT '',
  `id_group` smallint(5) NOT NULL DEFAULT '0',
  `add_groups` varchar(40) NOT NULL DEFAULT '',
  `active` tinyint(3) NOT NULL DEFAULT '1',
  `repeatable` tinyint(3) NOT NULL DEFAULT '0',
  `allow_partial` tinyint(3) NOT NULL DEFAULT '0',
  `reminder` tinyint(3) NOT NULL DEFAULT '0',
  `email_complete` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_themes`
--

CREATE TABLE IF NOT EXISTS `forum_themes` (
  `id_member` mediumint(8) NOT NULL DEFAULT '0',
  `id_theme` tinyint(4) unsigned NOT NULL DEFAULT '1',
  `variable` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_themes`
--

INSERT INTO `forum_themes` (`id_member`, `id_theme`, `variable`, `value`) VALUES
(0, 1, 'name', 'SMF Default Theme - Curve'),
(0, 1, 'theme_url', 'http://forum.sgaming.pl/Themes/default'),
(0, 1, 'images_url', 'http://forum.sgaming.pl/Themes/default/images'),
(0, 1, 'theme_dir', '/home/sites/forum.sgaming.pl/public_html/Themes/default'),
(0, 1, 'show_bbc', '1'),
(0, 1, 'show_latest_member', '1'),
(0, 1, 'show_modify', '1'),
(0, 1, 'show_user_images', '1'),
(0, 1, 'show_blurb', '1'),
(0, 1, 'show_gender', '0'),
(0, 1, 'show_newsfader', '0'),
(0, 1, 'number_recent_posts', '0'),
(0, 1, 'show_member_bar', '1'),
(0, 1, 'linktree_link', '1'),
(0, 1, 'show_profile_buttons', '1'),
(0, 1, 'show_mark_read', '1'),
(0, 1, 'show_stats_index', '1'),
(0, 1, 'linktree_inline', '0'),
(0, 1, 'show_board_desc', '1'),
(0, 1, 'newsfader_time', '5000'),
(0, 1, 'allow_no_censored', '0'),
(0, 1, 'additional_options_collapsable', '1'),
(0, 1, 'use_image_buttons', '1'),
(0, 1, 'enable_news', '1'),
(0, 1, 'forum_width', '90%'),
(0, 2, 'name', 'Core Theme'),
(0, 2, 'theme_url', 'http://forum.sgaming.pl/Themes/core'),
(0, 2, 'images_url', 'http://forum.sgaming.pl/Themes/core/images'),
(0, 2, 'theme_dir', '/home/sites/forum.sgaming.pl/public_html/Themes/core'),
(-1, 1, 'display_quick_reply', '1'),
(-1, 1, 'posts_apply_ignore_list', '1'),
(0, 3, 'theme_url', 'http://forum.sgaming.pl/Themes/aldo'),
(0, 3, 'images_url', 'http://forum.sgaming.pl/Themes/aldo/images'),
(0, 3, 'theme_dir', '/home/sites/forum.sgaming.pl/public_html/Themes/aldo'),
(0, 3, 'name', 'Aldo'),
(0, 3, 'theme_layers', 'html,body'),
(0, 3, 'theme_templates', 'index'),
(2, 1, 'display_quick_reply', '1'),
(1, 3, 'collapse_header_ic', '0'),
(1, 1, 'admin_preferences', 'a:1:{s:2:"pv";s:7:"classic";}'),
(3, 1, 'display_quick_reply', '1'),
(4, 1, 'display_quick_reply', '1'),
(5, 1, 'display_quick_reply', '1'),
(6, 1, 'display_quick_reply', '1'),
(7, 1, 'display_quick_reply', '1'),
(8, 1, 'display_quick_reply', '1'),
(9, 1, 'display_quick_reply', '1'),
(11, 1, 'display_quick_reply', '1'),
(15, 1, 'display_quick_reply', '1'),
(16, 1, 'display_quick_reply', '1'),
(0, 4, 'theme_url', 'http://forum.sgaming.pl/Themes/mysticjade_20a'),
(0, 4, 'images_url', 'http://forum.sgaming.pl/Themes/mysticjade_20a/images'),
(0, 4, 'theme_dir', '/home/sites/forum.sgaming.pl/public_html/Themes/mysticjade_20a'),
(0, 4, 'name', 'MysticJade'),
(0, 4, 'theme_layers', 'html,body'),
(0, 4, 'theme_templates', 'index');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `forum_topics`
--

CREATE TABLE IF NOT EXISTS `forum_topics` (
`id_topic` mediumint(8) unsigned NOT NULL,
  `is_sticky` tinyint(4) NOT NULL DEFAULT '0',
  `id_board` smallint(5) unsigned NOT NULL DEFAULT '0',
  `id_first_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_last_msg` int(10) unsigned NOT NULL DEFAULT '0',
  `id_member_started` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_member_updated` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_poll` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `id_previous_board` smallint(5) NOT NULL DEFAULT '0',
  `id_previous_topic` mediumint(8) NOT NULL DEFAULT '0',
  `num_replies` int(10) unsigned NOT NULL DEFAULT '0',
  `num_views` int(10) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(4) NOT NULL DEFAULT '0',
  `unapproved_posts` smallint(5) NOT NULL DEFAULT '0',
  `approved` tinyint(3) NOT NULL DEFAULT '1'
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
  `dob` datetime NOT NULL,
  `activated` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_characters`
--

INSERT INTO `_characters` (`ID`, `memberID`, `name`, `lastname`, `faceCode`, `hp`, `skin`, `x`, `y`, `z`, `angle`, `dimension`, `interior`, `money`, `bwTime`, `ajTime`, `onlineTime`, `afkTime`, `sex`, `inGame`, `lastVisit`, `blocked`, `hide`, `dob`, `activated`) VALUES
(2, 1, 'Jeremy', 'Simons', 'ASDXDD', 50, 288, 1195.25, -1312.03, 13.3984, 340.441, 0, 0, 5000, 0, 0, 29410, 36968, 1, 0, 1420674385, 0, 0, '0000-00-00 00:00:00', 0),
(16, 6, 'Frederick', 'Lorenzo', 'ASR41A', 40, 60, 1365.68, -1340.15, 15.8304, 162.971, 0, 0, 0, 0, 0, 5039, 5654, 1, 0, 1420658965, 0, 0, '0000-00-00 00:00:00', 0),
(17, 4, 'Fernando', 'Rubio', '478XT3', 20, 277, 1214.31, -1339.2, 13.5706, 208.691, 0, 0, 0, 0, 0, 9490, 9917, 1, 0, 1420673709, 0, 0, '0000-00-00 00:00:00', 0),
(18, 3, 'John', 'Cavallo', 'ASR16W', 50, 0, 1847.41, -1488.35, 12.982, 348.176, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(19, 5, 'Piotrek', 'Piotrek', '541WUS', 95, 60, 219.874, 219.992, -0.425077, 71.0195, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(20, 14, 'Envoyer', 'Envoyer', 'AS8AT2', 100, 280, 1535.9, -1669.42, 13.3828, 154.857, 0, 0, 0, 0, 0, 218, 94, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(21, 8, 'Msk', 'Testowy', 'MSKONE', 100, 295, 111, 244, 231, 22, 0, 0, 100000, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(22, 8, 'Msk2', 'Testowy', 'MSKTWO', 100, 295, 111, 244, 231, 22, 0, 0, 99999, 0, 0, 0, 0, 0, 0, 0, 1, 0, '0000-00-00 00:00:00', 0),
(23, 8, 'Msk3', 'Testowy', 'MSKTHR', 88, 295, 111, 244, 231, 22, 0, 0, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_deposite`
--

INSERT INTO `_deposite` (`ID`, `intID`, `name`, `stock`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(1, 1, 'Desert Eagle', 200, 1, 24, 50, '0', 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doors`
--

INSERT INTO `_doors` (`ID`, `name`, `ownerType`, `owner`, `dimension`) VALUES
(1, 'Los Santos Police Department - Główny Interior', 2, 1, 1),
(5, 'All Saints General Hospital', 2, 1, 2);

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doorsPickup`
--

INSERT INTO `_doorsPickup` (`ID`, `parentID`, `name`, `inX`, `inY`, `inZ`, `outX`, `outY`, `outZ`, `inDim`, `outDim`, `inInt`, `outInt`, `outModel`, `inModel`, `inAngle`, `outAngle`, `locked`) VALUES
(1, 1, 'Los Santos Police Department', 288.85, 168.428, 1007.17, 1554.61, -1675.58, 16.2, 1, 0, 3, 0, 1247, 1318, 3.97986, 90, 0),
(7, 5, 'Drzwi do szpitala', 1194.41, -1325.02, 13.3984, 1172.77, -1323.86, 15.4009, 2, 0, 0, 0, 1239, 1318, 268.386, 268.386, 0);

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
(2, 'AW871A', 'Mateusz Rubik'),
(2, 'JFV2ZW', 'Kaizuś'),
(13, 'ASDXDD', 'Kubasek'),
(11, 'ASDXDD', 'kubas1'),
(2, '64A1VT', 'Szychuś'),
(2, 'ASR41A', 'Kaizini'),
(16, 'ASDXDD', 'Kubasek Laggerek'),
(2, '478XT3', 'Rubił'),
(17, 'ASR41A', 'kaizi'),
(16, '478XT3', 'Rubiczek Dupiczek.'),
(17, 'ASDXDD', 'kuba Kubas'),
(2, 'ASR16W', 'Szychałe');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups`
--

CREATE TABLE IF NOT EXISTS `_groups` (
`ID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `tag` varchar(4) NOT NULL,
  `r` smallint(3) NOT NULL,
  `g` smallint(3) NOT NULL,
  `b` smallint(3) NOT NULL,
  `orderType` int(11) NOT NULL,
  `perm` longtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups`
--

INSERT INTO `_groups` (`ID`, `name`, `tag`, `r`, `g`, `b`, `orderType`, `perm`) VALUES
(1, 'Los Santos Police Department', 'LSPD', 44, 88, 232, 1, '');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups_members`
--

CREATE TABLE IF NOT EXISTS `_groups_members` (
`ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `rankID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_members`
--

INSERT INTO `_groups_members` (`ID`, `userID`, `rankID`, `groupID`) VALUES
(1, 2, 1, 1),
(2, 11, 2, 1),
(6, 13, 2, 1),
(7, 10, 2, 1),
(8, 16, 2, 1),
(9, 17, 2, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups_ranks`
--

CREATE TABLE IF NOT EXISTS `_groups_ranks` (
`ID` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `groupID` int(11) NOT NULL,
  `defaultRank` tinyint(1) NOT NULL,
  `perms` longtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_ranks`
--

INSERT INTO `_groups_ranks` (`ID`, `name`, `groupID`, `defaultRank`, `perms`) VALUES
(1, 'Ranga z liderem', 1, 0, '[{"leader": 1, "vehicles": 1, "doors": 1, "oocchat": 1, "icchat": 1}]'),
(2, 'Ranga bez lidera', 1, 1, '[{"leader": 0, "vehicles": 1, "doors": 1, "oocchat": 1, "icchat": 1}]');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_items`
--

CREATE TABLE IF NOT EXISTS `_items` (
`ID` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `ownerType` int(11) NOT NULL COMMENT '1 - player, 2 - veh_int, 3 - veh_trunk, 4 - door',
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_items`
--

INSERT INTO `_items` (`ID`, `name`, `ownerType`, `owner`, `type`, `slotID`, `val1`, `val2`, `val3`, `volume`, `created`, `lastUsed`, `lastUsedID`, `used`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`) VALUES
(2, 'Bean Bag', 1, 19, 14, 0, 25, 4831, '41568SRG', 2, 1419967650, 1420141502, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Ubranko', 1, 16, 3, 0, 60, 0, '0', 2, 1419969021, 1419969112, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(5, 'Ubranie strażaka', 1, 17, 3, 0, 277, 0, '0', 2, 1419975492, 1419980576, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(6, 'Ubranie LSPD', 4, 1, 3, 0, 288, 0, '0', 2, 1419975858, 1419980549, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(8, 'Bean Bag', 1, 2, 14, 0, 25, 4710, 'KN6A28H', 2, 1419980836, 1420673602, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(9, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980836, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(10, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980836, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(11, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980837, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(14, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980838, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 'Bean Bag', 4, 1, 14, 0, 25, 5000, 'KN6A28H', 2, 1419980839, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, 'Bean Bag', 1, 16, 14, 0, 25, 4893, 'KN6A28H', 2, 1419980839, 1420658840, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(18, 'Kajdanki', 1, 17, 18, 0, 0, 0, '0', 2, 1419981654, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 'M4A1', 1, 2, 1, 0, 31, 4587, 'JANWT52', 3, 1419983092, 1420403180, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(20, 'Deagle', 1, 17, 1, 0, 24, 268, '0', 2, 1419986203, 1420673562, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(21, 'Kaizi Kaizi', 1, 16, 1, 0, 35, 1901, 'Kaizi', 1, 1419986490, 1420413193, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(22, 'Mauser', 1, 4, 1, 0, 24, 60, '0', 10, 1419987062, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(23, 'Kevlar', 1, 2, 5, 0, 0, 0, '0', 2, 1420369492, 1420414302, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 'Beretta 92FS', 1, 2, 1, 0, 24, 582, 'ASKAW5226', 2, 1420413273, 1420658840, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 'Jedzenie', 1, 2, 6, 0, 100, 0, '0', 1, 1420413335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 'Jedzenie', 1, 2, 6, 0, 100, 0, '0', 1, 1420413335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(28, 'Jedzenie', 1, 2, 6, 0, 100, 0, '0', 1, 1420413335, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
  `damage` mediumtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_vehicles`
--

INSERT INTO `_vehicles` (`ID`, `name`, `ownerType`, `ownerID`, `c1r`, `c1g`, `c1b`, `c2r`, `c2g`, `c2b`, `model`, `hp`, `spawned`, `locked`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `v1`, `v2`, `fuel`, `damage`) VALUES
(1, 'Ambulance', 2, 1, 255, 255, 255, 59, 94, 207, 416, 1000, 1, 0, 1531.27, -1666.13, 13.3828, 0, 0, -83.5537, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]'),
(2, 'Police LS', 2, 1, 0, 0, 0, 255, 255, 255, 596, 1000, 1, 0, 1536.43, -1682.35, 13.3828, 0, 0, 113.198, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `forum_admin_info_files`
--
ALTER TABLE `forum_admin_info_files`
 ADD PRIMARY KEY (`id_file`), ADD KEY `filename` (`filename`(30));

--
-- Indexes for table `forum_attachments`
--
ALTER TABLE `forum_attachments`
 ADD PRIMARY KEY (`id_attach`), ADD UNIQUE KEY `id_member` (`id_member`,`id_attach`), ADD KEY `id_msg` (`id_msg`), ADD KEY `attachment_type` (`attachment_type`);

--
-- Indexes for table `forum_ban_groups`
--
ALTER TABLE `forum_ban_groups`
 ADD PRIMARY KEY (`id_ban_group`);

--
-- Indexes for table `forum_ban_items`
--
ALTER TABLE `forum_ban_items`
 ADD PRIMARY KEY (`id_ban`), ADD KEY `id_ban_group` (`id_ban_group`);

--
-- Indexes for table `forum_boards`
--
ALTER TABLE `forum_boards`
 ADD PRIMARY KEY (`id_board`), ADD UNIQUE KEY `categories` (`id_cat`,`id_board`), ADD KEY `id_parent` (`id_parent`), ADD KEY `id_msg_updated` (`id_msg_updated`), ADD KEY `member_groups` (`member_groups`(48));

--
-- Indexes for table `forum_board_permissions`
--
ALTER TABLE `forum_board_permissions`
 ADD PRIMARY KEY (`id_group`,`id_profile`,`permission`);

--
-- Indexes for table `forum_calendar`
--
ALTER TABLE `forum_calendar`
 ADD PRIMARY KEY (`id_event`), ADD KEY `start_date` (`start_date`), ADD KEY `end_date` (`end_date`), ADD KEY `topic` (`id_topic`,`id_member`);

--
-- Indexes for table `forum_calendar_holidays`
--
ALTER TABLE `forum_calendar_holidays`
 ADD PRIMARY KEY (`id_holiday`), ADD KEY `event_date` (`event_date`);

--
-- Indexes for table `forum_categories`
--
ALTER TABLE `forum_categories`
 ADD PRIMARY KEY (`id_cat`);

--
-- Indexes for table `forum_collapsed_categories`
--
ALTER TABLE `forum_collapsed_categories`
 ADD PRIMARY KEY (`id_cat`,`id_member`);

--
-- Indexes for table `forum_custom_fields`
--
ALTER TABLE `forum_custom_fields`
 ADD PRIMARY KEY (`id_field`), ADD UNIQUE KEY `col_name` (`col_name`);

--
-- Indexes for table `forum_group_moderators`
--
ALTER TABLE `forum_group_moderators`
 ADD PRIMARY KEY (`id_group`,`id_member`);

--
-- Indexes for table `forum_log_actions`
--
ALTER TABLE `forum_log_actions`
 ADD PRIMARY KEY (`id_action`), ADD KEY `id_log` (`id_log`), ADD KEY `log_time` (`log_time`), ADD KEY `id_member` (`id_member`), ADD KEY `id_board` (`id_board`), ADD KEY `id_msg` (`id_msg`);

--
-- Indexes for table `forum_log_activity`
--
ALTER TABLE `forum_log_activity`
 ADD PRIMARY KEY (`date`), ADD KEY `most_on` (`most_on`);

--
-- Indexes for table `forum_log_banned`
--
ALTER TABLE `forum_log_banned`
 ADD PRIMARY KEY (`id_ban_log`), ADD KEY `log_time` (`log_time`);

--
-- Indexes for table `forum_log_boards`
--
ALTER TABLE `forum_log_boards`
 ADD PRIMARY KEY (`id_member`,`id_board`);

--
-- Indexes for table `forum_log_comments`
--
ALTER TABLE `forum_log_comments`
 ADD PRIMARY KEY (`id_comment`), ADD KEY `id_recipient` (`id_recipient`), ADD KEY `log_time` (`log_time`), ADD KEY `comment_type` (`comment_type`);

--
-- Indexes for table `forum_log_errors`
--
ALTER TABLE `forum_log_errors`
 ADD PRIMARY KEY (`id_error`), ADD KEY `log_time` (`log_time`), ADD KEY `id_member` (`id_member`), ADD KEY `ip` (`ip`);

--
-- Indexes for table `forum_log_floodcontrol`
--
ALTER TABLE `forum_log_floodcontrol`
 ADD PRIMARY KEY (`ip`,`log_type`);

--
-- Indexes for table `forum_log_group_requests`
--
ALTER TABLE `forum_log_group_requests`
 ADD PRIMARY KEY (`id_request`), ADD UNIQUE KEY `id_member` (`id_member`,`id_group`);

--
-- Indexes for table `forum_log_karma`
--
ALTER TABLE `forum_log_karma`
 ADD PRIMARY KEY (`id_target`,`id_executor`), ADD KEY `log_time` (`log_time`);

--
-- Indexes for table `forum_log_mark_read`
--
ALTER TABLE `forum_log_mark_read`
 ADD PRIMARY KEY (`id_member`,`id_board`);

--
-- Indexes for table `forum_log_member_notices`
--
ALTER TABLE `forum_log_member_notices`
 ADD PRIMARY KEY (`id_notice`);

--
-- Indexes for table `forum_log_notify`
--
ALTER TABLE `forum_log_notify`
 ADD PRIMARY KEY (`id_member`,`id_topic`,`id_board`), ADD KEY `id_topic` (`id_topic`,`id_member`);

--
-- Indexes for table `forum_log_online`
--
ALTER TABLE `forum_log_online`
 ADD PRIMARY KEY (`session`), ADD KEY `log_time` (`log_time`), ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `forum_log_packages`
--
ALTER TABLE `forum_log_packages`
 ADD PRIMARY KEY (`id_install`), ADD KEY `filename` (`filename`(15));

--
-- Indexes for table `forum_log_polls`
--
ALTER TABLE `forum_log_polls`
 ADD KEY `id_poll` (`id_poll`,`id_member`,`id_choice`);

--
-- Indexes for table `forum_log_reported`
--
ALTER TABLE `forum_log_reported`
 ADD PRIMARY KEY (`id_report`), ADD KEY `id_member` (`id_member`), ADD KEY `id_topic` (`id_topic`), ADD KEY `closed` (`closed`), ADD KEY `time_started` (`time_started`), ADD KEY `id_msg` (`id_msg`);

--
-- Indexes for table `forum_log_reported_comments`
--
ALTER TABLE `forum_log_reported_comments`
 ADD PRIMARY KEY (`id_comment`), ADD KEY `id_report` (`id_report`), ADD KEY `id_member` (`id_member`), ADD KEY `time_sent` (`time_sent`);

--
-- Indexes for table `forum_log_scheduled_tasks`
--
ALTER TABLE `forum_log_scheduled_tasks`
 ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `forum_log_search_messages`
--
ALTER TABLE `forum_log_search_messages`
 ADD PRIMARY KEY (`id_search`,`id_msg`);

--
-- Indexes for table `forum_log_search_results`
--
ALTER TABLE `forum_log_search_results`
 ADD PRIMARY KEY (`id_search`,`id_topic`);

--
-- Indexes for table `forum_log_search_subjects`
--
ALTER TABLE `forum_log_search_subjects`
 ADD PRIMARY KEY (`word`,`id_topic`), ADD KEY `id_topic` (`id_topic`);

--
-- Indexes for table `forum_log_search_topics`
--
ALTER TABLE `forum_log_search_topics`
 ADD PRIMARY KEY (`id_search`,`id_topic`);

--
-- Indexes for table `forum_log_spider_hits`
--
ALTER TABLE `forum_log_spider_hits`
 ADD PRIMARY KEY (`id_hit`), ADD KEY `id_spider` (`id_spider`), ADD KEY `log_time` (`log_time`), ADD KEY `processed` (`processed`);

--
-- Indexes for table `forum_log_spider_stats`
--
ALTER TABLE `forum_log_spider_stats`
 ADD PRIMARY KEY (`stat_date`,`id_spider`);

--
-- Indexes for table `forum_log_subscribed`
--
ALTER TABLE `forum_log_subscribed`
 ADD PRIMARY KEY (`id_sublog`), ADD UNIQUE KEY `id_subscribe` (`id_subscribe`,`id_member`), ADD KEY `end_time` (`end_time`), ADD KEY `reminder_sent` (`reminder_sent`), ADD KEY `payments_pending` (`payments_pending`), ADD KEY `status` (`status`), ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `forum_log_topics`
--
ALTER TABLE `forum_log_topics`
 ADD PRIMARY KEY (`id_member`,`id_topic`), ADD KEY `id_topic` (`id_topic`);

--
-- Indexes for table `forum_mail_queue`
--
ALTER TABLE `forum_mail_queue`
 ADD PRIMARY KEY (`id_mail`), ADD KEY `time_sent` (`time_sent`), ADD KEY `mail_priority` (`priority`,`id_mail`);

--
-- Indexes for table `forum_membergroups`
--
ALTER TABLE `forum_membergroups`
 ADD PRIMARY KEY (`id_group`), ADD KEY `min_posts` (`min_posts`);

--
-- Indexes for table `forum_members`
--
ALTER TABLE `forum_members`
 ADD PRIMARY KEY (`id_member`), ADD KEY `member_name` (`member_name`), ADD KEY `real_name` (`real_name`), ADD KEY `date_registered` (`date_registered`), ADD KEY `id_group` (`id_group`), ADD KEY `birthdate` (`birthdate`), ADD KEY `posts` (`posts`), ADD KEY `last_login` (`last_login`), ADD KEY `lngfile` (`lngfile`(30)), ADD KEY `id_post_group` (`id_post_group`), ADD KEY `warning` (`warning`), ADD KEY `total_time_logged_in` (`total_time_logged_in`), ADD KEY `id_theme` (`id_theme`);

--
-- Indexes for table `forum_messages`
--
ALTER TABLE `forum_messages`
 ADD PRIMARY KEY (`id_msg`), ADD UNIQUE KEY `topic` (`id_topic`,`id_msg`), ADD UNIQUE KEY `id_board` (`id_board`,`id_msg`), ADD UNIQUE KEY `id_member` (`id_member`,`id_msg`), ADD KEY `approved` (`approved`), ADD KEY `ip_index` (`poster_ip`(15),`id_topic`), ADD KEY `participation` (`id_member`,`id_topic`), ADD KEY `show_posts` (`id_member`,`id_board`), ADD KEY `id_topic` (`id_topic`), ADD KEY `id_member_msg` (`id_member`,`approved`,`id_msg`), ADD KEY `current_topic` (`id_topic`,`id_msg`,`id_member`,`approved`), ADD KEY `related_ip` (`id_member`,`poster_ip`,`id_msg`);

--
-- Indexes for table `forum_message_icons`
--
ALTER TABLE `forum_message_icons`
 ADD PRIMARY KEY (`id_icon`), ADD KEY `id_board` (`id_board`);

--
-- Indexes for table `forum_moderators`
--
ALTER TABLE `forum_moderators`
 ADD PRIMARY KEY (`id_board`,`id_member`);

--
-- Indexes for table `forum_openid_assoc`
--
ALTER TABLE `forum_openid_assoc`
 ADD PRIMARY KEY (`server_url`(125),`handle`(125)), ADD KEY `expires` (`expires`);

--
-- Indexes for table `forum_package_servers`
--
ALTER TABLE `forum_package_servers`
 ADD PRIMARY KEY (`id_server`);

--
-- Indexes for table `forum_permissions`
--
ALTER TABLE `forum_permissions`
 ADD PRIMARY KEY (`id_group`,`permission`);

--
-- Indexes for table `forum_permission_profiles`
--
ALTER TABLE `forum_permission_profiles`
 ADD PRIMARY KEY (`id_profile`);

--
-- Indexes for table `forum_personal_messages`
--
ALTER TABLE `forum_personal_messages`
 ADD PRIMARY KEY (`id_pm`), ADD KEY `id_member` (`id_member_from`,`deleted_by_sender`), ADD KEY `msgtime` (`msgtime`), ADD KEY `id_pm_head` (`id_pm_head`);

--
-- Indexes for table `forum_pm_recipients`
--
ALTER TABLE `forum_pm_recipients`
 ADD PRIMARY KEY (`id_pm`,`id_member`), ADD UNIQUE KEY `id_member` (`id_member`,`deleted`,`id_pm`);

--
-- Indexes for table `forum_pm_rules`
--
ALTER TABLE `forum_pm_rules`
 ADD PRIMARY KEY (`id_rule`), ADD KEY `id_member` (`id_member`), ADD KEY `delete_pm` (`delete_pm`);

--
-- Indexes for table `forum_polls`
--
ALTER TABLE `forum_polls`
 ADD PRIMARY KEY (`id_poll`);

--
-- Indexes for table `forum_poll_choices`
--
ALTER TABLE `forum_poll_choices`
 ADD PRIMARY KEY (`id_poll`,`id_choice`);

--
-- Indexes for table `forum_scheduled_tasks`
--
ALTER TABLE `forum_scheduled_tasks`
 ADD PRIMARY KEY (`id_task`), ADD UNIQUE KEY `task` (`task`), ADD KEY `next_time` (`next_time`), ADD KEY `disabled` (`disabled`);

--
-- Indexes for table `forum_sessions`
--
ALTER TABLE `forum_sessions`
 ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `forum_settings`
--
ALTER TABLE `forum_settings`
 ADD PRIMARY KEY (`variable`(30));

--
-- Indexes for table `forum_smileys`
--
ALTER TABLE `forum_smileys`
 ADD PRIMARY KEY (`id_smiley`);

--
-- Indexes for table `forum_spiders`
--
ALTER TABLE `forum_spiders`
 ADD PRIMARY KEY (`id_spider`);

--
-- Indexes for table `forum_subscriptions`
--
ALTER TABLE `forum_subscriptions`
 ADD PRIMARY KEY (`id_subscribe`), ADD KEY `active` (`active`);

--
-- Indexes for table `forum_themes`
--
ALTER TABLE `forum_themes`
 ADD PRIMARY KEY (`id_theme`,`id_member`,`variable`(30)), ADD KEY `id_member` (`id_member`);

--
-- Indexes for table `forum_topics`
--
ALTER TABLE `forum_topics`
 ADD PRIMARY KEY (`id_topic`), ADD UNIQUE KEY `last_message` (`id_last_msg`,`id_board`), ADD UNIQUE KEY `first_message` (`id_first_msg`,`id_board`), ADD UNIQUE KEY `poll` (`id_poll`,`id_topic`), ADD KEY `is_sticky` (`is_sticky`), ADD KEY `approved` (`approved`), ADD KEY `id_board` (`id_board`), ADD KEY `member_started` (`id_member_started`,`id_board`), ADD KEY `last_message_sticky` (`id_board`,`is_sticky`,`id_last_msg`), ADD KEY `board_news` (`id_board`,`id_first_msg`);

--
-- Indexes for table `_characters`
--
ALTER TABLE `_characters`
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
-- Indexes for table `_items`
--
ALTER TABLE `_items`
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
-- AUTO_INCREMENT dla tabeli `forum_admin_info_files`
--
ALTER TABLE `forum_admin_info_files`
MODIFY `id_file` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla tabeli `forum_attachments`
--
ALTER TABLE `forum_attachments`
MODIFY `id_attach` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_ban_groups`
--
ALTER TABLE `forum_ban_groups`
MODIFY `id_ban_group` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_ban_items`
--
ALTER TABLE `forum_ban_items`
MODIFY `id_ban` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_boards`
--
ALTER TABLE `forum_boards`
MODIFY `id_board` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `forum_calendar`
--
ALTER TABLE `forum_calendar`
MODIFY `id_event` smallint(5) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_calendar_holidays`
--
ALTER TABLE `forum_calendar_holidays`
MODIFY `id_holiday` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=116;
--
-- AUTO_INCREMENT dla tabeli `forum_categories`
--
ALTER TABLE `forum_categories`
MODIFY `id_cat` tinyint(4) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `forum_custom_fields`
--
ALTER TABLE `forum_custom_fields`
MODIFY `id_field` smallint(5) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_actions`
--
ALTER TABLE `forum_log_actions`
MODIFY `id_action` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_banned`
--
ALTER TABLE `forum_log_banned`
MODIFY `id_ban_log` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_comments`
--
ALTER TABLE `forum_log_comments`
MODIFY `id_comment` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_errors`
--
ALTER TABLE `forum_log_errors`
MODIFY `id_error` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT dla tabeli `forum_log_group_requests`
--
ALTER TABLE `forum_log_group_requests`
MODIFY `id_request` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_member_notices`
--
ALTER TABLE `forum_log_member_notices`
MODIFY `id_notice` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_packages`
--
ALTER TABLE `forum_log_packages`
MODIFY `id_install` int(10) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_reported`
--
ALTER TABLE `forum_log_reported`
MODIFY `id_report` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_reported_comments`
--
ALTER TABLE `forum_log_reported_comments`
MODIFY `id_comment` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_scheduled_tasks`
--
ALTER TABLE `forum_log_scheduled_tasks`
MODIFY `id_log` mediumint(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=75;
--
-- AUTO_INCREMENT dla tabeli `forum_log_spider_hits`
--
ALTER TABLE `forum_log_spider_hits`
MODIFY `id_hit` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_log_subscribed`
--
ALTER TABLE `forum_log_subscribed`
MODIFY `id_sublog` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_mail_queue`
--
ALTER TABLE `forum_mail_queue`
MODIFY `id_mail` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_membergroups`
--
ALTER TABLE `forum_membergroups`
MODIFY `id_group` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT dla tabeli `forum_members`
--
ALTER TABLE `forum_members`
MODIFY `id_member` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT dla tabeli `forum_messages`
--
ALTER TABLE `forum_messages`
MODIFY `id_msg` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT dla tabeli `forum_message_icons`
--
ALTER TABLE `forum_message_icons`
MODIFY `id_icon` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT dla tabeli `forum_package_servers`
--
ALTER TABLE `forum_package_servers`
MODIFY `id_server` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `forum_permission_profiles`
--
ALTER TABLE `forum_permission_profiles`
MODIFY `id_profile` smallint(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT dla tabeli `forum_personal_messages`
--
ALTER TABLE `forum_personal_messages`
MODIFY `id_pm` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_pm_rules`
--
ALTER TABLE `forum_pm_rules`
MODIFY `id_rule` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_polls`
--
ALTER TABLE `forum_polls`
MODIFY `id_poll` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_scheduled_tasks`
--
ALTER TABLE `forum_scheduled_tasks`
MODIFY `id_task` smallint(5) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT dla tabeli `forum_smileys`
--
ALTER TABLE `forum_smileys`
MODIFY `id_smiley` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT dla tabeli `forum_spiders`
--
ALTER TABLE `forum_spiders`
MODIFY `id_spider` smallint(5) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT dla tabeli `forum_subscriptions`
--
ALTER TABLE `forum_subscriptions`
MODIFY `id_subscribe` mediumint(8) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `forum_topics`
--
ALTER TABLE `forum_topics`
MODIFY `id_topic` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_characters`
--
ALTER TABLE `_characters`
MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID postaci',AUTO_INCREMENT=24;
--
-- AUTO_INCREMENT dla tabeli `_deposite`
--
ALTER TABLE `_deposite`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_doors`
--
ALTER TABLE `_doors`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT dla tabeli `_doorsPickup`
--
ALTER TABLE `_doorsPickup`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla tabeli `_groups`
--
ALTER TABLE `_groups`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_groups_members`
--
ALTER TABLE `_groups_members`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT dla tabeli `_groups_ranks`
--
ALTER TABLE `_groups_ranks`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_items`
--
ALTER TABLE `_items`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT dla tabeli `_vehicles`
--
ALTER TABLE `_vehicles`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
