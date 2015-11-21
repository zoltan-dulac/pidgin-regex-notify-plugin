#!/usr/bin/perl
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

use Purple;

my $pluginName = "Notify Message Match Plugin";
my $pluginShortName = "pattern_match_notifier";
my $main_pref = "/plugins/core/$pluginShortName";
my $regexToMatch_pref = "$main_pref/pattern";
my $startDelay = 20; #"$main_pref/startDelay";
my $start_time;

sub prefs_info_cb;
sub pattern_match_chat_msg_cb;

%PLUGIN_INFO = (
    perl_api_version => 2,
    name => $pluginName,
    version => "0.2",
    summary => "Notify if a message matches the given regex pattern.",
    description => "Notify if a message matches the given regex pattern.  Can be used to notify you if a person mentions your user name in a chat.  Can also be used for notifying you when your alias is mentioned.  For example, in HipChat, your user name is this cryptic sequence of numbers that no-one ever uses.  Instead, people use your nickname prefixed by an '@'.  This plugin can be used to notify you when this string is mentioned in chat.",
    author => "Katriana, with small modifications by Zoltan Hawryluk",
    url => "https://github.com/katriana/pidgin-regex-notify-plugin",
    load => "plugin_load",
    unload => "plugin_unload",
    prefs_info => "prefs_info_cb"
);

sub prefs_info_cb {
    my $frame = Purple::PluginPref::Frame->new();
    my $ppref = Purple::PluginPref->new_with_name_and_label(
        $regexToMatch_pref, "Regex to match against received messages");
    $frame->add($ppref);
    # $ppref = Purple::PluginPref->new_with_name_and_label(
    #    $startDelay, "How many seconds from start for plugin to become active");
    # $frame->add($ppref);

    return $frame;
}

#.. we need to update this so we reduce the amount of alerts -- probably by looking at $conv (see https://developer.pidgin.im/doxygen/2.5.2/html/struct__PurpleConversation.html and https://developer.pidgin.im/doxygen/2.5.2/html/conversation-signals.html#received-chat-msg)
sub pattern_match_chat_msg_cb {
    my ($account, $sender, $message, $conv, $flag, $data) = @_;

    my $searchPattern = Purple::Prefs::get_string($regexToMatch_pref);

    my $username = $account->get_username();
    # my $im_data = $conv->get_logging();

    my $is_send = ($flag & 0x0001);
    my $is_recv = ($flag & 0x0002);
    my $time_since_start = time - $start_time;
    

    my $conv_props = "";
    while ( my ($key, $value) = each(%$conv) ) {
        $conv_props .=  "$key => $value\n";
    }

    Purple::Debug::info($pluginName, "pattern callback: Value for $regexToMatch_pref = $searchPattern.\n");
    if ($searchPattern eq "") {
        return;
    }
    if ($message =~ /$searchPattern/) {
        # notify
        Purple::Debug::info($pluginName, "pattern callback: matched message: $message\n");

        #Purple::Notify::message(undef, 2, "Pattern match", "from $sender, data =  $data, to $account, conv = $conv, flag = $flag, pattern matched: $searchPattern", "$message", undef, undef);
        # Purple::Notify::message(undef, 2, "Pattern match", "from $sender, data =  $data, pattern matched: $searchPattern", "$message", undef, undef);
        if ($time_since_start > $startDelay) {
            Purple::Notify::message(undef, 2, "Pattern match", "User $username $data from $sender." , "$message", undef, undef);
        }
	} else {
        Purple::Debug::info($pluginName, "pattern callback: message does not match: $message...\n");
    }
}

sub plugin_init {
    
    return %PLUGIN_INFO;
}

sub plugin_load {
    my $plugin = shift;
    Purple::Debug::info($pluginName, "plugin_load() - $pluginName loaded.\n");

    # Preferences dialog
    # add head
    Purple::Prefs::add_none($main_pref);

    # Here we are adding a set of preferences
    #  The second argument is the default value for the preference.
    Purple::Prefs::add_string($regexToMatch_pref, "");

    my $strval = Purple::Prefs::get_string($regexToMatch_pref);

    Purple::Debug::info($pluginName, "plugin_load: Value for $regexToMatch_pref = $strval.\n");

    #my $account;
    #foreach $account (Purple::Accounts::get_all()) {
    #    Purple::Debug::info($pluginName,
    #        "connected to " .  $account->get_username() . "\n");
    #}

    my $conversation = Purple::Conversations::get_handle();
    $start_time = time;
    Purple::Signal::connect(
        $conversation,
        "received-chat-msg",
        $plugin,
        \&pattern_match_chat_msg_cb,
        "received chat message");

    Purple::Signal::connect(
        $conversation,
        "received-im-msg",
        $plugin,
        \&pattern_match_chat_msg_cb,
        "received IM message");
}

sub plugin_unload {
    my $plugin = shift;
    Purple::Debug::info($pluginName,
        "plugin_unload() - $pluginName Unloaded.\n");
}

