#!/bin/sh
printf '%s' "$(gpg --quiet --batch --decrypt ~/.config/calcurse/caldav/pass.gpg)"
