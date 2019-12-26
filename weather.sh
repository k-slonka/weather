#!/bin/bash
LOKALIZACJA=Poznan
FARENHEIT=false
DYNAMIC_UPDATE=false


echo "wpisz kod"
read APIXUKEY


while getopts ":l:df" OPT; do
case $OPT in
l) LOKALIZACJA=$OPTARG;;
d) DYNAMIC_UPDATE=true;;
f) FARENHEIT=true;;
\?) 
echo "źle: - $OPTARG" >&2
exit 1 ;;
:) 
echo "opcja -$OPTARG wymaga argumentu.">&2
shift;;
esac
done

mod=$(stat -c %Y pogoda.json)
modd=$(($mod+3))
teraz=$(date "+%s")
nazwa=$(jq ".[] | [{name}]" pogoda.json)
namee=$( cat pogoda.json | jq '.location' |jq -r .'name'  )

if [[ $teraz > $modd || $LOKALIZACJA != $namee ]]
then 
wget  -O pogoda.json 'https://api.apixu.com/v1/current.json?key='$APIXUKEY'&q='$LOKALIZACJA
fi

GREEN=$(tput setaf 2)
BLUE=$(tput setaf 3)
GREEN2=$(tput setaf 155)

NAME=$(cat pogoda.json | jq '.location' |jq -r .'name')
COUNTRY=$(cat pogoda.json | jq '.location' |jq -r .'country') 
TEXT=$(cat pogoda.json | jq '.current' |jq '.condition' |jq -r .'text')
CLOUD=$(cat pogoda.json | jq '.current' |jq -r .'cloud')
HUMIDITY=$(cat pogoda.json | jq '.current' |jq -r .'humidity')
wind_degree=$(cat pogoda.json | jq '.current' |jq -r .'wind_degree')
WIND=$(cat pogoda.json | jq '.current' |jq -r .'wind_dir')

temp=$(cat pogoda.json | jq '.current' |jq -r .'temp_f')
feelslike_f=$(cat pogoda.json | jq '.current' |jq -r .'feelslike_f')
wind_kph=$(cat pogoda.json | jq '.current' |jq -r .'wind_kph')
pressure_in=$(cat pogoda.json | jq '.current' |jq -r .'pressure_in')
precip_in=$(cat pogoda.json | jq '.current' |jq -r .'precip_in')
vis_miles=$(cat pogoda.json | jq '.current' |jq -r .'vis_miles')

temp=$(cat pogoda.json | jq '.current' |jq -r .'temp_c')
feelslike_c=$(cat pogoda.json | jq '.current' |jq -r .'feelslike_c')
wind_mph=$(cat pogoda.json | jq '.current' |jq -r .'wind_mph')
pressure_mb=$(cat pogoda.json | jq '.current' |jq -r .'pressure_mb')
precip_mm=$(cat pogoda.json | jq '.current' |jq -r .'precip_mm')
vis_km=$(cat pogoda.json | jq '.current' |jq -r .'vis_km')

if ($DYNAMIC_UPDATE == true && $FARENHEIT == true)
then 
while :
do
wget -O pogoda.json 'https://api.apixu.com/v1/current.json?key='$APIXUKEY'&q='$LOKALIZACJA
echo -e "       $GREEN2 LOKALIZACJA\n""$GREEN Miasto:""$BLUE $NAME\n""$GREEN Kraj:""$BLUE $COUNTRY\n""       $GREEN2 DANE POGODOWE\n""$GREEN Opis:""$BLUE $TEXT\n""$GREEN Zachmurzenie:""$BLUE $CLOUD\n""$GREEN Wilgotność:""$BLUE $HUMIDITY\n""$GREEN Kierunek wiatru:""$BLUE $wind_degree °\n""$GREEN kierunek wiatru:""$BLUE $WIND\n" 
echo -e "       $GREEN2 JEDNOSTKI AMERYKAŃSKIE\n""$GREEN Temperatura:""$BLUE $temp F\n""$GREEN Temperatura odczuwalna:""$BLUE $feelslike_c F\n""$GREEN Prędkość wiatru:""$BLUE $wind_kph kph\n""$GREEN Ciśnienie:""$BLUE $pressure_in in\n""$GREEN Opady:""$BLUE $precip_in in\n""$GREEN Vis:""$BLUE $vis_miles miles"
sleep 5m
done
else
if($DYNAMIC_UPDATE == true)
then
while :
do
wget -O pogoda.json 'https://api.apixu.com/v1/current.json?key='$APIXUKEY'&q='$LOKALIZACJA
echo -e "       $GREEN2 LOKALIZACJA\n""$GREEN Miasto:""$BLUE $NAME\n""$GREEN Kraj:""$BLUE $COUNTRY\n""       $GREEN2 DANE POGODOWE\n""$GREEN Opis:""$BLUE $TEXT\n""$GREEN Zachmurzenie:""$BLUE $CLOUD\n""$GREEN Wilgotność:""$BLUE $HUMIDITY\n""$GREEN Kierunek wiatru:""$BLUE $wind_degree °\n""$GREEN kierunek wiatru:""$BLUE $WIND\n" 
echo -e "       $GREEN2 JEDNOSTKI POLSKIE\n""$GREEN Temperatura:""$BLUE $temp C\n""$GREEN Temperatura odczuwalna:""$BLUE $feelslike_c C\n""$GREEN Prędkość wiatru:""$BLUE $wind_mph mph\n""$GREEN Ciśnienie:""$BLUE $pressure_mb mb\n""$GREEN Opady:""$BLUE $precip_mm mm\n""$GREEN Vis:""$BLUE $vis_km km"
sleep 5m
done
else 
if($FARENHEIT == true)
then 
echo -e "       $GREEN2 LOKALIZACJA\n""$GREEN Miasto:""$BLUE $NAME\n""$GREEN Kraj:""$BLUE $COUNTRY\n""       $GREEN2 DANE POGODOWE\n""$GREEN Opis:""$BLUE $TEXT\n""$GREEN Zachmurzenie:""$BLUE $CLOUD\n""$GREEN Wilgotność:""$BLUE $HUMIDITY\n""$GREEN Kierunek wiatru:""$BLUE $wind_degree °\n""$GREEN kierunek wiatru:""$BLUE $WIND\n" 
echo -e "       $GREEN2 JEDNOSTKI AMERYKAŃSKIE\n""$GREEN Temperatura:""$BLUE $temp F\n""$GREEN Temperatura odczuwalna:""$BLUE $feelslike_c F\n""$GREEN Prędkość wiatru:""$BLUE $wind_kph kph\n""$GREEN Ciśnienie:""$BLUE $pressure_in in\n""$GREEN Opady:""$BLUE $precip_in in\n""$GREEN Vis:""$BLUE $vis_miles miles"
else
echo -e "       $GREEN2 LOKALIZACJA\n""$GREEN Miasto:""$BLUE $NAME\n""$GREEN Kraj:""$BLUE $COUNTRY\n""       $GREEN2 DANE POGODOWE\n""$GREEN Opis:""$BLUE $TEXT\n""$GREEN Zachmurzenie:""$BLUE $CLOUD\n""$GREEN Wilgotność:""$BLUE $HUMIDITY\n""$GREEN Kierunek wiatru:""$BLUE $wind_degree °\n""$GREEN kierunek wiatru:""$BLUE $WIND\n" 
echo -e "       $GREEN2 JEDNOSTKI POLSKIE\n""$GREEN Temperatura:""$BLUE $temp C\n""$GREEN Temperatura odczuwalna:""$BLUE $feelslike_c C\n""$GREEN Prędkość wiatru:""$BLUE $wind_mph mph\n""$GREEN Ciśnienie:""$BLUE $pressure_mb mb\n""$GREEN Opady:""$BLUE $precip_mm mm\n""$GREEN Vis:""$BLUE $vis_km km"
fi
fi
fi
