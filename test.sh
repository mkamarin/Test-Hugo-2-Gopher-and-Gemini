#!/bin/bash
# Simple test of the Hugo 2 Gopher and Gemini project

hugo2ggtheme=Hugo-2-Gopher-and-Gemini
GopherandGeminiWalker=Gopher-and-Gemini-Walker

path2hugo2ggtheme="$(pwd)/../${hugo2ggtheme}/"
path2GopherandGeminiWalker="$(pwd)/../${GopherandGeminiWalker}/src/ggwalker.py"
now=$(date +"%Y-%m-%d-(%H-%M-%S)")

log="$(pwd)/logs/log-${now}.log"
config="$(pwd)/logs/config.json"
host=""
walker="no"
arguments=""

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

function do_diff ()
{
    echo "diff this directory against ../../hugo-tests/Saved-for-comparison/Test-Hugo-2-Gopher-and-Gemini"
    diff -qbr --no-dereference . ../../hugo-tests/Saved-for-comparison/Test-Hugo-2-Gopher-and-Gemini | grep --invert-match "\.\/\.git\/\|\/logs:\|-gg-sav:"
}

function arguments ()
{
    echo "Usage: $0 [[flags] [<paths>]"
    echo
    echo " -c, --clean              Cleans the test output data"
    echo " -a, --arguments '<args>' Passes arguments down to hugo2gg"
    echo " -j, --json   <file>   Generates a configuration file with"
    echo "                       this name (default logs/config.json)"
    echo " -s, --site   <name>   A host site name (site url)"
    echo " -h, --help            print this message"
    echo " -d, --diff            diff against previusly copied data"
    echo " -w, --walker          Execute ggwalker with config file"
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
        --arguments|-a)
            shift
            arguments="$1"
            ;;
        --site|-s)
            shift
            host="$1"
            ;;
        --diff|-d)
            do_diff
            exit 0
            ;;
        --walker|-w)
            walker="OK"
            ;;
        --help|-h)
            arguments
            exit 0
            ;;
        *)
            break
    esac
    shift
done

## Execute the tests
echo "..."                      2>&1 | tee    "${log}" 
echo "-------------"            2>&1 | tee    "${log}" 
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
    ./test.sh "${config}" "${arguments}" 2>&1 | tee -a "${log}"
    if [ $? -ne 0 ]; then
        echo "Exit with errors" 2>&1 | tee -a "${log}"
        exit $?
    fi
    popd >/dev/null

    echo                        2>&1 | tee -a "${log}" 
done

echo " \"\" ]}"  >> "${config}"
echo "=================="       2>&1 | tee -a "${log}"
echo                            2>&1 | tee -a "${log}" 

if [ $walker == "OK" ]; then
    ${path2GopherandGeminiWalker} offline --config ${config} 2>&1 | tee -a "${log}" 
fi

echo Done $(date)               2>&1 | tee -a "${log}" 

