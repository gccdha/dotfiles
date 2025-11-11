#!/bin/bash

# TODO: for below click things, figure out how
# to end this program so I don't accumulate
# proccesses every 10 min

# on click: moon phase, moonrise/set, lunar
# eclipse, (stars for when moon is not out
# and moon for when it is), meteor if there
# is a shower (need a seperate API)
# https://aa.usno.navy.mil/data/api

# on next click: hourly forcast, w/ clock symbols

# on mid click: switch units

get_icon() { #this function takes the codes given by the API and converts them to icons.
    if [ "$2" = "day" ]; then
        case $1 in
        	# Icons for weather-icons (DAY)
        	200) icon="";; #(D)thunderstorm w/ light rain
       		201) icon="";; #thunderstorm w/ rain
        	202) icon="";; #thunderstorm w/ heavy rain
        	210) icon="";; #(D)light thunderstorm
        	211) icon="";; #thunderstorm
        	212) icon="";; #heavy thunderstorm
        	221) icon="";; #(D)ragged thunderstorm
        	230) icon="";; #(D)thunderstorm w/ light drizzle
        	231) icon="";; #thunderstorm w/ drizzle
        	232) icon="";; #thunderstorm w/ heavy drizzle
        	300) icon="";; #(D)light drizzle
        	301) icon="";; #(D)drizzle
        	302) icon="";; #heavy drizzle
        	310) icon="";; #(D)light drizzle rain
        	311) icon="";; #(D)drizzle rain
        	312) icon="";; #heavy drizzle rain
        	313) icon="";; #shower rain drizzle
        	314) icon="";; #heavy shower rain drizzle
        	321) icon="";; #(D)shower drizzle
        	500) icon="";; #(D)light rain
        	501) icon="";; #(D)moderate rain
        	502) icon="";; #heavy rain
        	503) icon="";; #very heavy rain
        	504) icon="";; #extreme rain
        	511) icon="";; #freezing rain
        	520) icon="";; #(D)light shower rain
        	521) icon="";; #(D)shower rain
        	522) icon="";; #heavy shower rain
        	531) icon="";; #ragged shower rain
        	600) icon="";; #(D)light snow
        	601) icon="";; #snow
        	602) icon="";; #heavy snow
        	611) icon="";; #sleet
        	612) icon="";; #(D)light sleet shower
        	613) icon="";; #sleet shower
        	615) icon="";; #(D)light mix
        	616) icon="";; #mix
        	620) icon="";; #(D)light snow shower
        	621) icon="";; #(D)snow shower
        	622) icon="";; #heavy snow shower
        	701) icon="";; #(D)mist
        	711) icon="";; #smoke
        	721) icon="";; #(D)haze
        	731) icon="";; #sand/dust whirls
        	741) icon="";; #fog
        	751) icon="";; #sand
        	761) icon="";; #dust
        	762) icon="";; #ash
        	771) icon="";; #squall
        	781) icon="";; #tornado
        	800) icon="";; #(D)clear            <11%
        	801) icon="";; #(D)few clouds       11-25%
        	802) icon="";; #(D)scattered clouds 25-50%
        	803) icon="";; #broken clouds       51-84%
        	804) icon="";; #overcast            85-100%
        	*) icon=""; #if none
	esac
    echo $icon
    elif [ "$2" = "night" ]; then

        case $1 in
        	# Icons for weather-icons (NIGHT)
        	200) icon="";; #(N)thunderstorm w/ light rain
       		201) icon="";; #thunderstorm w/ rain
        	202) icon="";; #thunderstorm w/ heavy rain
        	210) icon="";; #(N)light thunderstorm
        	211) icon="";; #thunderstorm
        	212) icon="";; #heavy thunderstorm
        	221) icon="";; #(N)ragged thunderstorm
        	230) icon="";; #(N)thunderstorm w/ light drizzle
        	231) icon="";; #thunderstorm w/ drizzle
        	232) icon="";; #thunderstorm w/ heavy drizzle
        	300) icon="";; #(N)light drizzle
        	301) icon="";; #(N)drizzle
        	302) icon="";; #heavy drizzle
        	310) icon="";; #(N)light drizzle rain
        	311) icon="";; #(N)drizzle rain
        	312) icon="";; #heavy drizzle rain
        	313) icon="";; #shower rain drizzle
        	314) icon="";; #heavy shower rain drizzle
        	321) icon="";; #(N)shower drizzle
        	500) icon="";; #(N)light rain
        	501) icon="";; #(N)moderate rain
        	502) icon="";; #heavy rain
        	503) icon="";; #very heavy rain
        	504) icon="";; #extreme rain
        	511) icon="";; #freezing rain
        	520) icon="";; #(N)light shower rain
        	521) icon="";; #(N)shower rain
        	522) icon="";; #heavy shower rain
        	531) icon="";; #ragged shower rain
        	600) icon="";; #(N)light snow
        	601) icon="";; #snow
        	602) icon="";; #heavy snow
        	611) icon="";; #sleet
        	612) icon="";; #(N)light sleet shower
        	613) icon="";; #sleet shower
        	615) icon="";; #(N)light mix
        	616) icon="";; #mix
        	620) icon="";; #(N)light snow shower
        	621) icon="";; #(N)snow shower
        	622) icon="";; #heavy snow shower
        	701) icon="";; #(N)mist
        	711) icon="";; #smoke
        	721) icon="";; #(N)haze
        	731) icon="";; #sand/dust whirls
        	741) icon="";; #fog
        	751) icon="";; #sand
        	761) icon="";; #dust
        	762) icon="";; #ash
        	771) icon="";; #squall
        	781) icon="";; #tornado
        	800) icon="";; #(N)clear            <11%
        	801) icon="";; #(N)few clouds       11-25%
        	802) icon="";; #(N)scattered clouds 25-50%
        	803) icon="";; #broken clouds       51-84%
        	804) icon="";; #overcast            85-100%
        	*) icon=""; #if none
	esac
    echo $icon
    else

        case $1 in
        	# Icons for weather-icons (NEUTRAL)
        	200) icon="";; #(0)thunderstorm w/ light rain
       		201) icon="";; #thunderstorm w/ rain
        	202) icon="";; #thunderstorm w/ heavy rain
        	210) icon="";; #(0)light thunderstorm
        	211) icon="";; #thunderstorm
        	212) icon="";; #heavy thunderstorm
        	221) icon="";; #(0)ragged thunderstorm
        	230) icon="";; #(0)thunderstorm w/ light drizzle
        	231) icon="";; #thunderstorm w/ drizzle
        	232) icon="";; #thunderstorm w/ heavy drizzle
        	300) icon="";; #(0)light drizzle
        	301) icon="";; #(0)drizzle
        	302) icon="";; #heavy drizzle
        	310) icon="";; #(0)light drizzle rain
        	311) icon="";; #(0)drizzle rain
        	312) icon="";; #heavy drizzle rain
        	313) icon="";; #shower rain drizzle
        	314) icon="";; #heavy shower rain drizzle
        	321) icon="";; #(0)shower drizzle
        	500) icon="";; #(0)light rain
        	501) icon="";; #(0)moderate rain
        	502) icon="";; #heavy rain
        	503) icon="";; #very heavy rain
        	504) icon="";; #extreme rain
        	511) icon="";; #freezing rain
        	520) icon="";; #(0)light shower rain
        	521) icon="";; #(0)shower rain
        	522) icon="";; #heavy shower rain
        	531) icon="";; #ragged shower rain
        	600) icon="";; #(0)light snow
        	601) icon="";; #snow
        	602) icon="";; #heavy snow
        	611) icon="";; #sleet
        	612) icon="";; #(0)light sleet shower
        	613) icon="";; #sleet shower
        	615) icon="";; #(0)light mix
        	616) icon="";; #mix
        	620) icon="";; #(0)light snow shower
        	621) icon="";; #(0)snow shower
        	622) icon="";; #heavy snow shower
        	701) icon="";; #(0)mist
        	711) icon="";; #smoke
        	721) icon="";; #(0)haze
        	731) icon="";; #sand/dust whirls
        	741) icon="";; #fog
        	751) icon="";; #sand
        	761) icon="";; #dust
        	762) icon="";; #ash
        	771) icon="";; #squall
        	781) icon="";; #tornado
        	800) icon="";; #(0)clear            <11%
        	801) icon="";; #(0)few clouds       11-25%
        	802) icon="";; #(0)scattered clouds 25-50%
        	803) icon="";; #broken clouds       51-84%
        	804) icon="";; #overcast            85-100%
        	*) icon=""; #if none
	esac
    echo $icon
    fi
}
get_wind() {
    if [ $1 -gt "338" ]; then
	icon="" #N
    elif [ $1 -gt "293" ]; then
	icon="" #NW
    elif [ $1 -gt "248" ]; then
        icon="" #W
    elif [ $1 -gt "203" ]; then
        icon="" #SW
    elif [ $1 -gt "158" ]; then
        icon="" #S
    elif [ $1 -gt "113" ]; then
        icon="" #SE
    elif [ $1 -gt "68" ]; then
        icon="" #E
    elif [ $1 -gt "23" ]; then
        icon="" #NE
    elif [ $1 -ge "0" ]; then
        icon="" #N
    else
	icon=""
   fi
   echo $icon
}
get_duration() {

    osname=$(uname -s)

    case $osname in
        *BSD) date -r "$1" +%H:%M;;
        *) date --date="@$1" +%H:%M;;
    esac

}

KEY="c1041cba4ff234262fad153226b276fc"
CITY="Boulder,US"
UNITS="metric"
SYMBOL="%{T9}%{T-}"

API="https://api.openweathermap.org/data/2.5"

if [ -n "$CITY" ]; then
    if [ "$CITY" -eq "$CITY" ] 2>/dev/null; then
	CITY_PARAM="id=$CITY"
    else
        CITY_PARAM="q=$CITY"
    fi

    current=$(curl -sf "$API/weather?appid=$KEY&$CITY_PARAM&units=$UNITS")
    forecast=$(curl -sf "$API/forecast?appid=$KEY&$CITY_PARAM&units=$UNITS&cnt=1")
else
    location=$(curl -sf "https://location.services.mozilla.com/v1/geolocate?key=geoclue")

    if [ -n "$location" ]; then
        location_lat="$(echo "$location" | jq '.location.lat')"
        location_lon="$(echo "$location" | jq '.location.lng')"

        current=$(curl -sf "$API/weather?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS")
        forecast=$(curl -sf "$API/forecast?appid=$KEY&lat=$location_lat&lon=$location_lon&units=$UNITS&cnt=1")
    fi
fi

if [ -n "$current" ] && [ -n "$forecast" ]; then
    current_temp=$(echo "$current" | jq ".main.temp" | cut -d "." -f 1)
    current_icon=$(echo "$current" | jq -r ".weather[0].id")

    forecast_temp=$(echo "$forecast" | jq ".list[].main.temp" | cut -d "." -f 1)
    forecast_icon=$(echo "$forecast" | jq -r ".list[].weather[0].id")

    current_wind=$(echo "$current" | jq ".wind.speed")
    wind_mph=$(bc <<<"$current_wind"*"2.236936" | cut -d "." -f 1)
    wind_deg=$(echo "$current" | jq ".wind.deg")


#    if [ "$current_temp" -gt "$forecast_temp" ]; then
#        trend=""
#    elif [ "$forecast_temp" -gt "$current_temp" ]; then
#        trend=""
#    else
#        trend=""
#    fi



    sun_rise=$(echo "$current" | jq ".sys.sunrise")
    sun_set=$(echo "$current" | jq ".sys.sunset")
    now=$(date +%s)

    if [ "$sun_rise" -gt "$now" ]; then
        daytime=" %{T0}$(get_duration "$((sun_rise))")"
        icon_time="night"
    elif [ "$sun_set" -gt "$now" ]; then
        daytime=" %{T0}$(get_duration "$((sun_set))")"
	icon_time="day"
    else
        daytime=" %{T0}$(get_duration "$((sun_rise))")"
	icon_time="none"
    fi

    echo "$(get_icon "$current_icon" "$icon_time") %{T0} $current_temp$SYMBOL |%{T9}  $(get_wind "$wind_deg")  %{T0}$wind_mph mph |%{T9} $daytime"
fi
