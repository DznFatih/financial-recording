from datetime import datetime


def transform_dict(dct):
    i = 0
    y = -1
    t = 0
    expenses = {}
    exp_name = ""
    z = 0
    ex = []
    while z != len(dct["Expense Name"]):
        for key, value in dct.items():
            if key == "Expense Name":
                exp_name = (value[i])
                y += 1
            if key != "Expense Name":
                ex.append(exp_name)  # Expense Name
                d = datetime.strptime(key, '%d/%m/%Y').date()
                ex.append(d)  # Date
                if value[y] != value[y]:  # Amount
                    ex.append(0)
                else:
                    ex.append(value[y])
                expenses[t] = ex
                ex = []
                t += 1
            if value[i] == "Total":
                break
        i += 1
        z += 1
    return expenses
