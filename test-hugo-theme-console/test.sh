#!/bin/bash
# Simple test of the Hugo 2 Gopher and Gemini project
hugo2ggtheme=Hugo-2-Gopher-and-Gemini

rm -f -r -d  public-gg-sav

## Clean up code
if [ "$2" = "clean" ]; then
    echo "cleaning up $(pwd)"

    rm -f -r -d  public
    rm -f -r -d  public-gg

    exit
fi

config="$1"
echo "Working in: $(pwd)"

mv -f public-gg public-gg-sav

echo "Executing hugo base line"
hugo
echo

themes/${hugo2ggtheme}/src/hugo2gg.py
echo "\"$(pwd)/public-gg/gopher\"," >> "${config}"
echo "\"$(pwd)/public-gg/gemini\"," >> "${config}"

