from django.shortcuts import render

# Create your views here.

def index(request):
    # testing main page
    return render(request,'index.html')