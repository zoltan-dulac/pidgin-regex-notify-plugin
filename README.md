HSLP (Hipchat Suck Less Plugin) for Pidgin 
==========================================

# What Is It?

This is a set of plugins that make the user experience of Pidgin users connecting to Hipchat not suck so bad.

It includes:

* `*PidginNotifyIfMessageMatch.pl*` - a Pidgin IM client plugin that allows you to specify a regex pattern such that if the pattern is match in any open conversation window or chat room window, it will pop up a dialog.  For Pidgin users of Hipchat, setting the regex to be `@all|@here` will allow them to be alerted to global messages in Hipchat chatrooms.
* a special "smilie theme" that contains both Hipchat emoticons as well as Emoji

It will include in the future:

* [Hipchat currently doesn't have the Jabber/XMPP names the same as their `@mention` names](https://help.hipchat.com/forums/138883-suggestions-ideas/suggestions/3560359-make-jabber-usernames-the-same-as-the-mention-nam).  I want the plugin to be able to handle this somehow.
* automatic image embedding when a URL is sent (this would be useful for more than Hipchat).

Currently, this is a work in progress.  I am messing around with this to see if it is possible to make Hipchat suck less on Pidgin.  It is not complete, but feel free to download and send feedback.

#Installation

## Linux and OSX
To install it, just copy: `PidginNotifyIfMessageMatch.pl` to your
`~/.purple/plugins/` directory.  Then you can go to Tools->Plugins.  Find:
"Notify Message Match Plugin" and enable it.  It will ask you to configure it.
Just enter a regex pattern to watch for.

## Microsoft Windows

How to install the plugin for Windows

1. Install Perl if you don't already have it. You can get open source Strawberry Perl version 5.10.1.5 for Windows. Pidgin 2.9.x can only work with Strawberry Perl version 5.10.x. You should install Strawberry Perl version 5.10.x for Pidgin version 2.9.x not newer versions.
2. In Pidgin go to Help:Build Information in the menu. Scroll to the bottom and check for "Perl: Enabled". If Perl is disabled, restart and/or reinstall Pidgin or reinstall Perl until it is enabled.  You may need to put the Strawberry Perl `bin` directory inside the `PATH` environment variable (by default, the Strawberry Perl `bin` directory is `C:\Strawberry\perl\bin`).  Here's [how to change your environment variables](http://www.computerhope.com/issues/ch000549.htm). 
3. Copy `PidginNotifyIfMessageMatch.pl` to either your `C:\Program Files\Pidgin\plugins` or `C:\Documents and Settings\_<user>_\Application Data\.purple\plugins` directory (where `_<user>_` should be replaced by your own Windows username).
4. Find: "Notify Message Match Plugin" and enable it.  It will ask you to configure it. Just enter a regex pattern to watch for.

# Why would you use this

* In Hipchat, messages to users `@all` and `@here` are meant to be global messages.  Using a regex to capture these users (such as `@all|@here`) would alert a pidgin user of these messages.
* Sometimes you may want to be alerted when, say, your name is said in a chat room, IRC channel or elsewhere.

## Acknowledgments

* This plugin was originally written by GitHub user [Katriana](https://github.com/katriana).  
* [Zoltan Hawryluk](http://useragentman.com) is currently adding stuff to it to make Pidgin support for Hipchat not suck so much (this is not Pidgin's fault.  Hipchat has extended XMPP to do some unstandard things).
* Information about how to get Perl plugins to work under Windows was stolen from the [forward2mobile HowToInstall page](https://code.google.com/p/forward2mobile/wiki/HowToInstall).

