# wakatime for zsh

# hook function to send wakatime a tick
send_wakatime_heartbeat() {
    (wakatime --write --plugin zsh-wakatime --notfile --project Terminal --file "/$(waka_filename)"> /dev/null 2>&1 &)
}

# generate text to report as "filename" to the wakatime API
waka_filename() {
    if [ "$WAKATIME_USE_DIRNAME" == "true" ]; then
        # just use the current working directory
        echo "$PWD"
    else
        # only command without arguments to avoid senstive information
        echo "$history[$((HISTCMD-1))]" | cut -d ' ' -f1
    fi
}

add-zsh-hook precmd send_wakatime_heartbeat
