## You can use github search for finding files 
## dependencies in:file language:json
## Other useful dorks = inanchor:"Index Of /" 
## allinurl:package.json
## intitle:index.of id_rsa -id_rsa.pub
## intitle:index.of package.json

if ! command -v npm &> /dev/null
then
    echo "npm is not installed. Please install npm and try again."
    exit 1
fi

if [ ! -f "existingpackages.txt" ]; then
    echo "existingpackages.txt not found. Installing all packages and creating file..."
    all-the-package-names >> existingpackages.txt
fi

while true; do
    echo "Enter a site link ending with .json or .js: "
    read site
    if [[ $site == *".json" || $site == *".js" ]]; then
        if curl --output /dev/null --silent --head --fail "$site"; then
            break
        else
            echo "Please enter a valid link."
        fi
    else
        echo "Please enter a link ending with .json or .js."
    fi
done

curl --silent $site | jq '.dependencies | keys[]' | sed 's/\"//g' | tr -d ',' >> dependencies.txt
curl --silent $site | jq '.devDependencies | keys[]' | sed 's/\"//g' | tr -d ',' >> devdependencies.txt
sort -u dependencies.txt -o dependencies.txt
sort -u devdependencies.txt -o devdependencies.txt

while IFS= read -r line; do 
    if ! grep -q "$line" existingpackages.txt; then
        echo "Unregistered dependencies found:"
        echo "$line"
        found=1
    fi
done < dependencies.txt

while IFS= read -r line; do 
    if ! grep -q "$line" existingpackages.txt; then
        echo "Unregistered dependencies found:"
        echo "$line"
        found=1
    fi
done < devdependencies.txt

if [ -z "$found" ]; then
    echo "No unregistered dependencies found"
fi

rm -f devdependencies.txt
rm -f dependencies.txt
