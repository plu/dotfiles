
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# The next line updates PATH for the Google Cloud SDK.
if [ -f "/usr/local/google-cloud-sdk/path.bash.inc" ]; then . "/usr/local/google-cloud-sdk/path.bash.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "/usr/local/google-cloud-sdk/completion.bash.inc" ]; then . "/usr/local/google-cloud-sdk/completion.bash.inc"; fi
