import psycopg2


class Database:
    def __init__(self, user_, pasw, db, hst, tbl_name):
        self.user = user_
        self.password = pasw
        self.db = db
        self.host = hst
        self.connection = psycopg2.connect(user=self.user, password=self.password, database=self.db, host=self.host)
        self.table_name = tbl_name

    def save_to_database(self, t):
        with self.connection.cursor() as cursor:
            cursor.execute(""" INSERT INTO {0} ("Type", Dates, Amount) VALUES (%s,%s,%s) """.format(self.table_name),
                           t)

    def commit_to_db(self):
        self.connection.commit()
        self.connection.close()

    def delete_from_table(self):
        with self.connection.cursor() as cursor:
            cursor.execute(""" delete from {0} """.format(self.table_name))
