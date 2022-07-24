# Generated by Django 4.0.6 on 2022-07-21 02:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('endpoints', '0003_location_trafficinfo_location'),
    ]

    operations = [
        migrations.RenameField(
            model_name='location',
            old_name='county',
            new_name='country',
        ),
        migrations.RemoveField(
            model_name='location',
            name='lat',
        ),
        migrations.RemoveField(
            model_name='location',
            name='lon',
        ),
        migrations.AddField(
            model_name='location',
            name='address',
            field=models.CharField(default='', max_length=255),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='location',
            name='area',
            field=models.TextField(default=''),
            preserve_default=False,
        ),
    ]
