#!/bin/bash

# Clearify the argument names.
source=$1
target=$2
reroute_email_addess=$3

if [ "$source" = "$target" ]; then
  echo 'Source and target can not be the same.'
  exit 0
fi

if [ "$target" = "production" ]; then
  echo 'Pull to production is not allowed.'
  exit 0
fi

if [ "$source" = "development" ]; then
  echo 'Pull from development is not allowed.'
  exit 0
fi

read -p "This will destroy the database in $target by copying the database from $source. Are you sure you wish to continue? (y/n)? " answer
case ${answer:0:1} in
    y|Y )
      # Simply continue with the code below.
    ;;
    * )
      # Exit if the user said anything other than yes.
      exit 0
    ;;
esac

# Handle pull to development.
if [ "$target" = "development" ]; then
  # Drop every database table.
  drush sql-drop -y

  # Pull the database from the source.
  drush sql-sync @$source default -y

  # Set Tadaa to development.
  echo 'Switching to development via Tadaa...'
  drush ts development

  # Set the reroute email address if specified.
  if [ "$reroute_email_addess" ]; then
    drush vset reroute_email_address 'olof.johansson@oddhill.se'
  fi
fi

# Handle pull to staging.
if [ "$target" = "staging" ]; then
  # Drop every database table.
  drush @staging sql-drop -y

  # Pull the database from the source.
  drush sql-sync @$source @staging -y

  # Set Tadaa to staging.
  echo 'Switching to staging via Tadaa...'
  drush @staging ts staging

  # Set the reroute email address if specified.
  if [ "$reroute_email_addess" ]; then
    drush @staging vset reroute_email_address 'olof.johansson@oddhill.se'
  fi
fi
