

	--1. Records’ Count
/*-----------------------------------------------------*/
--Import the database and send the total count of records from the one and only table to Mr. Bodrog. Make sure nothing got lost.

SELECT COUNT(FirstName) AS Count
	FROM WizzardDeposits

	--2. Longest Magic Wand
/*-----------------------------------------------------*/
--Select the size of the longest magic wand. Rename the new column appropriately.

SELECT MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits

	--3. Longest Magic Wand Per Deposit Groups
/*-----------------------------------------------------*/

SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup