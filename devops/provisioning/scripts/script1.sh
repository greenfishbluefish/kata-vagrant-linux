#!/bin/bash

# Notes:
#   * This script (like all provisioners) runs as root. So, no need to "sudo".
#   * All actions in this script are idempotent. This means the same end result
#     no matter how many times it is run. q.v. README.md for more discussion.

# Use good Bash practices. For more information, q.v.
#   * https://google.github.io/styleguide/shell.xml
set -eu

# This test is to make provisioning run faster the second time (such as when
# running the test suite). This step adds roughly 20 seconds. This is also an
# idempotent check.
if ! dpkg -l apache2 &>/dev/null; then
  apt-get -qq update
  apt-get -qq --assume-yes install apache2
fi

USERGROUP='acme'

# Don't try and create the group or user if it already exists. Idempotency.
getent group  $USERGROUP &>/dev/null || groupadd $USERGROUP
getent passwd $USERGROUP &>/dev/null || useradd -g $USERGROUP $USERGROUP

########################################
# This is the section about configuring Apache for the ACME site.

# Create variables to name things, especially if it's used more than once.
CONF_FILE="/etc/apache2/sites-available/${USERGROUP}.conf"

# Recreating a file from scratch is idempotent - the same end result. It's also
# easier (and safer) than trying to figure out what's changed and undoing just
# those changes.
cat > $CONF_FILE <<- EOF
<VirtualHost *:80>
  ServerName acme.dev
  DocumentRoot /var/www/acme

  <Directory /var/www/acme>
    Order allow,deny
    Allow from all
  </Directory>
</VirtualHost>
EOF

# The -R parameter to chown is "apply recursively".
chown -R ${USERGROUP}.${USERGROUP} $CONF_FILE
chmod 0644 $CONF_FILE

ENABLE_FILE="/etc/apache2/sites-enabled/${USERGROUP}.conf"

# ln --force will overwrite the symbolic link. This means ln won't error out if
# the link already exists. It will also update the link (if it's changed) to
# what we want it to be. Idempotent.
ln --symbolic --force $CONF_FILE $ENABLE_FILE

# Delete the default Apache configuration file provided by the apache2 package.
rm --force /etc/apache2/sites-enabled/000*

#
########################################

########################################
# This is the section about the ACME site itself. Normally, this content would
# be added by another step. In our abbreviated example, we'll create it here.

SITE_DIR='/var/www/acme'
INDEX_FILE="${SITE_DIR}/index.html"

mkdir -p $SITE_DIR
echo "Hello from ACME" > $INDEX_FILE

chown -R ${USERGROUP}.${USERGROUP} $SITE_DIR
chmod 0755 $SITE_DIR
chmod 0644 $INDEX_FILE

#
########################################

# Now that we've done everything, restart Apache to pick everything up.
service apache2 restart
