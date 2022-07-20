from django.db import models

# Create your models here.
class TrafficInfo(models.Model):
    track_id = models.AutoField(primary_key=True) 
    type = models.CharField(max_length=255) 
    traveled_d = models.FloatField()
    avg_speed  = models.FloatField()
    lat = models.FloatField()
    lon = models.FloatField()
    speed = models.FloatField()
    lon_acc = models.FloatField()
    lat_acc = models.FloatField()
    time = models.FloatField()