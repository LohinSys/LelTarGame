-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Létrehozás ideje: 2026. Feb 04. 11:03
-- Kiszolgáló verziója: 10.11.15-MariaDB-log
-- PHP verzió: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `flag` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `countries`
--

INSERT INTO `countries` (`id`, `name`, `flag`) VALUES
(1, 'Abkhazia', '🏴󠁧󠁥󠁡'),
(2, 'Afghanistan', '🇦🇫'),
(3, 'Albania', '🇦🇱'),
(4, 'Algeria', '🇩🇿'),
(5, 'Andorra', '🇦🇩'),
(6, 'Angola', '🇦🇴'),
(7, 'Antigue and Barbuda', '🇦🇬'),
(8, 'Argentina', '🇦🇷'),
(9, 'Armenia', '🇦🇲'),
(10, 'Australia', '🇦🇺'),
(11, 'Austria', '🇦🇹'),
(12, 'Azerbaijan', '🇦🇿'),
(13, 'Bahamas', '🇧🇸'),
(14, 'Bahrain', '🇧🇭'),
(15, 'Bangladesh', '🇧🇩'),
(16, 'Barbados', '🇧🇧'),
(17, 'Belarus', '🇧🇾'),
(18, 'Belgium', '🇧🇪'),
(19, 'Belize', '🇧🇿'),
(20, 'Benin', '🇧🇯'),
(21, 'Bhutan', '🇧🇹'),
(22, 'Bolivia', '🇧🇴'),
(23, 'Bosnia and Herzegovina', '🇧🇦'),
(24, 'Botswana', '🇧🇼'),
(25, 'Brazil', '🇧🇷'),
(26, 'Brunei', '🇧🇳'),
(27, 'Bulgaria', '🇧🇬'),
(28, 'Burkina Faso', '🇧🇫'),
(29, 'Burundi', '🇧🇮'),
(30, 'Cambodia', '🇰🇭'),
(31, 'Cameroon', '🇨🇲'),
(32, 'Canada', '🇨🇦'),
(33, 'Cape Verde', '🇨🇻'),
(34, 'Central African Republic', '🇨🇫'),
(35, 'Chad', '🇹🇩'),
(36, 'Chile', '🇨🇱'),
(37, 'China', '🇨🇳'),
(38, 'Colombia', '🇨🇴'),
(39, 'Comoros', '🇰🇲'),
(40, 'Cook Islands', '🇨🇰'),
(41, 'Costa Rica', '🇨🇷'),
(42, 'Croatia', '🇭🇷'),
(43, 'Cuba', '🇨🇺'),
(44, 'Cyprus', '🇨🇾'),
(45, 'Czech Republic', '🇨🇿'),
(46, 'Democratic Republic of the Congo', '🇨🇩'),
(47, 'Denmark', '🇩🇰'),
(48, 'Djibouti', '🇩🇯'),
(49, 'Dominica', '🇩🇲'),
(50, 'Dominican Republic', '🇩🇴'),
(51, 'Ecuador', '🇪🇨'),
(52, 'Egypt', '🇪🇬'),
(53, 'El Salvador', '🇸🇻'),
(54, 'Equatorial Guinea', '🇬🇶'),
(55, 'Eritrea', '🇪🇷'),
(56, 'Estonia', '🇪🇪'),
(57, 'Eswatini', '🇸🇿'),
(58, 'Ethiopia', '🇪🇹'),
(59, 'Fiji', '🇫🇯'),
(60, 'Finland', '🇫🇮'),
(61, 'France', '🇫🇷'),
(62, 'Gabon', '🇬🇦'),
(63, 'Gambia', '🇬🇲'),
(64, 'Georgia', '🇬🇪'),
(65, 'Germany', '🇩🇪'),
(66, 'Ghana', '🇬🇭'),
(67, 'Greece', '🇬🇷'),
(68, 'Grenada', '🇬🇩'),
(69, 'Guatemala', '🇬🇹'),
(70, 'Guinea', '🇬🇳'),
(71, 'Guinea-Bissau', '🇬🇼'),
(72, 'Guyana', '🇬🇾'),
(73, 'Haiti', '🇭🇹'),
(74, 'Honduras', '🇭🇳'),
(75, 'Hungary', '🇭🇺'),
(76, 'Iceland', '🇮🇸'),
(77, 'India', '🇮🇳'),
(78, 'Indonesia', '🇮🇩'),
(79, 'Iran', '🇮🇷'),
(80, 'Iraq', '🇮🇶'),
(81, 'Ireland', '🇮🇪'),
(82, 'Israel', '🇮🇱'),
(83, 'Italy', '🇮🇹'),
(84, 'Antarctica', '🇦🇶'),
(85, 'Jamaica', '🇯🇲'),
(86, 'Japan', '🇯🇵'),
(87, 'Jordan', '🇯🇴'),
(88, 'Kazakhstan', '🇰🇿'),
(89, 'Kenya', '🇰🇪'),
(90, 'Kiribati', '🇰🇮'),
(91, 'Kosovo', '🇽🇰'),
(92, 'Kuwait', '🇰🇼'),
(93, 'Kyrgyzstan', '🇰🇬'),
(94, 'Laos', '🇱🇦'),
(95, 'Latvia', '🇱🇻'),
(96, 'Lebanon', '🇱🇧'),
(97, 'Lesotho', '🇱🇸'),
(98, 'Liberia', '🇱🇷'),
(99, 'Libya', '🇱🇾'),
(100, 'Liechtenstein', '🇱🇮'),
(101, 'Lithuania', '🇱🇹'),
(102, 'Luxembourg', '🇱🇺'),
(103, 'Madagascar', '🇲🇬'),
(104, 'Malawi', '🇲🇼'),
(105, 'Malaysia', '🇲🇾'),
(106, 'Maldives', '🇲🇻'),
(107, 'Mali', '🇲🇱'),
(108, 'Malta', '🇲🇹'),
(109, 'Marshall Islands', '🇲🇭'),
(110, 'Mauritania', '🇲🇷'),
(111, 'Mauritius', '🇲🇺'),
(112, 'Mexico', '🇲🇽'),
(113, 'Micronesia', '🇫🇲'),
(114, 'Moldova', '🇲🇩'),
(115, 'Monaco', '🇲🇨'),
(116, 'Mongolia', '🇲🇳'),
(117, 'Montenegro', '🇲🇪'),
(118, 'Morocco', '🇲🇦'),
(119, 'Mozambique', '🇲🇿'),
(120, 'Myanmar', '🇲🇲'),
(121, 'Namibia', '🇳🇦'),
(122, 'Nauru', '🇳🇷'),
(123, 'Nepal', '🇳🇵'),
(124, 'Netherlands', '🇳🇱'),
(125, 'New Zealand', '🇳🇿'),
(126, 'Nicaragua', '🇳🇮'),
(127, 'Niger', '🇳🇪'),
(128, 'Nigeria', '🇳🇬'),
(129, 'Niue', '🇳🇺'),
(130, 'North Korea', '🇰🇵'),
(131, 'North Macedonia', '🇲🇰'),
(132, 'Isle of Man', '🇮🇲'),
(133, 'Norway', '🇳🇴'),
(134, 'Oman', '🇴🇲'),
(135, 'Pakistan', '🇵🇰'),
(136, 'Palau', '🇵🇼'),
(137, 'Palestine', '🇵🇸'),
(138, 'Panama', '🇵🇦'),
(139, 'Papua New Guinea', '🇵🇬'),
(140, 'Paraguay', '🇵🇾'),
(141, 'Peru', '🇵🇪'),
(142, 'Philippines', '🇵🇭'),
(143, 'Poland', '🇵🇱'),
(144, 'Portugal', '🇵🇹'),
(145, 'Qatar', '🇶🇦'),
(146, 'Republic of the Congo', '🇨🇬'),
(147, 'Romania', '🇷🇴'),
(148, 'Russia', '🇷🇺'),
(149, 'Rwanda', '🇷🇼'),
(150, 'Ascension Island', '🇦🇨'),
(151, 'St. Kitts and Nevis', '🇰🇳'),
(152, 'St. Lucia', '🇱🇨'),
(153, 'St. Vincent and the Grenadines', '🇻🇨'),
(154, 'Samoa', '🇼🇸'),
(155, 'San Marino', '🇸🇲'),
(156, 'São Tomé and Príncipe', '🇸🇹'),
(157, 'Saudi Arabia', '🇸🇦'),
(158, 'Senegal', '🇸🇳'),
(159, 'Serbia', '🇷🇸'),
(160, 'Seychelles', '🇸🇨'),
(161, 'Sierra Leone', '🇸🇱'),
(162, 'Singapore', '🇸🇬'),
(163, 'Slovakia', '🇸🇰'),
(164, 'Slovenia', '🇸🇮'),
(165, 'Solomon Islands', '🇸🇧'),
(166, 'Somalia', '🇸🇴'),
(167, 'Greenland', '🇬🇱'),
(168, 'South Africa', '🇿🇦'),
(169, 'South Korea', '🇰🇷'),
(170, 'South Sudan', '🇸🇸'),
(171, 'Mayotte', '🇾🇹'),
(172, 'Spain', '🇪🇸'),
(173, 'Sri Lanka', '🇱🇰'),
(174, 'Sudan', '🇸🇩'),
(175, 'Suriname', '🇸🇷'),
(176, 'Sweden', '🇸🇪'),
(177, 'Switzerland', '🇨🇭'),
(178, 'Syria', '🇸🇾'),
(179, 'Taiwan', '🇹🇼'),
(180, 'Tajikistan', '🇹🇯'),
(181, 'Tanzania', '🇹🇿'),
(182, 'Thailand', '🇹🇭'),
(183, 'Timor-Leste', '🇹🇱'),
(184, 'Togo', '🇹🇬'),
(185, 'Tonga', '🇹🇴'),
(186, 'Transnistria', '🏴󠁭󠁤󠁳'),
(187, 'Trinidad and Tobago', '🇹🇹'),
(188, 'Tunisia', '🇹🇳'),
(189, 'Turkey', '🇹🇷'),
(190, 'Turkmenistan', '🇹🇲'),
(191, 'Tuvalu', '🇹🇻'),
(192, 'Uganda', '🇺🇬'),
(193, 'Ukraine', '🇺🇦'),
(194, 'United Arab Emirates', '🇦🇪'),
(195, 'United Kingdom', '🇬🇧'),
(196, 'United States of America', '🇺🇸'),
(197, 'Uruguay', '🇺🇾'),
(198, 'Uzbekistan', '🇺🇿'),
(199, 'Vanuatu', '🇻🇺'),
(200, 'Vatican City', '🇻🇦'),
(201, 'Venezuela', '🇻🇪'),
(202, 'Vietnam', '🇻🇳'),
(203, 'Yemen', '🇾🇪'),
(204, 'Zambia', '🇿🇲'),
(205, 'Zimbabwe', '🇿🇼');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `difficulties`
--

CREATE TABLE `difficulties` (
  `id` int(11) NOT NULL,
  `difficultyName` varchar(24) NOT NULL,
  `description` text NOT NULL,
  `icon` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `difficulties`
--

INSERT INTO `difficulties` (`id`, `difficultyName`, `description`, `icon`) VALUES
(1, 'Easy', 'Aimed at beginners, however the final stage is inaccessible here.', '💚'),
(2, 'Normal', 'The intended base difficulty, aimed at those who are average at bullet hell games.', '💙'),
(3, 'Hard', 'Near arcade difficulty, aimed at those who\'s very experienced in bullet hell games.', '❤'),
(4, 'Lunatic', 'Ridiculously difficult, not for the faint of heart.', '💜');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lb`
--

CREATE TABLE `lb` (
  `id` bigint(20) NOT NULL,
  `usernameID` bigint(20) NOT NULL,
  `score` bigint(20) NOT NULL,
  `difficultyID` int(11) NOT NULL,
  `achievedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `lb`
--

INSERT INTO `lb` (`id`, `usernameID`, `score`, `difficultyID`, `achievedAt`) VALUES
(1, 1, 625500, 3, '2025-11-18 13:56:00'),
(2, 2, 1232600, 4, '2026-01-21 16:03:32'),
(3, 3, 986450, 4, '2026-01-14 13:56:01'),
(4, 4, 502850, 2, '2025-12-10 12:00:09');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(32) NOT NULL,
  `email` varchar(256) NOT NULL,
  `password` varchar(1024) NOT NULL,
  `countryID` int(11) NOT NULL,
  `createdAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `countryID`, `createdAt`) VALUES
(1, 'test_account', 'billgatessexyhunk@hotmail.com', 'sk1ptamal00-shamalamad1ngd0ng!', 195, '2025-11-18 13:55:09'),
(2, 'Ellie9192', 'ship.ur.pants@kmart.com', 'yx>đ]>đ]ł>$Ł]>#]$>xkbíä$ä', 32, '2026-01-07 09:22:26'),
(3, 'xXx_DemonSlayer124_xXx', 'kitana.she.no.means.goat@gmail.com', ',léxcnáácénáéxcnáééánáévnáéác', 176, '2026-01-07 09:22:26'),
(4, 'gamerboy87', 'noreply@dominos.com', 'techn0blade_', 196, '2026-01-07 09:26:30'),
(5, 'sz5ylv1a', 'flandre.scarlet@420blaze.it', 'thatisareal3mailiswear_', 75, '2026-01-07 09:27:49');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `difficulties`
--
ALTER TABLE `difficulties`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `lb`
--
ALTER TABLE `lb`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usernameID` (`usernameID`),
  ADD KEY `difficultyID` (`difficultyID`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `countryID` (`countryID`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=206;

--
-- AUTO_INCREMENT a táblához `difficulties`
--
ALTER TABLE `difficulties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `lb`
--
ALTER TABLE `lb`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `lb`
--
ALTER TABLE `lb`
  ADD CONSTRAINT `lb_ibfk_1` FOREIGN KEY (`difficultyID`) REFERENCES `difficulties` (`id`),
  ADD CONSTRAINT `lb_ibfk_2` FOREIGN KEY (`usernameID`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`countryID`) REFERENCES `countries` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
