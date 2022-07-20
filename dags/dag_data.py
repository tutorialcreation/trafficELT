from sqlalchemy import create_engine
import pandas as pd
import os
from datetime import timedelta,datetime
import airflow
from airflow import DAG
from airflow.operators.python import PythonOperator


default_args={
    'owner':'martinluther',
    'retries':5,
    'retry_delay':timedelta(minutes=2)
}


def migrate_data(path,db_table):
    engine = create_engine(os.getenv('SQL_URL'), echo=True, future=True)
    df = pd.read_csv(path,sep="[,;:]",index_col=False)
    print("<<<<<<<<<<start migrating data>>>>>>>>>>>>>>")
    df.to_sql(db_table, con=engine, if_exists='replace',index_label='id')
    print("<<<<<<<<<<<<<<<<<<<completed>>>>>>>>>>>>>>>>")



with DAG(
    dag_id='dag_data',
    default_args=default_args,
    description='this dag handles data manipulations',
    start_date=airflow.utils.dates.days_ago(1),
    schedule_interval='@hourly'
)as dag:
    task1 = PythonOperator(
        task_id='greet',
        python_callable=migrate_data,
        op_kwargs={"path": "data/dataset.csv","db_table":"endpoints_trafficinfo"}
    )
    task1