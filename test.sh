#!/bin/bash
# Simple test of the Hugo 2 Gopher and Gemini project

hugo2ggtheme=Hugo-2-Gopher-and-Gemini
path2hugo2ggtheme="$(pwd)/../${hugo2ggtheme}/"
now=$(date +"%Y-%m-%d-(%H-%M-%S)")

log="$(pwd)/logs/log-${now}.log"
err="$(pwd)/logs/err-${now}.log"

## Clean up code
if [ "$1" = "clean" ]; then
    echo "cleaning up $(pwd)"
    rm -f logs/*
    for folder in $(ls -d test-hugo-*/) 
    do
        rm -f "${folder}themes/${hugo2ggtheme}"

        pushd "${folder}" >/dev/null
        ./test.sh "'${err}'" 'clean'
        popd >/dev/null
    done

    exit
fi

## Execute the tests
echo "Start $(date)"            2>&1 | tee    "${log}" "${err}"
echo "Starting in: $(pwd)"      2>&1 | tee -a "${log}" "${err}"
echo "Log in: ${log}"           2>&1 | tee -a "${log}" "${err}"
echo                            2>&1 | tee -a "${log}" "${err}"

for folder in $(ls -d test-hugo-*/) 
do
    echo "=================="   2>&1 | tee -a "${log}" "${err}"
    echo "Processing ${folder}" 2>&1 | tee -a "${log}" "${err}"

    if ! [ -e "${folder}themes/${hugo2ggtheme}" ]; then
        echo "Creating ${folder}themes/${hugo2ggtheme}" 2>&1 | tee -a "${log}"
        ln -s "${path2hugo2ggtheme}" "${folder}themes/${hugo2ggtheme}"
    fi

    pushd "${folder}" >/dev/null
    ./test.sh "'${err}'"        2>&1 | tee -a "${log}"
    popd >/dev/null

    echo                        2>&1 | tee -a "${log}" "${err}"
done
echo "=================="       2>&1 | tee -a "${log}"
echo                            2>&1 | tee -a "${log}" "${err}"

echo Done $(date)               2>&1 | tee -a "${log}" "${err}"

