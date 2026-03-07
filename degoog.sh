#!/bin/bash
# Nothing Phone 2a Plus Degoogle Script
# Run this after connecting phone with USB debugging enabled

# Test connection first
adb devices

# CORE GOOGLE SERVICES (Disable these for full degoogle)
adb shell pm uninstall --user 0 com.google.android.gms                    # Google Play Services
adb shell pm uninstall --user 0 com.android.vending                       # Google Play Store
adb shell pm uninstall --user 0 com.google.android.gsf                    # Google Services Framework
adb shell pm uninstall --user 0 com.google.android.gsf.login              # Google Login Service

# GOOGLE APPS
adb shell pm uninstall --user 0 com.google.android.apps.maps              # Google Maps
adb shell pm uninstall --user 0 com.google.android.apps.messaging         # Google Messages
adb shell pm uninstall --user 0 com.google.android.gm                     # Gmail
adb shell pm uninstall --user 0 com.google.android.googlequicksearchbox   # Google Search/App
adb shell pm uninstall --user 0 com.google.android.youtube                # YouTube
adb shell pm uninstall --user 0 com.google.android.apps.youtube.music     # YouTube Music
adb shell pm uninstall --user 0 com.google.android.calendar               # Google Calendar
adb shell pm uninstall --user 0 com.google.android.contacts               # Google Contacts
adb shell pm uninstall --user 0 com.google.android.apps.docs              # Google Docs
adb shell pm uninstall --user 0 com.google.android.keep                   # Google Keep
adb shell pm uninstall --user 0 com.google.android.apps.photos            # Google Photos
adb shell pm uninstall --user 0 com.google.android.videos                 # Google TV/Play Movies
adb shell pm uninstall --user 0 com.google.android.music                  # Google Play Music (legacy)

# GOOGLE SYSTEM APPS
adb shell pm uninstall --user 0 com.google.android.apps.wellbeing         # Digital Wellbeing
adb shell pm uninstall --user 0 com.google.android.apps.restore           # Restore backup
adb shell pm uninstall --user 0 com.google.android.syncadapters.contacts  # Google Contact Sync
adb shell pm uninstall --user 0 com.google.android.syncadapters.calendar  # Google Calendar Sync
adb shell pm uninstall --user 0 com.google.android.feedback               # Google Feedback
adb shell pm uninstall --user 0 com.google.android.printservice.recommendation # Google Print

# GOOGLE ASSISTANT & VOICE
adb shell pm uninstall --user 0 com.google.android.apps.googleassistant   # Google Assistant
adb shell pm uninstall --user 0 com.google.android.tts                    # Google Text-to-Speech
adb shell pm uninstall --user 0 com.google.android.apps.tachyon           # Google Duo/Meet

# GOOGLE CONNECTIVITY
adb shell pm uninstall --user 0 com.google.android.apps.turbo             # Device Health Services
adb shell pm uninstall --user 0 com.google.android.gms.location.history   # Location History
adb shell pm uninstall --user 0 com.google.android.marvin.talkback        # TalkBack (accessibility)

# CHROME & WEBVIEW (Be careful with WebView!)
adb shell pm uninstall --user 0 com.android.chrome                        # Chrome browser
# WARNING: Don't disable WebView unless you have alternative installed:
# adb shell pm uninstall --user 0 com.google.android.webview             # WebView

# AR & EXTRA SERVICES
adb shell pm uninstall --user 0 com.google.ar.core                        # ARCore
adb shell pm uninstall --user 0 com.google.android.apps.walletnfcrel      # Google Wallet
adb shell pm uninstall --user 0 com.google.android.apps.subscriptions.red # Google One
adb shell pm uninstall --user 0 com.google.android.partnersetup           # Google Partner Setup
adb shell pm uninstall --user 0 com.google.android.setupwizard            # Google Setup Wizard
adb shell pm uninstall --user 0 com.google.android.configupdater          # Config Updater

# TELEMETRY & ANALYTICS
adb shell pm uninstall --user 0 com.google.android.apps.carrier.carrierwifi # Carrier WiFi
adb shell pm uninstall --user 0 com.google.android.apps.diagnosticstool    # Diagnostics
adb shell pm uninstall --user 0 com.google.android.apps.work.oobconfig     # Work profile config

echo "Reboot your phone."
