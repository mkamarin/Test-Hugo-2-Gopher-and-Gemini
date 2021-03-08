#!/bin/bash
# Simple test of the Hugo 2 Gopher and Gemini project

hugo2ggtheme=Hugo-2-Gopher-and-Gemini
now=$(date +"%Y-%m-%d-(%H-%M-%S)")
log="$(pwd)/logs/log-$now.log"

echo Start $(date)       2>&1 | tee "$log"
echo Starting in: $(pwd) 2>&1 | tee -a "$log"
echo Log in: "$log"      2>&1 | tee -a "$log"
echo                     2>&1 | tee -a "$log"

for folder in $(ls -d test-hugo-*/) 
do
    echo "==================" 2>&1 | tee -a "$log"
    echo processing "$folder" 2>&1 | tee -a "$log"
    if ! [ -e "$folder"/themes"$hugo2ggtheme" ]; then
        echo Creating "$folder"themes/"$hugo2ggtheme" 2>&1 | tee -a "$log"
        #ln -s ../"$hugo2ggtheme"/ "$folder"themes/"$hugo2ggtheme"
    fi
    pushd "$folder" >/dev/null
    echo Working in: $(pwd) 2>&1 | tee -a "$log"
    ./test.sh               2>&1 | tee -a "$log"
    popd >/dev/null
    rm -f "$folder"themes/"$hugo2ggtheme"  2>&1 | tee -a "$log"
    echo                                   2>&1 | tee -a "$log"
done
echo "==================" 2>&1 | tee -a "$log"
echo                      2>&1 | tee -a "$log"

# rm -f -r -d  test/public-gg-old
# rm -f -r -d  test/themes-old
# mv -f test/public-gg test/public-gg-old
# mv -f test/themes test/themes-old
# mkdir test/themes
# cp -f -r themes/Gopher-Gemini test/themes
# pushd test >/dev/null
# #hugo -D --config config-gg.toml --destination public-gg --layoutDir layouts-gg --disableKinds=sitemap
# themes/Gopher-Gemini/src/hugo2gg.py
# #sshpass -p "KF6rqv+WW6mm" scp -r test/public-gg/gopher ubuntu@pi-server:public/gopher/ubuntu/mike
# #sshpass -p "KF6rqv+WW6mm" scp -r test/public-gg/gemini ubuntu@pi-server:src/JAGS-PHP/hosts/mike
# popd >/dev/null
echo Done $(date) 2>&1 | tee -a "$log"
