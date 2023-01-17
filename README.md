# Check Dependencies

This script will check the dependencies and devDependencies of a specified .json or .js file and compare them to a list of existing packages. 

## Usage 
1. Make sure you have npm installed. If not, please install npm before proceeding. 
2. Run the script by entering the path of the .json or .js file you want to check.
3. If the script does not find an existingpackages.txt file in the current directory, it will install all packages and create the file for you.
4. The script will output any unregistered dependencies it finds. If none are found, it will display a message saying so.

## Tips for finding json files 
- Use Github search to find json files containing the word "dependencies" by searching for "dependencies filetype:json"
- Other useful dorks include "inanchor:"Index Of /", "allinurl:package.json", "intitle:index.of id_rsa -id_rsa.pub", and "intitle:index.of package.json"

If you find dependencies that are not regsitered, they are most likely being used internally. By registering them yourself, their default location will try and retrieve them online. 
