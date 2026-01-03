# laptop-install

1. Install [Homebrew](https://brew.sh):

  ```
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
2. Install [GitHub CLI](https://cli.github.com/):

  ```
  brew install gh
  ```
3. Clone [laptop-install](https://github.com/dunnkers/laptop-install):
  
  ```
  gh auth login
  mkdir -p ~/git
  gh repo clone dunnkers/laptop-install ~/git/dunnkers/laptop-install
  ```
4. Run laptop install script:
  
  ```
  sh ~/git/dunnkers/laptop-install/install.sh
  ```
