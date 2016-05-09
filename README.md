# Drupal-DB-pull
Pulls the database from one environment to another.

## Installation

1. Download the script to a directory in your PATH
```
wget -P /usr/local/bin/ https://raw.githubusercontent.com/oddhill/Drupal-DB-pull/master/pull_database.sh
```

2. Make the script executable
```
chmod +x /usr/local/bin/pull_database.sh
```


## Usage

1. `cd` to the Drupal root directory.
2. Make sure you have SSH access to the different servers.
3. Make sure that you've created Drush aliases for the different environments.
4. Run `pull_database.sh <source> <target> <reroute_email_address>` where:
  - *Source* is the Drush alias for the source environment, e.g. production
  - *Target* is the Drush alias for the target environment, e.g. default
  - *Reroute email address* is an optional address that you wish to use for Reroute email
