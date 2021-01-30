

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
--For wizards in each deposit group show the longest magic wand. Rename the new column appropriately.

SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
	FROM WizzardDeposits
	GROUP BY DepositGroup


	--4. * Smallest Deposit Group Per Magic Wand Size
/*-----------------------------------------------------*/
--Select the two deposit groups with the lowest average wand size.

SELECT TOP(2) DepositGroup
	FROM (
			SELECT DepositGroup, AVG(MagicWandSize) AS MWS
				FROM WizzardDeposits
				GROUP BY DepositGroup
		 ) AS A
		 ORDER BY MWS

	
--SELECT TOP(2) DepositGroup 
--	FROM WizzardDeposits
--	GROUP BY DepositGroup
--	ORDER BY AVG(MagicWandSize)