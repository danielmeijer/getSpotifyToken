#! /bin/bash
echo "Hi!"
echo "Type here the scope that you want (More info: https://developer.spotify.com/web-api/using-scopes/)"
read scope
echo "enter ClientID"
read clientId
echo "enter ClientSecret"
read clientSecret
echo "enter redirect_uri"
read redirectUri

url1="https://accounts.spotify.com/authorize/?client_id=$clientId&response_type=code&redirect_uri=$redirectUri&scope=$scope"

if [ -f /usr/bin/firefox ]
then
echo "Ok, perfect, now I'm going to open your browser"
firefox $url1
else
echo "I cant find firefox installed in your system, dont worry this is optional, paste this in your browser and log in"
echo "$url1"
fi

echo "Enter when you're ready"
read enter1

echo "Nice! Please, give me the code next to 'code='"
read code

base64=$(echo $clientId:$clientSecret | awk 'BEGIN{ORS="";} {print}' | base64)

#result=$(curl -X POST -d 'grant_type=authorization_code&code=$code&redirect_uri=$redirectUri' -H 'Authorization: Basic $base64' 'https://accounts.spotify.com/api/token')
echo "---------------------------"
#echo $result
curl -X POST -d 'grant_type=authorization_code&code=$code&redirect_uri=$redirectUri' -H 'Authorization: Basic $base64' 'https://accounts.spotify.com/api/token'
echo "---------------------------"
echo "Nice you're done!"

echo "Do you want to try it? (Y/n)"
read test

if [ "$test" == "Y" -o "$test" == "y" ]
then
echo "Please enter the token received"
read token
echo "Ok, nice, here you go!"
sleep 1
clear
curl -H "Authorization: Bearer $token" https://api.spotify.com/v1/me
else
echo "Ok, have luck with your project!"
fi
