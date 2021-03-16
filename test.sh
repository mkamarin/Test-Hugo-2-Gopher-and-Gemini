#!/bin/bash
# Simple test of the Hugo 2 Gopher and Gemini project

hugo2ggtheme=Hugo-2-Gopher-and-Gemini
path2hugo2ggtheme="$(pwd)/../${hugo2ggtheme}/"
now=$(date +"%Y-%m-%d-(%H-%M-%S)")

log="$(pwd)/logs/log-${now}.log"
config="$(pwd)/logs/config.json"
host=""

## Clean up code
function clean_up ()
{
    echo "cleaning up $(pwd)"
    rm -f logs/*
    for folder in $(ls -d test-hugo-*/) 
    do
        rm -f "${folder}themes/${hugo2ggtheme}"

        pushd "${folder}" >/dev/null
        ./test.sh "'${config}'" 'clean'
        popd >/dev/null
    done

    exit
}

function arguments ()
{
    echo "Usage: $0 [[flags] [<paths>]"
    echo
    echo " -c, --clean           Cleans the test output data"
    echo " -j, --json   <file>   Generates a configuration file with"
    echo "                       this name (default logs/config.json)"
    echo " -s, --site   <name>   A host site name (site url)"
    echo " -h, --help            print this message"
    echo " [<path>  ... <path>]  Paths containing Gopher or Gemini sites"
    echo
    echo " This script generates a json configuration file to be used with"
    echo " ggwalker.py. Site and paths are just added to that config file."
    return 0
}

while [ ! -z "$1" ]
do
    case "$1" in
        --clean|-c)
            clean_up
            ;;
        --json|-j)
            shift
            config="$1"
            ;;
        --site|-s)
            shift
            host="$1"
            ;;
        --help|-h)
            arguments
            ;;
        *)
            break
    esac
    shift
done

## Execute the tests
echo "Start $(date)"            2>&1 | tee    "${log}" 
echo "Starting in: $(pwd)"      2>&1 | tee -a "${log}" 
echo "Log in   : ${log}"        2>&1 | tee -a "${log}" 
echo "Config in: ${config}"     2>&1 | tee -a "${log}" 
echo                            2>&1 | tee -a "${log}" 

## Create config file
if [ ! -z "${host}" ]; then
    host="gopher://${host}\", \"gemini://${host}"
fi

echo "{\"site_urls\": [ \"${host}\" ], \"paths\": [" > "${config}"
echo "$1"
while [ ! -z "$1" ]
do
    echo "\"$1\"," >> "${config}"
    shift
done

## Now let do each test
for folder in $(ls -d test-hugo-*/) 
do
    echo "=================="   2>&1 | tee -a "${log}" 
    echo "Processing ${folder}" 2>&1 | tee -a "${log}" 

    if ! [ -e "${folder}themes/${hugo2ggtheme}" ]; then
        echo "Creating ${folder}themes/${hugo2ggtheme}" 2>&1 | tee -a "${log}"
        ln -s "${path2hugo2ggtheme}" "${folder}themes/${hugo2ggtheme}"
    fi

    pushd "${folder}" >/dev/null
    ./test.sh "${config}"     2>&1 | tee -a "${log}"
    popd >/dev/null

    echo                        2>&1 | tee -a "${log}" 
done

echo " \"\" ]}"  >> "${config}"
echo "=================="       2>&1 | tee -a "${log}"
echo                            2>&1 | tee -a "${log}" 

echo Done $(date)               2>&1 | tee -a "${log}" 

