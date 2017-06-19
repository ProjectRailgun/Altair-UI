if [ $(npm whoami) != 'lordfriend' ]; then
    echo 'use invalid'
    exit 1;
fi

if [ $(git describe --contains --all HEAD) != 'master' ]; then
    echo 'publish must be done at master branch'
    exit 1;
fi
echo 'user and branch valid, run test'
# unit test
npm test

# build release
echo 'build release'
$(npm bin)/gulp build

# cp files
echo 'copy files'
cp package.json ./dist/
cp .npmignore ./dist/
cp LICENSE ./dist/
cp README.md ./dist/

echo 'publish...'
# publish
cd ./dist
npm publish --access public
