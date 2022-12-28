import pandas as pd


def read_google_sheet(g_id, sht_name):
    g_sheet_id = g_id
    sheet_name = sht_name
    gsheet_url = 'https://docs.google.com/spreadsheets/d/{}/gviz/tq?tqx=out:csv&sheet={}'.format(g_sheet_id, sheet_name)
    df = pd.read_csv(gsheet_url)
    dct = df.to_dict()
    del dct["Unnamed: 1"]
    return dct

