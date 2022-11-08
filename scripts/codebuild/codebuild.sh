# install

# install yarn
npm install -g yarn || { echo "Npm install failed" ;exit 1; }

# install gatsby
yarn global add gatsby-cli@4.23.0 || { echo "FATAL: Could not install Gatsby Command Line Tools";exit 1; }

# set yarn as default package manager for gatsby
mkdir ~/.config/gatsby
cp ./scripts/codebuild/config.json ~/.config/gatsby/

# install app dependencies
yarn install || { echo "yarn install failed" ;exit 1; }

yarn build

yarn deploy
