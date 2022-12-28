Libraries

- psycopg2
- pandas
- google-auth
- google-spreadsheet


------------------------------------------------------------------------------------------------

Goal Description

	Data has been captured by a user whenever there is a flow of money for a given day. Each transaction is recorded
	in there respective expense category like electricity, internet, heating, income etc. We want to move this data into 
	a database in a consumable format and create a report for gaining insight into a family's financial behaviour.

Execution Plan Step by Step

- Read data from a google sheet document
- Transform it to a format that consist of only 3 columns
		Expense Type (Income, Utilities, etc.)
		Date (date the transaction occured)
		Amount
		
- Load it into PostgreSQL database
- Pull data from PostgreSQL to Power BI for visualization and insights