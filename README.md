pidgin-regex-notify-plugin
==========================

# What Is It?
This is a Pidgin IM client plugin that allows you to specify a regex pattern
such that if the pattern is match in any open conversation window or chat room
window, it will pop up a dialog.

This plugin is of use if you want to be notified if (for example) your name
is mentioned in an open chat room.

#Installation

## Linux and OSX
To install it, just copy: `PidginNotifyIfMessageMatch.pl` to your
~/.purple/plugins/ directory.  Then you can go to Tools->Plugins.  Find:
"Notify Message Match Plugin" and enable it.  It will ask you to configure it.
Just enter a regex pattern to watch for.

## Microsoft Windows

How to install the plugin for Windows

1. Install Perl if you don't already have it. You can get open source Strawberry Perl version 5.10.1.5 for Windows. Pidgin 2.9.x can only work with Strawberry Perl version 5.10.x. You should install Strawberry Perl version 5.10.x for Pidgin version 2.9.x not newer versions.
2. In Pidgin go to Help:Build Information in the menu. Scroll to the bottom and check for "Perl: Enabled". If Perl is disabled, restart and/or reinstall Pidgin or reinstall Perl until it is enabled.  You may need to put the Strawberry Perl `bin` directory inside the `PATH` environment variable (by default, the Strawberry Perl `bin` directory is `C:\Strawberry\perl\bin`).  Here's [how to change your environment variables](http://www.computerhope.com/issues/ch000549.htm). 
3. Copy `PidginNotifyIfMessageMatch.pl` to either your C:\Program Files\Pidgin\plugins or `C:\Documents and Settings\User\Application Data\.purple\plugins` directory.
