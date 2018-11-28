 -- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 10.0.0.152
-- Czas generowania: 25 Sty 2015, 00:12
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
(4, 'latest-packages.js', '/smf/', 'language=%1$s&version=%3$s', 'var actionurl = ''?action=admin;area=packages;sa=download;get;package='';if (typeof(window.smfForum_sessionvar) == "undefined")\n	window.smfForum_sessionvar = ''sesc'';\n\nif (typeof(window.smfVersion) != "undefined")\n{\n	var version = window.smfVersion;\n\n	// We might need this...\n	var smf_modificationInfo = {};\n	\n	switch (version)\n	{\n		case "SMF 1.0":\n			window.smfLatestPackages = ''As was inevitable, a few small mistakes have been found in 1.0.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-1_update.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.1":\n			window.smfLatestPackages = ''A few problems have been found in the package manager\\''s modification code, among a few other issues.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-2_update.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.2":\n			window.smfLatestPackages = ''A problem has been found in the system that sends critical database messages.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-3_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.3":\n			window.smfLatestPackages = ''A few bugs have been fixed since SMF 1.0.3, and a problem with parsing nested BBC tags addressed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-4_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.4":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.4.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-5_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.5":\n			window.smfLatestPackages = ''A bbc security issue has been identified in SMF 1.0.5.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.6":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.6.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.7":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.7.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-8_package.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.8":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.8.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1-0-9_1-1-rc3-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.9":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.9.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-0-10_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.10":\n			window.smfLatestPackages = ''A security issue has been identified in SMF 1.0.10.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.3_1.0.11.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.11":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.11 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.12":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.12 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.13":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.13 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.14_1.1.6.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.14.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.14":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.14. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.15_1.1.7.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.15.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.15":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.15. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.16_1.1.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.16.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.16":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.16. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.17.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.17":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.17. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.18":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.18. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.19_1.1.11.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.19.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.19":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.19. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.20_1.1.12.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.20.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.20":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.20. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.21_1.1.13.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.21.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.21":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.0.21. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.22_1.1.16.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.22.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.22":\n			window.smfLatestPackages = ''A security vulnerability has been identified in SMF 1.0.22. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.23_1.1.17.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.0.23.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.0.23":\n			window.smfLatestPackages = ''SMF 1.0 was released to the world in December 2004 and has been supported for more than eight years. Starting from the 1st of January 2013 it will not receive security updates any more. Anyone still using a 1.0 release should investigate migrating to the latest SMF version. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1 Beta 2":\n			window.smfLatestPackages = ''A few bugs have been fixed since SMF 1.1 Beta 2, and a problem with parsing nested BBC tags addressed.  You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-beta2-fix1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily fix the problem.<br /><br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> or in the helpdesk if you need more help.'';\n			break;\n		case "SMF 1.1 RC2":\n			if (!in_array("smf:smf_1-1-rc2-2", window.smfInstalledPackages))\n				window.smfLatestPackages = ''A security issue has been identified in SMF 1.1 RC2. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to easily update yourself to the latest version.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			else\n				showLatestPackages();\n			break;\n		case "SMF 1.1":\n			window.smfLatestPackages = ''A number of small bugs and a security issue have been identified in SMF 1.1 Final. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-1_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.1":\n			window.smfLatestPackages = ''A number of bugs and a couple of low risk security issues have been identified in SMF 1.1.1 - and some improvements have been made to the visual verification images on registration. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_1-1-2_patch.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.2.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.2":\n			window.smfLatestPackages = ''A number of bugs and a couple of low risk security issues have been identified in SMF 1.1.2 - and some improvements have been made to the package manager. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.3_1.0.11.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.3.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.3":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.3 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.4.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.4":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.4 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.5.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.5":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.5 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.14_1.1.6.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.6.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.6":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.6. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.15_1.1.7.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.7.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.7":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.7. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.16_1.1.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.8.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.8":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.8. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.9.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.9":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.9. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.10.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.10":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.10. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.19_1.1.11.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.11.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.11":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.11. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.20_1.1.12.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.12.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.12":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.12. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.21_1.1.13.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.13.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.13":\n			window.smfLatestPackages = ''A security vulnerability have been identified in SMF 1.1.13. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.14.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.14.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.14":\n			window.smfLatestPackages = ''A security vulnerability have been identified in SMF 1.1.14. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.15.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.15.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.15":\n			window.smfLatestPackages = ''A couple of security vulnerabilities have been identified in SMF 1.1.15. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.22_1.1.16.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.16.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.16":\n			window.smfLatestPackages = ''A security vulnerability has been identified in SMF 1.1.16. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.23_1.1.17.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.17.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.17":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.17. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.18.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.18":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.18. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.19_2.0.6.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.18.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 1.1.19":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 1.1.19. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.20_2.0.9.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 1.1.20.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled if you use the full package. Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 Beta 1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 beta 1 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.12_1.1.4_2.0.b1.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0 beta 1.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 Beta 3 Public":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 beta 3 as well as a few small bugs. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.13_1.1.5_2.0-b3.1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0 beta 3.1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC1. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.17_1.1.9_2.0-RC1-1.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0-RC1-1.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC1-1":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC1-1. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.18_1.1.10-2.0-RC1.2.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your version of SMF to 2.0-RC1.2 .<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0 RC4":\n			if (typeof(window.smfRC4patch) == "undefined")\n				window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0 RC4. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0-RC4_security.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to install the security patch for SMF 2.0 RC4.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			else\n				showLatestPackages();\n			break;\n		case "SMF 2.0":\n			window.smfLatestPackages = ''A few security vulnerabilities have been identified in SMF 2.0. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to update your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.1":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.1 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.2.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.2":\n			window.smfLatestPackages = ''A security vulnerability and few bugs in SMF 2.0.2 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.3.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.3":\n			window.smfLatestPackages = ''A few security vulnerabilities in SMF 2.0.3 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.4.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.4":\n			window.smfLatestPackages = ''A few security vulnerabilities in SMF 2.0.4 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.5.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.5":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.5 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.19_2.0.6.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.6":\n			window.smfLatestPackages = ''PHP 5.5 compatibility issues and several other bugs have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.7.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.7.<br /><br />If you have any problems applying it, you can try to use the upgrade file posted on the downloads page - although, any modifications you have installed will need to be uninstalled when you use that method.<br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.7":\n			window.smfLatestPackages = ''Memory issues encountered with SMF 2.0.7, some MySQL 5.6 compatibility issues and a rare bug with the memberlist search feature have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_2.0.8.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.8.<br /><br />If you have any problems applying it, you can try to use the upgrade file posted on the downloads page - although, any modifications you have installed will need to be uninstalled when you use that method.<br />Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		case "SMF 2.0.8":\n			window.smfLatestPackages = ''A few security vulnerabilities and bugs in SMF 2.0.8 have been fixed. You can install <a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.1.20_2.0.9.zip;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">this patch (click here to install)</a> to fix your forum and update it to 2.0.9.<br /><br />If you have any problems applying it, you can use the version posted on the downloads page - although, any modifications you have installed will need to be uninstalled.  Please post on the <a href="http://www.simplemachines.org/community/index.php">forum</a> if you need more help.'';\n			break;\n		default:\n			showLatestPackages();\n			break;\n	}\n}\nelse\n{\n	window.smfLatestPackages = ''For the package manager to function properly, please upgrade to the latest version of SMF.'';\n}\n\n// This function shows latest mods when there isn''t anything else to display\nfunction showLatestPackages()\n{\n	smf_modificationInfo = {\n	\n		4016: {\n			name: ''Modified No Topics Message 1.1'',\n			versions: [''80''],\n			desc: ''<hr /><div align="center"><span style="color: red;" class="bbc_color"><span style="font-size: 16pt;" class="bbc_size"><strong>MODIFIED NO TOPICS MESSAGE v1.1</strong></span></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=253913" class="bbc_link" target="_blank"><strong>By Dougiefresh</strong></a> -&gt; <a href="http://custom.simplemachines.org/mods/index.php?mod=4016" class="bbc_link" target="_blank">Link to Mod</a><br /></div><hr /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Introduction</span></span></strong></span><br />This mod modifies the MessageIndex template so that it is clearer (at least to me) that there are no topics or posts to view in the board.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Admin Settings</span></span></strong></span><br />There are no admin settings to this mod.&nbsp; To disable, you must uninstall this mod.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Compatibility Notes</span></span></strong></span><br />This mod was tested on SMF 2.0.9, but should work on SMF 2.0 and up.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Changelog</span></span></strong></span><br />The changelog has been removed and can be seen at <a href="http://www.xptsp.com/board/index.php?topic=177.msg232#msg232" class="bbc_link" target="_blank">XPtsp.com</a>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">License</span></span></strong></span><br />Copyright (c) 2015, Douglas Orend<br />All rights reserved.<br /><br />Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:<br /><br />1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.<br /><br />2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.<br /><br />THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &quot;AS IS&quot; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.<br />'',\n			file: ''Modified_No_Topic_Msg_v1.1.zip''\n		},\n		4015: {\n			name: ''List Of Users In Topic or Board 1.1'',\n			versions: [''80''],\n			desc: ''<hr /><div align="center"><span style="color: red;" class="bbc_color"><span style="font-size: 16pt;" class="bbc_size"><strong>LIST OF USERS IN TOPIC OR BOARD v1.1</strong></span></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=253913" class="bbc_link" target="_blank"><strong>By Dougiefresh</strong></a> -&gt; <a href="http://custom.simplemachines.org/mods/index.php?mod=4015" class="bbc_link" target="_blank">Link to Mod</a><br /></div><hr /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Introduction</span></span></strong></span><br />This mod modifies the Message Index and Post Display templates so that list of users in the board or topic is moved <strong>from</strong> above the topic list or start of the post <strong>to</strong> just above the Quick Reply box, and adds phpBB-like styling to the list.<br /><br />The &quot;Show who is viewing the board index and posts&quot; option in <strong>Theme Settings</strong> has been removed, in favor of permissions, which have been added to allow membergroups to be able to view the list for the Message Index and Post Display.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Admin Settings</span></span></strong></span><br />Permissions to enable the mod for each membergroup is available in the Admin Center.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Compatibility Notes</span></span></strong></span><br />This mod was tested on SMF 2.0.9, but should work on SMF 2.0 and up.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Translations</span></span></strong></span><br />o Dutch translation by Fixit over at the <a href="http://www.xptsp.com/board/" class="bbc_link" target="_blank">XPtsp.com forum</a>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Changelog</span></span></strong></span><br />The changelog has been removed and can be seen at <a href="http://www.xptsp.com/board/index.php?topic=132.msg182#msg182" class="bbc_link" target="_blank">XPtsp.com</a>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">License</span></span></strong></span><br />Copyright (c) 2015, Douglas Orend<br />All rights reserved.<br /><br />Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:<br /><br />1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.<br /><br />2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.<br /><br />THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &quot;AS IS&quot; AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.<br />'',\n			file: ''List_Of_Users_In_Topic_or_Board_v1.1.zip''\n		},\n		4014: {\n			name: ''AMSP - Add Member&#039;s Signature Permission (Partially Hook!) 1.0.1'',\n			versions: [''80''],\n			desc: ''<span style="font-size: 14pt;" class="bbc_size"><strong><span style="color: maroon;" class="bbc_color">AMSP - Add Member&#039;s Signature Permission<br /></span></strong></span><br />- For SMF 2.0.x<br />- Partially using hook, modifications on three files.<br /><br />1. Please do your own backup though every installation is backed up automatically.<br />2. By default, forum members are usually allowed to have their own signatures (to advertise).<br />3. These signatures are shown at display (post), personal messsage, profile summary etc (are there any more?).<br />4. Some signatures are anoying and forum admins / owners dislike this (or they want to charge some payment for them <img src="http://media.simplemachinesweb.com/smf/smileys/default/tongue.gif" alt="&#58;P" title="Tongue" class="smiley" />). <br />5. Using this mod added permission, forum admins / owners can decide which groups are allowed to have their signatures.<br />6. This mod will automatically stop displaying all members&#039; signatures (other than admin groups), until permission is given.<br />7. You can test it in all lower SMF 2.0.x version too as IMO it should work just fine. <img src="http://media.simplemachinesweb.com/smf/smileys/default/wink.gif" alt=";&#41;" title="Wink" class="smiley" /><br /><br /><br />Thank you for using/testing it.<br /><br /><br />Yours friendly,<br />Abu Fahim Ismail.<br /><br /><span style="color: red;" class="bbc_color">BSD License.</span> Feel free to modify accordingly but keep original and current authors&#039; link(s) if it is in there somewhere. <img src="http://media.simplemachinesweb.com/smf/smileys/default/wink.gif" alt=";&#41;" title="Wink" class="smiley" /><br /><br />Github link: <a href="https://github.com/ahrasis/AMSP-Add-Members-Signature-Permission-Mod" class="bbc_link" target="_blank">ahrasis/AMSP-Add-Members-Signature-Permission-Mod</a><br /><br /><img src="http://validator.w3.org/images/valid_icons/valid-xhtml10" alt="" class="bbc_img" />&nbsp; <img src="http://jigsaw.w3.org/css-validator/images/vcss" alt="" class="bbc_img" /><br /><br /><strong><span class="bbc_u">#Change Logs</span></strong><br /><br /><span class="bbc_u">@Version 1.0.1</span><br />- Fix display in both classic and simple view in permission page.<br /><br /><span class="bbc_u">@Version 1.0.0</span><br />- Initial release.'',\n			file: ''AMSP.partiallyhooks.v.101.zip''\n		},\n		3039: {\n			name: ''Change Attachment Extensions 2.0'',\n			versions: [''61'', ''63'', ''73'', ''74'', ''76'', ''77'', ''80''],\n			desc: ''<hr /><div align="center"><span style="color: red;" class="bbc_color"><span style="font-size: 16pt;" class="bbc_size"><strong>CHANGE ATTACHMENT EXTENSION v2.0</strong></span></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=253913" class="bbc_link" target="_blank"><strong>By Dougiefresh</strong></a> -&gt; <a href="http://custom.simplemachines.org/mods/index.php?mod=3039" class="bbc_link" target="_blank">Link to Mod</a><br /></div><hr /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Introduction</span></span></strong></span><br />Evidentally, some FTP clients, which shall rename nameless (*cough*cough* FileZilla), doesn&#039;t transfer files without an extension correctly without some work.&nbsp; After reading at one of these threads on the Simple Machines forum (lost the link), I wondered how hard it would be to add an extension to the filenames that attachments are stored under.&nbsp; So I did some research and figured out it wasn&#039;t hard at all.....<br /><br /><strong>PLEASE NOTE</strong> that uploaded avatars are considered attachments within SMF and this mod will rename them as well as regular attachments!<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">What It Does</span></span></strong></span><br />This mod makes a small change to Subs.php to add the &quot;.321&quot; extension to all attachment filenames.&nbsp; It also renames all attachments to have the &quot;.321&quot; extension.&nbsp; Upon uninstalling, it removes the &quot;.321&quot; extension.&nbsp; This mod also modified the code for the PM attachments mod, if present, in order to effect the same modification to it.<br /><br /><strong>AEVA MEDIA:</strong> This mod adds the proper extension (lowercase) to the media attachment file, thus <strong>1_blah</strong> becomes <strong>1_blah.jpg</strong> if the original filename has an extension of <strong>jpg</strong>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Credits</span></span></strong></span><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=391249" class="bbc_link" target="_blank">stucki</a> requested the addition of support for Aeva Media files.&nbsp; Thanks, Stucki!<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Admin Settings</span></span></strong></span><br />There are no admin settings.&nbsp; To disable it, you must remove this mod.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Compatibility Notes</span></span></strong></span><br />This mod was tested on SMF 2.0.7, but should work on SMF 2.0 and up.&nbsp; SMF 1.1 is not and will not be supported, so please don&#039;t ask.<br /><br />If you use the <a href="http://custom.simplemachines.org/mods/index.php?mod=1974" class="bbc_link" target="_blank">PM Attachments</a> mod, it should be installed before this mod.<br /><br />If you use the <a href="http://custom.simplemachines.org/mods/index.php?mod=977" class="bbc_link" target="_blank">Aeva Media v1.4w</a> mod, it should be installed before this mod.<br /><br />This mod should be installed AFTER a forum conversion (phpbb -&gt; smf), not before, as files will not be named correctly during the conversion.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Upgrading from Previous Mod Versions</span></span></strong></span><br />Upgrade is supported from <strong>version 1.0 thru 1.2</strong> to <strong>version 2.0</strong>.<br /><br /><span style="color: blue;" class="bbc_color"><strong><span style="font-size: 12pt;" class="bbc_size"><span class="bbc_u">Changelog</span></span></strong></span><br /><span class="bbc_u"><strong>v2.0 - June 6th, 2014</strong></span><br />o Added attachment support for <a href="http://custom.simplemachines.org/mods/index.php?mod=977" class="bbc_link" target="_blank">Aeva Media v1.4w</a><br />o Fixed <strong>install.php</strong> script to correctly handle pm attachments, as they were skipped over (somehow)<br /><br /><span class="bbc_u"><strong>v1.2 - August 4th, 2013</strong></span><br />o Removed unnecessary extra ZIP file inside package.&nbsp; No upgrade required.<br /><br /><span class="bbc_u"><strong>v1.1 - May 5th, 2013</strong></span><br />o Package updated to work with SMF 2.0 and up.&nbsp; No upgrade required.<br /><br /><span class="bbc_u"><strong>v1.0 - May 14th, 2011</strong></span><br />o Initial Release of the mod<br /><br /><hr /><a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank"><img src="http://i.creativecommons.org/l/by/3.0/80x15.png" alt="" class="bbc_img" /></a><br />This work is licensed under a <a href="http://creativecommons.org/licenses/by/3.0" class="bbc_link" target="_blank">Creative Commons Attribution 3.0 Unported License</a><br />'',\n			file: ''Attachment_Extensions_v2.0.zip''\n		}	};\n	var smf_latestModifications = [4016, 4015, 4014];\n	\n	window.smfLatestPackages = ''\\\n		<div id="smfLatestPackagesWindow"style="overflow: auto;">\\\n			<h3 style="margin: 0; padding: 4px;">New Packages:</h3>\\\n			<img src="http://www.simplemachines.org/smf/images/package.png" width="102" height="98" style="float: right; margin: 4px;" alt="(package)" />\\\n			<ul style="list-style: none; margin-top: 3px; padding: 0 4px;">'';\n	\n	for (var i = 0; i < smf_latestModifications.length; i++)\n	{\n		var id_mod = smf_latestModifications[i];\n	\n		window.smfLatestPackages += ''<li><a href="javascript:smf_packagesMoreInfo('' + id_mod + '');void(0);">'' + smf_modificationInfo[id_mod].name + ''</a></li>'';\n	}\n	\n	window.smfLatestPackages += ''\\\n			</ul>'';\n	\n	if (typeof(window.smfVersion) != "undefined" && (window.smfVersion < "SMF 1.0.6" || (window.smfVersion == "SMF 1.1 RC2" && !in_array(''smf:smf-1.0.7'', window.smfInstalledPackages))))\n		window.smfLatestPackages += ''\\\n			<h3 class="error" style="margin: 0; padding: 4px;">Updates for SMF:</h3>\\\n			<div style="padding: 0 4px;">\\\n				<a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/smf_patch_1.0.7_1.1-RC2-1.tar.gz;'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Security update (X-Forwarded-For header vulnerability)</a>\\\n			</div>'';\n	else\n		window.smfLatestPackages += ''\\\n			<h3 style="margin: 0; padding: 4px;">Package of the Moment:</h3>\\\n			<div style="padding: 0 4px;">\\\n				<a href="javascript:smf_packagesMoreInfo(3039);void(0);">Change Attachment Extensions 2.0</a>\\\n			</div>'';\n	\n	window.smfLatestPackages += ''\\\n		</div>'';\n}\n\nfunction findTop(el)\n{\n	if (typeof(el.tagName) == "undefined")\n		return 0;\n\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\n\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\n		return skipMe ? 0 : el.offsetTop;\n	else\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\n}\n\nfunction in_array(item, array)\n{\n	for (var i in array)\n	{\n		if (array[i] == item)\n			return true;\n	}\n\n	return false;\n}\n\nfunction smf_packagesMoreInfo(id)\n{\n	window.smfLatestPackages_temp = document.getElementById("smfLatestPackagesWindow").innerHTML;\n\n	setInnerHTML(document.getElementById("smfLatestPackagesWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_modificationInfo[id].name + ''</h3>\\\n		<h4 style="padding: 4px; margin: 0;"><a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/'' + id + ''/'' + smf_modificationInfo[id].file + '';'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Install Now!</a></h4>\\\n		<div style="margin: 4px;">'' + smf_modificationInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\n		<div class="titlebg" style="padding: 4px; margin: 0;"><a href="javascript:smf_packagesBack();void(0);">(go back)</a></div>'');\n}\n\nfunction smf_packagesBack()\n{\n	setInnerHTML(document.getElementById("smfLatestPackagesWindow"), window.smfLatestPackages_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestPackagesWindow")) - 10);\n}', 'text/javascript');
INSERT INTO `forum_admin_info_files` (`id_file`, `filename`, `path`, `parameters`, `data`, `filetype`) VALUES
(5, 'latest-smileys.js', '/smf/', 'language=%1$s&version=%3$s', 'var actionurl = ''?action=admin;area=smileys;sa=install;set_gz='';\nif (typeof(window.smfForum_sessionvar) == "undefined")\n	window.smfForum_sessionvar = ''sesc'';\n\nvar smf_smileysInfo = {\n\n	3840: {\n		name: ''Android smileys 1.0'',\n		versions: [''78''],\n		desc: ''This is just a simple modification that adds new smileys set to your forum.<br />The icons were made by Google for Android system and are under open-source license.'',\n		file: ''Android_smileys_1.0.zip''\n	},\n	3628: {\n		name: ''BBPh Smileys 1.0'',\n		versions: [''72'', ''73''],\n		desc: ''Made to easily replace default ones.<br /><br /><img src="http://dl.dropbox.com/u/1684364/arc/bbph.gif" alt="" class="bbc_img" /><br /><br />These are just my favorites since the first forum I ever lived on was based on phpBB. Some are animated. package-info.xml included.<br /><br />Original smileys belong to phpBB. Some minor mods by me.'',\n		file: ''bbph.zip''\n	},\n	3290: {\n		name: ''Blue Smiley Animation 2.0'',\n		versions: [''67'', ''72'', ''68'', ''73''],\n		desc: ''<div align="center"><span style="font-size: 1.45em;" class="bbc_size"><span style="color: green;" class="bbc_color"><strong>Blue Smiley Animation</strong></span></span></div><div align="center"><a href="http://www.simplemachines.org/community/index.php?topic=464629.0" class="bbc_link" target="_blank">English Support</a> | <a href="http://smf-portal.hu" class="bbc_link" target="_blank">Hungarian Support</a> | <a href="http://custom.simplemachines.org/mods/index.php?action=profile;u=221448" class="bbc_link" target="_blank">My Mods</a></div><hr /><br /><strong>Autor:</strong><br /><a href="http://www.simplemachines.org/community/index.php?action=profile;u=221448" class="bbc_link" target="_blank">WasdMan</a> and Cserrobi<br /><br /><strong>Description (Hungarian):</strong> <br />Kék mosolygó arcok<br /><br /><strong>Description (English):</strong><br />Blue Smiley package<br /><br /><img src="http://smf-portal.hu/Download/Egyeb/keksmiley.png" alt="" width="600" height="237" class="bbc_img resized" /><br /><br /><strong>Compatibility: </strong><br /><ul class="bbc_list"><li>1.0 - 1.99.99</li><li>2.0 - 2.99.99</li></ul>'',\n		file: ''BlueSmileyAnimation_2.1_UNI.zip''\n	},\n	1072: {\n		name: ''AC in Black Smilies (OVERSIZED) 1.0'',\n		versions: [''31''],\n		desc: ''Some oversized black/silver smilies for your forum <img src="http://media.simplemachinesweb.com/smf/smileys/default/smiley.gif" alt="&#58;&#41;" title="Smiley" class="smiley" /><br /><br />THE EXTRAS PACK BY ITSELF IS MANUAL INSTALL<br /><br />With extras:<br />58 total smilies<br />23 animated smilies<br />35 static smilies<br /><br />Without Extras:<br />43 Total smilies<br />12 animated smilies<br />31 static smilies.<br /><br />The default pack is designed to work with the original AC in Black smilies set (though this is not required or needed for these to work) <img src="http://media.simplemachinesweb.com/smf/smileys/default/smiley.gif" alt="&#58;&#41;" title="Smiley" class="smiley" /><br /><br />See them all here: <a href="http://www.jades-world.com/?section=leftovers&amp;page=smf" class="bbc_link" target="_blank">http://www.jades-world.com/?section=leftovers&amp;page=smf</a><br /><br /><strong>I recomend you post in the topic so if I update these you will know <img src="http://media.simplemachinesweb.com/smf/smileys/default/smiley.gif" alt="&#58;&#41;" title="Smiley" class="smiley" /></strong><br /><br /><br />TOO BIG? TRY THE <a href="http://custom.simplemachines.org/mods/index.php?mod=1043" class="bbc_link" target="_blank">NORMAL SIZED</a> set!'',\n		file: ''OversizedACinBlack_WITH_EXTRAS_PACKS.zip''\n	},};\nvar smf_latestSmileys = [3840, 3628, 3290];\n\nfunction smf_packagesMoreInfo(id)\n{\n	window.smfLatestSmileys_temp = document.getElementById("smfLatestSmileysWindow").innerHTML;\n\n	setInnerHTML(document.getElementById("smfLatestSmileysWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_smileysInfo[id].name + ''</h3>\\\n		<h4 style="padding: 4px; margin: 0;"><a href="'' + window.smfForum_scripturl + actionurl + ''http://custom.simplemachines.org/mods/downloads/'' + id + ''/'' + smf_smileysInfo[id].file + '';'' + window.smfForum_sessionvar + ''='' + window.smfForum_sessionid + ''">Install Now!</a></h4>\\\n		<div style="margin: 4px;">'' + smf_smileysInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\n		<div class="titlebg" style="padding: 4px; margin: 0;"><a href="javascript:smf_packagesBack();void(0);">(go back)</a></div>'');\n}\n\nfunction smf_packagesBack()\n{\n	setInnerHTML(document.getElementById("smfLatestSmileysWindow"), window.smfLatestSmileys_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestSmileysWindow")) - 10);\n}\n\nwindow.smfLatestSmileys = ''\\\n	<div id="smfLatestSmileysWindow" style="overflow: auto;">\\\n		<img src="http://www.simplemachines.org/smf/images/smileys.png" width="102" height="98" style="float: right; margin: 4px;" alt="(package)" />\\\n		<h3 style="margin: 0; padding: 4px;">Smiley of the Moment:</h3>\\\n		<div style="padding: 0 4px;">\\\n			<a href="javascript:smf_packagesMoreInfo(1072);void(0);">AC in Black Smilies (OVERSIZED) 1.0</a>\\\n		</div>'';\n\nwindow.smfLatestSmileys += ''\\\n		<h3 style="margin: 0; padding: 4px;">New Smileys:</h3>\\\n		<ul style="list-style: none; margin-top: 3px; padding: 0 4px;">'';\n\nfor (var i = 0; i < smf_latestSmileys.length; i++)\n{\n	var id_mod = smf_latestSmileys[i];\n\n	window.smfLatestSmileys += ''<li><a href="javascript:smf_packagesMoreInfo('' + id_mod + '');void(0);">'' + smf_smileysInfo[id_mod].name + ''</a></li>'';\n}\n\nwindow.smfLatestSmileys += ''\\\n		</ul>'';\n\nwindow.smfLatestSmileys += ''\\\n	</div>'';\n\nfunction findTop(el)\n{\n	if (typeof(el.tagName) == "undefined")\n		return 0;\n\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\n\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\n		return skipMe ? 0 : el.offsetTop;\n	else\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\n}\n\nfunction in_array(item, array)\n{\n	for (var i in array)\n	{\n		if (array[i] == item)\n			return true;\n	}\n\n	return false;\n}', 'text/javascript'),
(6, 'latest-support.js', '/smf/', 'language=%1$s&version=%3$s', 'window.smfLatestSupport = ''<div style="font-size: 0.85em;"><div style="font-weight: bold;">SMF 2.0.9</div>This version fixes several minor bugs and security issues.  Please <a href="http://www.simplemachines.org/download.php">try it</a> before requesting support.</div>'';\n\nif (document.getElementById(''credits''))\n	setInnerHTML(document.getElementById(''credits''), getInnerHTML(document.getElementById(''credits'')).replace(/thank you!/, ''<span onclick="alert(\\''Kupo!\\'');">thank you!</span>''));\n', 'text/javascript'),
(7, 'latest-themes.js', '/smf/', 'language=%1$s&version=%3$s', '\r\nvar smf_themeInfo = {\r\n	2520: {\r\n		name: ''Theme Christmas Carol'',\r\n		desc: ''<span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Theme Christmas Carol</span></span><br /><hr /><strong> By : Ricky.&nbsp; |&nbsp; <a href="http://ifandbut.com/talk/index.php?topic=168.0" class="bbc_link" target="_blank">Theme Support</a> | <a href="http://custom.simplemachines.org/themes/index.php?action=profile;u=34192" class="bbc_link" target="_blank">My More Themes</a> <br />For SMF 2.0 , SMF 2.0.1<br /></strong><br /><br />A colorful theme specially for the celebration of Christmas. A fixed width theme with menu on left side of the forum giving your forum a unique layout along with combination of bright colors. Suitable for any kind of forum celebrating X-mas. This theme gives you beautiful looks yet with professional touch. Theme also allows you mention your custom copyright in footer. <br /><br /><strong>You can change theme features at : <br />SMF Admin --&gt; Configuration --&gt; Current Theme </strong><br />(Assuming that <strong>Theme Christmas Carol</strong> has been selected as overall smf theme on your forum). <br /><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Features</span></span><br /><hr /><ul class="bbc_list"><li>Vertical menu in Sidebar</li><li>A fixed width theme</li><li>Bright colored</li><li>Allow you add your own logo from them Admin Menu</li><li>Utilizing CSS3 supported by all modern browser</li><li>Allows you to add custom copyright in footer</li></ul><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">In the Last</span></span><br /><hr />If you liked my theme or use my theme then please have some moment here and give <strong>your valuable comments</strong>, those comments serves as encouragement for my future themes and work. <br /><br /><span style="color: green;" class="bbc_color"><span style="font-size: 14pt;" class="bbc_size">Some Screenshots</span></span><br /><hr /><div align="center"><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191441;image" alt="" class="bbc_img" /><br /><br /><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191445;image" alt="" class="bbc_img" /><br /><br /><img src="http://www.simplemachines.org/community/index.php?action=dlattach;topic=460735.0;attach=191443;image" alt="" class="bbc_img" /><br /><br /></div>'',\r\n		file: ''christmas-carol.zip'',\r\n		author: ''Ricky.''\r\n	},\r\n	2824: {\r\n		name: ''BeCool'',\r\n		desc: ''<a href="http://demo.studiocrimes.com/index.php?theme=25" class="bbc_link" target="_blank">Live demo</a> available!<br /><br />Newest free theme from <a href="http://studiocrimes.com" class="bbc_link" target="_blank">studioCRIMES.com</a>'',\r\n		file: ''BeCool_2.0.x.zip'',\r\n		author: ''CrimeS''\r\n	},\r\n	2823: {\r\n		name: ''Raki!!'',\r\n		desc: ''<strong>Raki </strong>is a simple theme with blues and greys to create a curve based coresque feel. The theme uses CSS3 so may not work on all browsers.<br /><br /><strong>Terms of use:</strong><br /><br />This theme is free for personal and commercial use. You are allowed to use it in your projects, change it and adapt for your purposes. You are not allowed to remove the authors copyright.<br /><br /><strong>Disclaimer</strong>: Support is not guaranteed on this theme!'',\r\n		file: ''raki.zip'',\r\n		author: ''Runic''\r\n	},\r\n	2822: {\r\n		name: ''Two Minutes'',\r\n		desc: ''<strong>Two Minutes</strong> is a professional theme with a grey yet colourful feel. Perfect for those that want to relax.<br /><br /><strong>Terms of use</strong>:<br /><br />This theme is free for personal and commercial use. You are allowed to use it in your projects, change it and adapt for your purposes. You are not allowed to remove the authors copyright.<br /><br /><strong>Disclaimer</strong>: Support is not guaranteed on this theme!'',\r\n		file: ''twominutes.zip'',\r\n		author: ''Runic''\r\n	},\r\n	2790: {\r\n		name: ''Apple'',\r\n		desc: ''<strong>Apple</strong> is a professional light custom theme with social, links, About Us and Flickr widgets.&nbsp; This theme uses CSS3 so may not work in all browsers, <br /><br /><strong>Terms of use :</strong><br /><br />This theme is free for personal and commercial use. You are allowed to use it in your projects, change it and adapt for your purposes. You are not allowed to remove the authors copyright.<br /><br /><strong>Disclaimer</strong>: Support is not guaranteed on this theme!'',\r\n		file: ''apple.zip'',\r\n		author: ''Μπράιαν Poύνικ Ντίκεν''\r\n	}\r\n};\r\nvar smf_featured = 2520;\r\nvar smf_random = 2790;\r\nvar smf_latestThemes = [2824, 2823, 2822];\r\nfunction smf_themesMoreInfo(id)\r\n{\r\n	window.smfLatestThemes_temp = document.getElementById("smfLatestThemesWindow").innerHTML;\n\n	// !!! Why not just always auto?\n	document.getElementById("smfLatestThemesWindow").style.overflow = "auto";\n	setInnerHTML(document.getElementById("smfLatestThemesWindow"),\n	''\\\n		<h3 style="margin: 0; padding: 4px;">'' + smf_themeInfo[id].name + ''</h3>\\\r\n		<h4 style="margin: 0;padding: 4px;"><a href="http://custom.simplemachines.org/themes/index.php?lemma='' + id + ''">View Theme Now!</a></h4>\\\r\n		<div style="overflow: auto;">\\\r\n			<img src="http://custom.simplemachines.org/themes/index.php?action=download;lemma=''+id+'';image=thumb" alt="" style="float: right; margin: 10px;" />\\\r\n			<div style="padding:8px;">'' + smf_themeInfo[id].desc.replace(/<a href/g, ''<a href'') + ''</div>\\\r\n		</div>\\\r\n		<div style="padding: 4px;" class="smalltext"><a href="javascript:smf_themesBack();void(0);">(go back)</a></div>'');\n}\r\n\r\nfunction smf_themesBack()\r\n{\r\n	document.getElementById("smfLatestThemesWindow").style.overflow = "";\n	setInnerHTML(document.getElementById("smfLatestThemesWindow"), window.smfLatestThemes_temp);\n	window.scrollTo(0, findTop(document.getElementById("smfLatestThemesWindow")) - 10);\r\n}\r\n\r\nwindow.smfLatestThemes = ''\\\r\n	<div id="smfLatestThemesWindow">\\\r\n		<div>\\\r\n			<img src="http://www.simplemachines.org/smf/images/themes.png" width="102" height="98" style="float: right; margin: 0 0 10px 10px;" alt="(package)" />\\\r\n			<ul style="list-style: none; padding: 0; margin: 0 0 0 5px;">'';\r\nfor(var i=0; i < smf_latestThemes.length; i++)\r\n{\r\n	var id_theme = smf_latestThemes[i];\r\n	window.smfLatestThemes += ''\\\r\n				<li style="list-style: none;"><a href="javascript:smf_themesMoreInfo('' + id_theme + '');void(0);">'' + smf_themeInfo[id_theme].name + '' by '' + smf_themeInfo[id_theme].author + ''</a></li>'';\r\n}\r\n\r\nwindow.smfLatestThemes += ''\\\r\n			</ul>'';\r\nif ( smf_featured !=0 || smf_random != 0 )\r\n{\r\n\r\n	if ( smf_featured != 0 )\r\n		window.smfLatestThemes += ''\\\r\n				<h4 style="padding: 4px 4px 0 4px; margin: 0;">Featured Theme</h4>\\\r\n				<p style="padding: 0 4px; margin: 0;">\\\r\n					<a href="javascript:smf_themesMoreInfo(''+smf_featured+'');void(0);">''+smf_themeInfo[smf_featured].name + '' by '' + smf_themeInfo[smf_featured].author+''</a>\\\r\n				</p>'';\r\n	if ( smf_random != 0 )\r\n		window.smfLatestThemes += ''\\\r\n				<h4 style="padding: 4px 4px 0 4px;margin: 0;">Theme of the Moment</h4>\\\r\n				<p style="padding: 0 4px; margin: 0;">\\\r\n					<a href="javascript:smf_themesMoreInfo(''+smf_random+'');void(0);">''+smf_themeInfo[smf_random].name + '' by '' + smf_themeInfo[smf_random].author+''</a>\\\r\n				</p>'';\r\n}\r\nwindow.smfLatestThemes += ''\\\r\n		</div>\\\r\n	</div>'';\r\n\r\nfunction findTop(el)\r\n{\r\n	if (typeof(el.tagName) == "undefined")\r\n		return 0;\r\n\r\n	var skipMe = in_array(el.tagName.toLowerCase(), el.parentNode ? ["tr", "tbody", "form"] : []);\r\n	var coordsParent = el.parentNode ? "parentNode" : "offsetParent";\r\n\r\n	if (el[coordsParent] == null || typeof(el[coordsParent].offsetTop) == "undefined")\r\n		return skipMe ? 0 : el.offsetTop;\r\n	else\r\n		return (skipMe ? 0 : el.offsetTop) + findTop(el[coordsParent]);\r\n}\r\n\r\nfunction in_array(item, array)\r\n{\r\n	for (var i in array)\r\n	{\r\n		if (array[i] == item)\r\n			return true;\r\n	}\r\n\r\n	return false;\r\n}', 'text/javascript');

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
('2015-01-06', 0, 0, 0, 2, 1),
('2015-01-09', 0, 0, 0, 0, 2);

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
('178.187.108.75', 1420541868, 'register'),
('83.9.76.135', 1417597654, 'post'),
('46.211.210.80', 1422111505, 'login');

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
('ip66.249.64.52', 1422136794, 0, 0, 1123631156, 'a:4:{s:6:"action";s:7:"profile";s:1:"u";s:2:"11";s:4:"area";s:7:"summary";s:10:"USER_AGENT";s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";}');

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
) ENGINE=MyISAM AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;

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
(98, 1, 1421368770, 0),
(97, 5, 1421361999, 0),
(96, 7, 1421358408, 7),
(95, 1, 1421342072, 0),
(94, 3, 1421294960, 2),
(93, 1, 1421238812, 0),
(92, 5, 1421217936, 0),
(91, 7, 1421199751, 9),
(90, 1, 1421172033, 0),
(89, 3, 1421136174, 0),
(88, 9, 1421025214, 0),
(110, 7, 1421905437, 4),
(109, 3, 1421892498, 0),
(108, 9, 1421883107, 0),
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
(74, 1, 1420650273, 0),
(75, 1, 1420707515, 0),
(76, 7, 1420724996, 6),
(77, 5, 1420769951, 0),
(78, 3, 1420772740, 0),
(79, 1, 1420789813, 0),
(80, 2, 1420793715, 0),
(81, 1, 1420804503, 0),
(82, 1, 1420816492, 0),
(83, 1, 1420839898, 0),
(84, 7, 1420958387, 4),
(85, 1, 1420971987, 0),
(86, 5, 1420983867, 0),
(87, 6, 1421020272, 0),
(99, 2, 1421422120, 0),
(100, 3, 1421497703, 0),
(101, 1, 1421498308, 0),
(102, 7, 1421571640, 4),
(103, 5, 1421571986, 0),
(104, 1, 1421583783, 0),
(105, 6, 1421707614, 0),
(106, 1, 1421711994, 0),
(107, 5, 1421742431, 0),
(111, 1, 1421928865, 0),
(112, 5, 1422006911, 0),
(113, 1, 1422012071, 0),
(114, 7, 1422023509, 4),
(115, 2, 1422023719, 0),
(116, 3, 1422029770, 0),
(117, 1, 1422029831, 0),
(118, 1, 1422087096, 0),
(119, 5, 1422087099, 0),
(120, 1, 1422136794, 0);

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
(1, 'Zarząd', '', '#FF0000', -1, 0, '', 0, 0, -2),
(2, 'Administrator Techniczny', '', '#0000FF', -1, 0, '', 0, 0, -2),
(3, 'Administrator rozgrywki', '', '', -1, 0, '', 0, 0, -2),
(4, 'Newbie', '', '', 0, 0, '', 0, 0, -2),
(9, 'Moderator', '', '', -1, 0, '', 0, 0, -2);

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
  `adminPerm` longtext NOT NULL
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `forum_members`
--

INSERT INTO `forum_members` (`id_member`, `member_name`, `date_registered`, `posts`, `id_group`, `lngfile`, `last_login`, `real_name`, `instant_messages`, `unread_messages`, `new_pm`, `buddy_list`, `pm_ignore_list`, `pm_prefs`, `mod_prefs`, `message_labels`, `passwd`, `openid_uri`, `email_address`, `personal_text`, `gender`, `birthdate`, `website_title`, `website_url`, `location`, `icq`, `aim`, `yim`, `msn`, `hide_email`, `show_online`, `time_format`, `signature`, `time_offset`, `avatar`, `pm_email_notify`, `karma_bad`, `karma_good`, `usertitle`, `notify_announcements`, `notify_regularity`, `notify_send_body`, `notify_types`, `member_ip`, `member_ip2`, `secret_question`, `secret_answer`, `id_theme`, `is_activated`, `validation_code`, `id_msg_last_visit`, `additional_groups`, `smiley_set`, `id_post_group`, `total_time_logged_in`, `password_salt`, `ignore_boards`, `warning`, `passwd_flood`, `pm_receive_from`, `inGame`, `admin`, `adminPerm`) VALUES
(1, 'Kubas', 1417596022, 4, 1, '', 1420804857, 'Kubas', 0, 0, 0, '', '', 0, '', '', '27223ed8980dd8ed1c85e67570121a6b17d5d3c0', '', 'kubasgc@icloud.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, '', 1, 1, 0, 2, '77.252.179.136', '141.101.89.152', '', '', 4, 1, '', 0, '', '', 4, 5275, '057b', '', 0, '1421497701|1', 1, 0, 4, ''),
(14, 'Envoyer', 0, 0, 0, '', 0, 'Envoyer', 0, 0, 0, '', '', 0, '', '', '962b439da7dab511c4a42a66ab045153a39abf96', '', 'ethan133@wp.pl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 0, 0, 0, 'Envoyer', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0, ''),
(15, 'kofeTymn', 1420515290, 0, 0, '', 1420515290, 'kofeTymn', 0, 0, 0, '', '', 0, '', '', '219453fc24acb7f7b213024134ad2c39caf01b4e', '', 'xbiovxekhll@rambler.ru', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '89.178.82.79', '141.101.104.216', '', '', 4, 1, '', 0, '', '', 4, 0, '274c', '', 0, '', 1, 0, 0, ''),
(3, 'Szychu', 1417817515, 0, 0, '', 1418253210, 'Szychu', 0, 0, 0, '', '', 0, '', '', 'fec530892325bae24d6ba90516479ff748477f9f', '', 'SzychuTM@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.30.148.72', '141.101.89.145', '', '', 4, 1, '', 0, '', '', 4, 703, '701b', '', 0, '', 1, 0, 3, ''),
(4, 'Rubik', 1417817576, 0, 0, '', 1417818827, 'Rubik', 0, 0, 0, '', '', 0, '', '', 'c2e7c368d54804449f1387ef5cf29f5023aa4dc0', '', 'rubiikk221@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '89.79.217.0', '141.101.89.162', '', '', 4, 1, '', 0, '', '', 4, 122, '2c7e', '', 0, '', 1, 0, 4, ''),
(5, 'Piteriuz', 1417817972, 0, 0, '', 1417818036, 'Piteriuz', 0, 0, 0, '', '', 0, '', '', '95fa0ed33d49c5fb1c2ddc57f677ac08b9233915', '', 'piteriuz@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.28.154.188', '108.162.254.145', '', '', 4, 1, '', 0, '', '', 4, 99, 'faa9', '', 0, '', 1, 0, 2, ''),
(6, 'Kaizi', 1418160453, 0, 0, '', 1418162401, 'Kaizi', 0, 0, 0, '', '', 0, '', '', 'e8c4532e47c8ccd6fe4d46423fc128dee0500b8a', '', 'kaizi94@gmail.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '77.255.65.33', '141.101.89.105', '', '', 4, 1, '', 0, '', '', 4, 807, 'c774', '', 0, '', 1, 0, 4, ''),
(7, 'Grzegorz', 1418244708, 0, 0, '', 1418244708, 'Grzegorz', 0, 0, 0, '', '', 0, '', '', '383b02c255a6b2a2f340144403dd6494002951d3', '', 'Grzegorz_Grzeholek@o2.pl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '77.254.139.160', '141.101.89.146', '', '', 4, 1, '', 0, '', '', 4, 0, 'bb86', '', 0, '', 1, 0, 0, ''),
(8, 'Msk', 1420200734, 0, 0, '', 1420200748, 'Msk', 0, 0, 0, '', '', 0, '', '', 'fd066441621ad87e61dd3098352ae57f52c8f642', '', 'msk@firstclassgaming.net', '', 0, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '83.31.215.60', '141.101.89.111', '', '', 4, 1, '', 0, '', '', 4, 0, 'c7e4', '', 0, '', 1, 0, 4, ''),
(9, 'KennethNami', 1420329511, 0, 0, '', 1422111505, 'KennethNami', 0, 0, 0, '', '', 0, '', '', '64eeb8732672786f6bc5c93c3b55460d29c2a027', '', 'carlosteroristos@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '46.211.210.80', '108.162.254.51', '', '', 4, 1, '', 0, '', '', 4, 0, 'aedc', '', 0, '', 1, 0, 0, ''),
(10, 'Tester', 0, 0, 0, '', 0, 'Tester', 0, 0, 0, '', '', 0, '', '', '5bfdb9d2aa3e5a96ab796bf3bee19d15208e4111', '', 'test@test.te', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, '', 1, 1, 0, 2, '46.118.173.60', '46.118.173.60', '', '', 4, 1, '', 0, '', '', 4, 0, '09da', '', 0, '', 1, 0, 1, ''),
(11, 'DanielEvok', 1420399329, 0, 0, '', 1422099437, 'DanielEvok', 0, 0, 0, '', '', 0, '', '', 'c108982e58f6e6a67503a80c489b9b46d996af78', '', 'vasalx@outlook.com', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 1, 0, 0, '', 1, 1, 0, 2, '46.118.173.50', '108.162.254.234', '', '', 4, 1, '', 0, '', '', 4, 0, '4af7', '', 0, '', 1, 0, 0, ''),
(12, 'Testora', 0, 0, 0, '', 0, 'Testora', 0, 0, 0, '', '', 0, '', '', 'f6ac17d9794ffebfa271e446623034f9fc4f69c1', '', 'bool@bool.bl', '', 0, '0001-01-01', '', '', '', '', '', '', '', 0, 1, '', '', 0, '', 0, 0, 0, 'Tytul', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0, ''),
(13, 'Testor', 0, 0, 0, '', 0, 'Testor', 0, 0, 0, '', '', 0, '', '', '89de9000646e586b6cb7063d6179047a0e3e4c26', '', 'bool@bool.bla', '', 1, '0001-01-01', '', '', '', '', '', '', '', 1, 1, '', '', 0, '', 0, 0, 0, 'Ramon.', 1, 1, 0, 2, '', '', '', '', 4, 1, '', 0, '', '', 4, 0, 'tttt', '', 0, '', 1, 0, 0, '');

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
(1, 1422144000, 0, 2, 'h', 0, 'approval_notification'),
(2, 1422576000, 0, 7, 'd', 0, 'auto_optimize'),
(3, 1422144060, 60, 1, 'd', 0, 'daily_maintenance'),
(5, 1422144000, 0, 1, 'd', 0, 'daily_digest'),
(6, 1422230400, 0, 1, 'w', 0, 'weekly_digest'),
(7, 1422129840, 158678, 1, 'd', 0, 'fetchSMfiles'),
(8, 0, 0, 1, 'd', 1, 'birthdayemails'),
(9, 1422403200, 0, 1, 'w', 0, 'weekly_maintenance'),
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
('s3jcu9klbdm4dgfk0lf028meh1', 1422023510, 'session_value|s:32:"43309df5c7a0e4e4d966a0ad59e2d448";session_var|s:9:"a8cd8f32f";mc|a:7:{s:4:"time";i:1422023504;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422023509;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.24";s:3:"ip2";s:13:"173.245.54.13";s:5:"email";s:0:"";}log_time|i:1422023510;timeOnlineUpdated|i:1422023510;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('nu0qjoirhdqk6vheu3egsgags5', 1422012071, 'session_value|s:32:"36c3975f52d58edb76fe0fd465d48829";session_var|s:10:"a6b6c16b67";mc|a:7:{s:4:"time";i:1422012071;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422012071;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.64.52";s:3:"ip2";s:13:"173.245.54.79";s:5:"email";s:0:"";}log_time|i:1422012071;timeOnlineUpdated|i:1422012071;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('b68kur07v89b8lo9vg2a6kp3f6', 1422006911, 'session_value|s:32:"b073198b4643e7c96d7533cb5bfd5004";session_var|s:8:"a93cf0d4";mc|a:7:{s:4:"time";i:1422006911;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422006911;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.64.52";s:3:"ip2";s:13:"173.245.56.78";s:5:"email";s:0:"";}log_time|i:1422006911;timeOnlineUpdated|i:1422006911;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('sdh54oq2fqg9f8heododpl0682', 1421996313, 'session_value|s:32:"0f75641eff86430747bda3d34fe81bd0";session_var|s:11:"f7afdd852a5";mc|a:7:{s:4:"time";i:1421996313;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421996313;s:9:"id_member";i:0;s:2:"ip";s:14:"178.187.10.130";s:3:"ip2";s:12:"141.101.80.6";s:5:"email";s:0:"";}log_time|i:1421996313;timeOnlineUpdated|i:1421996313;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=16";USER_AGENT|s:212:"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0; OfficeLiveConnector.1.4; OfficeLivePatch.1.3)";'),
('kk1aml7h6it9td09bv20e80844', 1421996313, 'session_value|s:32:"2b2919f7147ad948eef1e66f06072b05";session_var|s:10:"a1f36b910a";mc|a:7:{s:4:"time";i:1421996313;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421996313;s:9:"id_member";i:0;s:2:"ip";s:14:"178.187.10.130";s:3:"ip2";s:12:"141.101.80.6";s:5:"email";s:0:"";}log_time|i:1421996313;timeOnlineUpdated|i:1421996313;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=16";USER_AGENT|s:212:"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0; OfficeLiveConnector.1.4; OfficeLivePatch.1.3)";'),
('ugp3jbj3f04cabqpobm7tka907', 1421996313, 'session_value|s:32:"ef218786ba46b667bcce9d8340ebe842";session_var|s:11:"eafa07b2c7d";mc|a:7:{s:4:"time";i:1421996313;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421996313;s:9:"id_member";i:0;s:2:"ip";s:14:"178.187.10.130";s:3:"ip2";s:12:"141.101.80.6";s:5:"email";s:0:"";}log_time|i:1421996313;timeOnlineUpdated|i:1421996313;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=16";USER_AGENT|s:212:"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0; OfficeLiveConnector.1.4; OfficeLivePatch.1.3)";'),
('nlu127obcrmopo5rvggukccoj2', 1421996313, 'session_value|s:32:"7642a657a512a2605782c85999607078";session_var|s:9:"ca7bd1e67";mc|a:7:{s:4:"time";i:1421996312;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421996312;s:9:"id_member";i:0;s:2:"ip";s:14:"178.187.10.130";s:3:"ip2";s:12:"141.101.80.6";s:5:"email";s:0:"";}log_time|i:1421996313;timeOnlineUpdated|i:1421996313;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=16";USER_AGENT|s:212:"Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Tablet PC 2.0; OfficeLiveConnector.1.4; OfficeLivePatch.1.3)";'),
('039vj3ebig41tujcndc3mq4jd1', 1421928866, 'session_value|s:32:"4446f87a91b18b2dd20673c2cd22aace";session_var|s:11:"ec7f044c21c";mc|a:7:{s:4:"time";i:1421928865;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421928865;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.64.60";s:3:"ip2";s:13:"173.245.54.79";s:5:"email";s:0:"";}log_time|i:1421928866;timeOnlineUpdated|i:1421928866;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('1lr7nigpn7n7e6kjn1333ktpv4', 1421892498, 'session_value|s:32:"94f5264d43e766e406b6ac7d0e0c8f34";session_var|s:7:"bb5823a";mc|a:7:{s:4:"time";i:1421892498;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421892498;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.65.153";s:3:"ip2";s:14:"108.162.221.95";s:5:"email";s:0:"";}log_time|i:1421892498;timeOnlineUpdated|i:1421892498;old_url|s:53:"http://forum.sgaming.pl/index.php?action=profile;u=11";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('6r9cq3h1nf9kjomgmiv7i39144', 1421905438, 'session_value|s:32:"ea5fa1b72d477473c12cdb77aa3975b0";session_var|s:12:"e5073c2b9089";mc|a:7:{s:4:"time";i:1421905432;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421905437;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.65.149";s:3:"ip2";s:15:"108.162.221.122";s:5:"email";s:0:"";}log_time|i:1421905438;timeOnlineUpdated|i:1421905438;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('ni20q4qfe4m91m0eup20setgv4', 1421883108, 'session_value|s:32:"c0ec410c773f46d39efa7de589da4fdf";session_var|s:11:"b9b4a028da9";mc|a:7:{s:4:"time";i:1421883107;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421883107;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.65.181";s:3:"ip2";s:15:"108.162.221.122";s:5:"email";s:0:"";}log_time|i:1421883108;timeOnlineUpdated|i:1421883108;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:196:"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('lfhf2in721c34bti42hg9mrsc6', 1421862811, 'session_value|s:32:"264df4fb90029d8f6c4bc941b34e7dc3";session_var|s:8:"eeaebc85";mc|a:7:{s:4:"time";i:1421862811;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1421862811;s:9:"id_member";i:0;s:2:"ip";s:13:"66.249.81.161";s:3:"ip2";s:14:"141.101.106.65";s:5:"email";s:0:"";}log_time|i:1421862811;timeOnlineUpdated|i:1421862811;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:78:"Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0 Google favicon";'),
('b55ielvibt9i433rrrc5m0jb47', 1422023719, 'session_value|s:32:"9274a064ba3f49da4876123b0eaf5e4f";session_var|s:11:"e13542c4284";mc|a:7:{s:4:"time";i:1422023719;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422023719;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.80";s:3:"ip2";s:13:"173.245.54.13";s:5:"email";s:0:"";}log_time|i:1422023719;timeOnlineUpdated|i:1422023719;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('9cvcp2ul4qq7s0qof9kq3fuft4', 1422029770, 'session_value|s:32:"fab743ffa5a51bddb58155080b8b789a";session_var|s:8:"a1ebc47c";mc|a:7:{s:4:"time";i:1422029770;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422029770;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.24";s:3:"ip2";s:13:"173.245.54.13";s:5:"email";s:0:"";}log_time|i:1422029770;timeOnlineUpdated|i:1422029770;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('bp8cboptl7c51q259jq75eci22', 1422029831, 'session_value|s:32:"b7d16b6655c281200041f4ce68b47107";session_var|s:12:"b3c7a6f0bc3d";mc|a:7:{s:4:"time";i:1422029831;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422029831;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.32";s:3:"ip2";s:13:"173.245.54.13";s:5:"email";s:0:"";}log_time|i:1422029831;timeOnlineUpdated|i:1422029831;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('eh1h4ukuqj83jesa934iijmdj0', 1422029891, 'session_value|s:32:"6d9beb48718225b3e4fd14d2f7b03e08";session_var|s:10:"d917a3da4c";mc|a:7:{s:4:"time";i:1422029891;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422029891;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.88";s:3:"ip2";s:13:"173.245.54.12";s:5:"email";s:0:"";}log_time|i:1422029891;timeOnlineUpdated|i:1422029891;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('k75jmt41blugdpa25jjoho89b6', 1422034181, 'session_value|s:32:"433b2d7811145523772d4772de2553c3";session_var|s:10:"af0c6084d6";mc|a:7:{s:4:"time";i:1422034181;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422034181;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.67.80";s:3:"ip2";s:13:"173.245.54.13";s:5:"email";s:0:"";}log_time|i:1422034181;timeOnlineUpdated|i:1422034181;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('p2v2ilunfielmb22fl5u915ik5', 1422087097, 'session_value|s:32:"9a39cce9fdd19ecfd3a2d8f6e2a87657";session_var|s:9:"c3ba8ab2b";mc|a:7:{s:4:"time";i:1422087096;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422087096;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:14:"199.27.133.190";s:5:"email";s:0:"";}log_time|i:1422087096;timeOnlineUpdated|i:1422087096;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:60:"python-requests/2.4.3 CPython/2.7.3 Linux/3.14.18-cloudflare";'),
('8qtj9db99v8fjcpap3jieu97u3', 1422087097, 'session_value|s:32:"d7aa526241f64dd18f93daef857fded4";session_var|s:9:"a2bcfa411";mc|a:7:{s:4:"time";i:1422087097;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422087097;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:14:"199.27.133.190";s:5:"email";s:0:"";}log_time|i:1422087097;timeOnlineUpdated|i:1422087097;old_url|s:24:"http://forum.sgaming.pl/";USER_AGENT|s:114:"Mozilla/5.0 (compatible; CloudFlare-AlwaysOnline/1.0; +http://www.cloudflare.com/always-online) AppleWebKit/534.34";'),
('bh0ldk0le1089oitlkcmdn4kt1', 1422087102, 'session_value|s:32:"d4c4a5cd1b2639f5c4a8ed6e5c90a602";session_var|s:10:"d28ea0f706";mc|a:7:{s:4:"time";i:1422087097;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422087102;s:9:"id_member";i:0;s:2:"ip";s:14:"108.162.209.69";s:3:"ip2";s:13:"173.245.56.63";s:5:"email";s:0:"";}log_time|i:1422087097;timeOnlineUpdated|i:1422087097;old_url|s:71:"http://forum.sgaming.pl/index.php?PHPSESSID=bh0ldk0le1089oitlkcmdn4kt1&";USER_AGENT|s:114:"Mozilla/5.0 (compatible; CloudFlare-AlwaysOnline/1.0; +http://www.cloudflare.com/always-online) AppleWebKit/534.34";'),
('k8p8r8tnv6dvui4n27llclp5g3', 1422098901, 'session_value|s:32:"6039de85073defddc1e0947d236de478";session_var|s:10:"b70f7d2437";mc|a:7:{s:4:"time";i:1422098901;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422098901;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422098901;timeOnlineUpdated|i:1422098901;old_url|s:52:"http://forum.sgaming.pl/index.php?action=profile;u=9";USER_AGENT|s:101:"Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('btm1h5r60b9d39ejhdltnjpgo5', 1422092953, 'session_value|s:32:"9068b88c64710c476de57d24461aae72";session_var|s:7:"bb88752";mc|a:7:{s:4:"time";i:1422092932;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422092953;s:9:"id_member";i:0;s:2:"ip";s:13:"46.118.173.50";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1422092953;timeOnlineUpdated|i:1422092933;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:65:"Mozilla/5.0 (Windows NT 5.1; rv:33.0) Gecko/20100101 Firefox/33.0";'),
('440hiphenr4h90n2do2cur6u26', 1422093926, 'session_value|s:32:"86e87f5ca9477b1e65800a602b2929cd";session_var|s:11:"b8d5346874a";mc|a:7:{s:4:"time";i:1422093925;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422093926;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422093925;timeOnlineUpdated|i:1422093925;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:76:"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:33.0) Gecko/20100101 Firefox/33.0";'),
('oc9nseut0u1q468p9rgj8o8mk5', 1422095379, 'session_value|s:32:"37354479ad686ec6dc08ec7a6f318c76";session_var|s:10:"fdbd19d096";mc|a:7:{s:4:"time";i:1422095378;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422095379;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422095378;timeOnlineUpdated|i:1422095378;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('q9r25c36oldap9uhr9u69qr103', 1422136794, 'session_value|s:32:"a05b57cc403a77fc5f8d86dd3ae02bf9";session_var|s:7:"bf6ed09";mc|a:7:{s:4:"time";i:1422136793;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422136794;s:9:"id_member";i:0;s:2:"ip";s:12:"66.249.64.52";s:3:"ip2";s:13:"173.245.56.78";s:5:"email";s:0:"";}log_time|i:1422136794;timeOnlineUpdated|i:1422136794;old_url|s:66:"http://forum.sgaming.pl/index.php?action=profile;u=11;area=summary";USER_AGENT|s:72:"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";'),
('3tpqc5f17qv76qdd6fnknacje3', 1422099441, 'session_value|s:32:"3e55b2adad9b88e9ee54492ccc6ac130";session_var|s:11:"d81fe93390e";mc|a:7:{s:4:"time";i:1422099438;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422099441;s:9:"id_member";i:0;s:2:"ip";s:13:"46.118.173.50";s:3:"ip2";s:15:"108.162.254.234";s:5:"email";s:0:"";}log_time|i:1422099438;timeOnlineUpdated|i:1422099438;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:125:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.65 Safari/537.36 OPR/26.0.1656.24";'),
('qnq6bko5ddah28vlpjv0el0712', 1422100539, 'session_value|s:32:"8d68b7d200d43d4ba83be21165b18511";session_var|s:8:"f2d9f7d1";mc|a:7:{s:4:"time";i:1422100539;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422100539;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422100539;timeOnlineUpdated|i:1422100539;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('ipivcodfqqtb1b56rnurni4df7', 1422104005, 'session_value|s:32:"64a5c2134fc6daab6fd30f527edc2134";session_var|s:7:"b83a68f";mc|a:7:{s:4:"time";i:1422104003;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422104005;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422104004;timeOnlineUpdated|i:1422104004;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:64:"Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.17";'),
('6927e8rjsj5cc1of7ihf4dfvg1', 1422105571, 'session_value|s:32:"7a661f9c0e0f83633bdf33d89d3bb66c";session_var|s:8:"da8a2fbc";mc|a:7:{s:4:"time";i:1422105570;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422105571;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422105570;timeOnlineUpdated|i:1422105570;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:108:"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36";'),
('352bfnsn5j680hq5gmk3072tu2', 1422111507, 'session_value|s:32:"8788260511c9060809ede5ebad282662";session_var|s:7:"c3527cc";mc|a:7:{s:4:"time";i:1422111505;s:2:"id";i:0;s:2:"gq";s:3:"0=1";s:2:"bq";s:3:"0=1";s:2:"ap";a:0:{}s:2:"mb";a:0:{}s:2:"mq";s:3:"0=1";}ban|a:5:{s:12:"last_checked";i:1422111507;s:9:"id_member";i:0;s:2:"ip";s:13:"46.211.210.80";s:3:"ip2";s:14:"108.162.254.51";s:5:"email";s:0:"";}log_time|i:1422111505;timeOnlineUpdated|i:1422111505;old_url|s:33:"http://forum.sgaming.pl/index.php";USER_AGENT|s:125:"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.65 Safari/537.36 OPR/26.0.1656.24";');

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
('mostOnlineToday', '2'),
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
('next_task_time', '1422129840'),
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
('rand_seed', '1035406228'),
('mostOnlineUpdated', '2015-01-09'),
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
(2, 1, 'Jeremy', 'Simons', 'ASDXDD', 90, 280, 1345.1, -1752.42, 13.3604, 34.2861, 0, 0, 2499, 0, 0, 45824, 59460, 1, 0, 1422139611, 0, 0, '0000-00-00 00:00:00', 0),
(16, 6, 'Frederick', 'Lorenzo', 'ASR41A', 50, 288, 2014.57, -1623.97, 13.5469, 90.8885, 0, 0, 0, 0, 0, 8838, 18650, 1, 0, 1421875845, 0, 0, '0000-00-00 00:00:00', 0),
(17, 4, 'Fernando', 'Rubio', '478XT3', 48, 277, 1341.31, -1752.24, 13.52, 235.174, 0, 0, 2501, 0, 0, 9490, 9917, 1, 0, 1422140036, 0, 0, '0000-00-00 00:00:00', 0),
(18, 3, 'John', 'Cavallo', 'ASR16W', 50, 280, 1540.57, -1673.6, 13.2555, 352.044, 0, 0, 0, 0, 0, 869, 10037, 1, 0, 1421876186, 0, 0, '0000-00-00 00:00:00', 0),
(19, 5, 'Piotrek', 'Piotrek', '541WUS', 67, 60, 2886.5, -1294.43, 10.8828, 182.966, 0, 0, 0, 0, 0, 2781, 962, 1, 0, 1421850642, 0, 0, '0000-00-00 00:00:00', 0),
(20, 14, 'Envoyer', 'Envoyer', 'AS8AT2', 100, 280, 1535.9, -1669.42, 13.3828, 154.857, 0, 0, 0, 0, 0, 218, 94, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(21, 8, 'Msk', 'Testowy', 'MSKONE', 100, 295, 111, 244, 231, 22, 0, 0, 100000, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0),
(22, 8, 'Msk2', 'Testowy', 'MSKTWO', 100, 295, 111, 244, 231, 22, 0, 0, 99999, 0, 0, 0, 0, 0, 0, 0, 1, 0, '0000-00-00 00:00:00', 0),
(23, 8, 'Msk3', 'Testowy', 'MSKTHR', 88, 295, 111, 244, 231, 22, 0, 0, 50, 0, 0, 0, 0, 1, 0, 0, 0, 0, '0000-00-00 00:00:00', 0);

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
  `deliverID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_delivers`
--

INSERT INTO `_delivers` (`ID`, `intID`, `pieces`, `data`, `name`, `deliverID`) VALUES
(1, 1, 10, '[ { "itemName": "Amunicja: Beretta 92FS", "itemType": 2, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 'Los Santos Police Department', 0),
(2, 1, 10, '[ { "itemName": "Amunicja: Beretta 92FS", "itemType": 2, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 'Los Santos Police Department', 0);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doors`
--

INSERT INTO `_doors` (`ID`, `name`, `ownerType`, `owner`, `dimension`) VALUES
(1, 'Los Santos Police Department - Główny Interior', 2, 1, 1),
(5, 'All Saints General Hospital', 2, 1, 2),
(7, 'Dom: Jeremy Simons', 1, 2, 3),
(8, 'Szychu test', 1, 1, 4),
(9, '24/7 #1', 3, 0, 5);

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_doorsPickup`
--

INSERT INTO `_doorsPickup` (`ID`, `parentID`, `name`, `inX`, `inY`, `inZ`, `outX`, `outY`, `outZ`, `inDim`, `outDim`, `inInt`, `outInt`, `outModel`, `inModel`, `inAngle`, `outAngle`, `locked`) VALUES
(1, 1, 'Los Santos Police Department', 238.741, 139.413, 1003.02, 1554.66, -1675.45, 16.1953, 1, 0, 3, 0, 1239, 1318, 352.889, 85.3953, 0),
(7, 5, 'Drzwi do szpitala', 1194.41, -1325.02, 13.3984, 1172.77, -1323.86, 15.4009, 2, 0, 0, 0, 1239, 1318, 268.386, 268.386, 0),
(8, 7, 'Dom Kubaska', 260.819, 1237.74, 1084.26, 1331.78, -632.639, 109.135, 3, 0, 9, 0, 1239, 1318, 358.651, 16.2188, 1),
(17, 9, 'Los Santos Kauflandos', -30.9502, -91.4111, 1003.55, 1352.34, -1758.82, 13.5078, 5, 0, 18, 0, 1239, 1318, 355.141, 356.976, 0);

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
(2, 'ASR16W', 'Szychałe'),
(2, '541WUS', 'Piotrek'),
(19, 'ASDXDD', 'Kubas');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups`
--

CREATE TABLE IF NOT EXISTS `_groups` (
`ID` int(11) NOT NULL COMMENT 'UID',
  `name` varchar(64) NOT NULL COMMENT 'Nazwa grupy',
  `tag` varchar(4) NOT NULL COMMENT 'Tag',
  `r` smallint(3) NOT NULL COMMENT 'R',
  `g` smallint(3) NOT NULL COMMENT 'G',
  `b` smallint(3) NOT NULL COMMENT 'B',
  `orderType` int(11) NOT NULL COMMENT 'Typ zamawiania',
  `perms` longtext NOT NULL COMMENT 'Uprawnienia',
  `cash` int(11) NOT NULL COMMENT 'Gotówka'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups`
--

INSERT INTO `_groups` (`ID`, `name`, `tag`, `r`, `g`, `b`, `orderType`, `perms`, `cash`) VALUES
(1, 'Los Santos Police Department', 'LSPD', 50, 50, 220, 1, '[ { "deliver": 1, "arrest": 1, "vehblock": 1, "depochat": 1, "blocks": 1, "Docs": 1 } ]', 500000);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_groups_members`
--

CREATE TABLE IF NOT EXISTS `_groups_members` (
`ID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `rankID` int(11) NOT NULL,
  `groupID` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_members`
--

INSERT INTO `_groups_members` (`ID`, `userID`, `rankID`, `groupID`) VALUES
(1, 2, 1, 1),
(2, 11, 2, 1),
(6, 13, 2, 1),
(7, 10, 2, 1),
(8, 16, 1, 1),
(9, 17, 1, 1),
(10, 21, 2, 1),
(11, 18, 1, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_groups_ranks`
--

INSERT INTO `_groups_ranks` (`ID`, `name`, `groupID`, `cash`, `defaultRank`, `perms`) VALUES
(1, 'Ranga z liderem', 1, 0, 0, '[{"leader": 1, "vehicles": 1, "doors": 1, "oocchat": 1, "icchat": 1}]'),
(2, 'Ranga bez lidera', 1, 0, 1, '[{"leader": 0, "vehicles": 1, "doors": 1, "oocchat": 1, "icchat": 1}]');

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
) ENGINE=MyISAM AUTO_INCREMENT=131 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=122 ROW_FORMAT=FIXED;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_items`
--

INSERT INTO `_items` (`ID`, `name`, `ownerType`, `owner`, `type`, `slotID`, `val1`, `val2`, `val3`, `volume`, `created`, `lastUsed`, `lastUsedID`, `used`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `interior`, `dimension`) VALUES
(1, 'Beretta 92FS', 1, 2, 1, 0, 24, 43, 'KANWT4G', 2, 1421875619, 1421875748, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

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
(26, 17, '89.79.217.0', '36FFDD46BC5D9F800B1750B6B1B242F4', 1422139414);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_orders`
--

CREATE TABLE IF NOT EXISTS `_orders` (
`ID` int(11) NOT NULL,
  `catID` int(11) NOT NULL,
  `data` longtext NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_orders`
--

INSERT INTO `_orders` (`ID`, `catID`, `data`, `price`, `name`) VALUES
(1, 1, '[ { "itemName": "Beretta 92FS", "itemType": 1, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 500, 'Beretta 92FS'),
(2, 1, '[ { "itemName": "Amunicja: Beretta 92FS", "itemType": 2, "itemVal1": 24, "itemVal2": 35, "itemVal3": "LSPD", "itemVolume": 2 } ]', 200, 'Amunicja: Beretta 92FS');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `_ordersCat`
--

CREATE TABLE IF NOT EXISTS `_ordersCat` (
`ID` int(11) NOT NULL,
  `orderType` int(11) NOT NULL,
  `orderOwner` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_ordersCat`
--

INSERT INTO `_ordersCat` (`ID`, `orderType`, `orderOwner`, `name`) VALUES
(1, 1, 0, 'Wyposażenie LSPD');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_shops`
--

INSERT INTO `_shops` (`ID`, `shopID`, `price`, `itemName`, `itemType`, `itemVal1`, `itemVal2`, `itemVal3`, `itemVolume`) VALUES
(1, 9, 20, 'Płyta CD', 0, 0, 0, '', 1);

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
  `damage` mediumtext NOT NULL,
  `interior` int(11) NOT NULL,
  `dimension` int(11) NOT NULL,
  `flashType` int(11) NOT NULL,
  `distance` float NOT NULL,
  `hasAlarm` tinyint(1) NOT NULL,
  `handbrake` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `_vehicles`
--

INSERT INTO `_vehicles` (`ID`, `name`, `ownerType`, `ownerID`, `c1r`, `c1g`, `c1b`, `c2r`, `c2g`, `c2b`, `model`, `hp`, `spawned`, `locked`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `v1`, `v2`, `fuel`, `damage`, `interior`, `dimension`, `flashType`, `distance`, `hasAlarm`, `handbrake`) VALUES
(1, 'Infernus', 1, 16, 255, 0, 0, 255, 255, 255, 411, 350, 0, 0, 2013.77, -1624.91, 14.6875, 223.693, 30.8771, 56.8762, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 0, 0),
(2, 'Sultan', 1, 18, 211, 167, 18, 255, 255, 255, 560, 794.5, 0, 0, 1510.06, -1692.16, 14.0469, 0, 0, 127.805, 0, 0, 50, '[ { "light4": 0, "panel7": 2, "panel3": 0, "door2": 2, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 1, "panel2": 0, "panel1": 1, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 1, "wheel2": 0, "door3": 1 } ]', 0, 0, 0, 0, 0, 0),
(6, 'Infernus', 1, 2, 224, 11, 11, 255, 255, 255, 411, 1000, 1, 1, 1535.93, -1666.04, 13.1099, 0, 0, 179.423, 0, 0, 50, '[ { "light4": 0, "panel7": 1, "panel3": 0, "door2": 2, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 1, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 1, 0),
(7, 'Sultan', 1, 2, 0, 255, 23, 255, 255, 255, 560, 1000, 1, 1, 1536.02, -1678, 13.0874, 359.868, 359.995, 359.841, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 1, 0, 1, 0),
(8, 'Premier', 1, 2, 223, 206, 21, 255, 255, 255, 426, 989, 0, 0, 1536.15, -1672.67, 13.0828, 359.978, 359.929, 358.352, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 2, "light2": 0, "wheel1": 0, "door4": 1, "door6": 0, "panel5": 0, "door1": 0, "door5": 1, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 1 } ]', 0, 0, 0, 0, 0, 0),
(9, 'Sultan', 1, 2, 255, 255, 255, 255, 255, 255, 560, 1000, 0, 1, 864.77, -1872.66, 6.31714, 0, 0, 0.482025, 0, 0, 50, '[ { "light4": 0, "panel7": 0, "panel3": 0, "door2": 0, "light2": 0, "wheel1": 0, "door4": 0, "door6": 0, "panel5": 0, "door1": 0, "door5": 0, "panel6": 0, "panel2": 0, "panel1": 0, "light3": 0, "wheel4": 0, "panel4": 0, "wheel3": 0, "light1": 0, "wheel2": 0, "door3": 0 } ]', 0, 0, 0, 0, 0, 0);

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
MODIFY `id_log` mediumint(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=121;
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
-- AUTO_INCREMENT dla tabeli `_delivers`
--
ALTER TABLE `_delivers`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_deposite`
--
ALTER TABLE `_deposite`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT dla tabeli `_doors`
--
ALTER TABLE `_doors`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT dla tabeli `_doorsPickup`
--
ALTER TABLE `_doorsPickup`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT dla tabeli `_groups`
--
ALTER TABLE `_groups`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'UID',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_groups_members`
--
ALTER TABLE `_groups_members`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT dla tabeli `_groups_ranks`
--
ALTER TABLE `_groups_ranks`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_intlist`
--
ALTER TABLE `_intlist`
MODIFY `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=131;
--
-- AUTO_INCREMENT dla tabeli `_items`
--
ALTER TABLE `_items`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_login_logs`
--
ALTER TABLE `_login_logs`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
--
-- AUTO_INCREMENT dla tabeli `_orders`
--
ALTER TABLE `_orders`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT dla tabeli `_ordersCat`
--
ALTER TABLE `_ordersCat`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT dla tabeli `_shops`
--
ALTER TABLE `_shops`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `_vehicles`
--
ALTER TABLE `_vehicles`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
