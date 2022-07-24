from django.db import models
from geopy.geocoders import Nominatim
from django.utils.translation import gettext as _
from django.utils.translation import activate, get_language_info
from googletrans import Translator, constants

class Location(models.Model):
    landmarks = models.TextField()
    address = models.CharField(max_length=255)
    place = models.CharField(max_length=255)



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
    location = models.ForeignKey(Location,on_delete=models.CASCADE,null=True,blank=True)

    @property
    def find_location(self):
        geolocator = Nominatim(user_agent="geoapiExercises")
        location = geolocator.geocode(str(self.lat)+","+str(self.lon))
        res,address = [],[]
        for i,x in enumerate(location):
            if i==0:
                for add in x.split(','):
                    if add.isdigit():
                        address.append(add)
                    else:
                        res.append(add.lstrip())
        translator = Translator()
       
        translated = []
        for val in res:
            translation = translator.translate(val)
            translated.append(translation.text)

        obj,_ = Location.objects.update_or_create(
            landmarks = translated[:len(translated)-2],
            address = translated[-2],
            place = translated[-1]
        )
        self.location = obj
        self.save()

        return translated
    
