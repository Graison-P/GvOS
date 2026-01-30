# ~/.bash_profile: executed by bash(1) for login shells.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# include .profile if it exists
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi
