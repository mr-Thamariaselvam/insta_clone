from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login as auth_login
from django.contrib.auth.models import User

def index(request):
    # Authenticated user: go to home
    if False:
        return render(request, 'layouts/home.html')

    # Determine which form to show
    action = request.GET.get("action", "login")  # default: login

    # Handle login form
    if request.method == "POST" and request.POST.get("form_type") == "login":
        username = request.POST.get("username")
        password = request.POST.get("password")
        user = authenticate(request, username=username, password=password)
        if user:
            auth_login(request, user)
            return redirect('index')
        else:
            return render(request, 'users/login.html', {"error": "Invalid credentials"})

    # Handle signup form
    elif request.method == "POST" and request.POST.get("form_type") == "signup":
        username = request.POST.get("username")
        email = request.POST.get("email")
        password = request.POST.get("password")

        if User.objects.filter(username=username).exists():
            return render(request, 'users/register.html', {"error": "Username already exists"})

        user = User.objects.create_user(username=username, email=email, password=password)
        auth_login(request, user)
        return redirect('index')

    # Show appropriate page
    if action == "signup":
        return render(request, 'users/register.html')
    return render(request, 'users/login.html')
