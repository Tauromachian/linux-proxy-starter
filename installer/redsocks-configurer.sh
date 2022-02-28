#!/bin/bash

HOME_ROUTE="~";
DOCUMENTS_ROUTE="$HOME_ROUTE/Documents";

touch `$DOCUMENTS_ROUTE/iptables.sh`;
touch `$DOCUMENTS_ROUTE/proxy.sh`;

cp "../iptables.sh" "$DOCUMENTS_ROUTE/iptables.sh";
cp "../proxy.sh" "$DOCUMENTS_ROUTE/proxy.sh";


if [ -f "$HOME_ROUTE/.bash_aliases" ];
then
  echo "alias start-proxy="sh $DOCUMENTS_ROUTE/proxy.sh"" >> "$HOME_ROUTE/.bash_aliases";
else
  touch "$HOME_ROUTE/.bash_aliases";
  echo "alias start-proxy="sh $DOCUMENTS_ROUTE/proxy.sh"" >> "$HOME_ROUTE/.bash_aliases";
fi