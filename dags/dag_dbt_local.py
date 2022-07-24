from datetime import timedelta
import airflow
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from airflow.operators.dummy import DummyOperator
from airflow.utils.dates import timedelta


with DAG(
    dag_id='dbt_dag',
    start_date=airflow.utils.dates.days_ago(1),
    description='An Airflow DAG for simple dag connections',
    schedule_interval=timedelta(days=1),
) as dag:
    extract = DummyOperator(task_id="extract")
    load = DummyOperator(task_id="load")
    ml_training = DummyOperator(task_id="ml_training")

    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='dbt run'
    )

    dbt_test = BashOperator(
        task_id='dbt_test',
        bash_command='dbt test'
    )
    extract >> load >> dbt_run >> ml_training