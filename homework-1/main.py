"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2


def to_postgresql(tab_name: str, tabs_info: list):
    connection = psycopg2.connect(
        database='north',
        user='postgres',
        password='Qw1'
    )

    try:
        with connection:
            with connection.cursor() as cur:
                # cols = '('
                # for i in range(0, len(tabs_info)):
                #     cols += "%s, "
                # cols = cols[:-2]
                # cols += ")"
                if len(tabs_info) == 3:
                    cur.execute(f'insert into {tab_name} values (%s, %s, %s)',
                                (tabs_info[0], tabs_info[1], tabs_info[2]))
                if len(tabs_info) == 5:
                    cur.execute(f'insert into {tab_name} values (%s, %s, %s, %s, %s)',
                                (tabs_info[0], tabs_info[1], tabs_info[2], tabs_info[3], tabs_info[4]))
                if len(tabs_info) == 6:
                    cur.execute(f'insert into {tab_name} values (%s, %s, %s, %s, %s, %s)',
                                (tabs_info[0], tabs_info[1], tabs_info[2], tabs_info[3], tabs_info[4], tabs_info[5]))
    finally:
        connection.close()


def read_to_sql(name: str):
    with open(f"north_data/{name}_data.csv", "r", encoding="UTF-8") as f:
        for i in f:
            if i == '"customer_id","company_name","contact_name"\n' or i == '"employee_id","first_name","last_name","title","birth_date","notes"\n' or i == '"order_id","customer_id","employee_id","order_date","ship_city"\n':
                continue
            info = i.lstrip('"').rstrip('"\n')
            info = info.replace('","', '   ').replace(',"', '   ').replace('",', '   ').split('   ')
            # print(info)
            to_postgresql(name, info)


read_to_sql('customers')
read_to_sql('employees')
read_to_sql('orders')
