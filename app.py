import gsheet_reader as g
import database as db
import transform
import json


with open('user_credentials') as f:
    data = json.load(f)

sheet_id = data["Google Sheets"][0]["sheet_id"]
sheet_name = data["Google Sheets"][0]["sheet_name"]
dct = g.read_google_sheet(sheet_id, sheet_name)

expenses = transform.transform_dict(dct)

d = db.Database(user_=data["Postgresql"][0]["user_id"],
                pasw=data["Postgresql"][0]["password"],
                db=data["Postgresql"][0]["db"],
                hst=data["Postgresql"][0]["hst"],
                tbl_name=data["Postgresql"][0]["tbl_name"])
d.delete_from_table()

for i in range(0, len(expenses.keys())):
    d.save_to_database(expenses[i])

d.commit_to_db()
