# starship init fish | source
if test -z ASYNC_STARSHIP_DISABLED
    return
end

set ASYNC_STARSHIP_TMPDIR $TMPDIR
if test -d $RAMDIR
    set ASYNC_STARSHIP_TMPDIR $RAMDIR
end

set ASYNC_STARSHIP_PROMPT_DIR "$ASYNC_STARSHIP_TMPDIR/async-starship"
set ASYNC_STARSHIP_LEFT_PROMPT_FILE "$ASYNC_STARSHIP_PROMPT_DIR/$STARSHIP_SESSION_KEY-left.prompt"
set ASYNC_STARSHIP_LAST_PWD $PWD
set ASYNC_STARSHIP_PROMPT_LINES ""
set ASYNC_STARSHIP_PROMPT ""

function __async_starship_read_prompt
    while read -l line
        echo $line
    end < $ASYNC_STARSHIP_LEFT_PROMPT_FILE
end

function __async_starship_init
    mkdir $ASYNC_STARSHIP_PROMPT_DIR 2>/dev/null
    set ASYNC_STARSHIP_PROMPT_LINES (starship prompt)
    string join \n $ASYNC_STARSHIP_PROMPT_LINES | read -z ASYNC_STARSHIP_PROMPT
end

function __async_starship_ready_prompt_default
    set ASYNC_STARSHIP_PROMPT_LINES (__async_starship_read_prompt)
    string join \n $ASYNC_STARSHIP_PROMPT_LINES | read -z ASYNC_STARSHIP_PROMPT
end

function __async_starship_ready_prompt_new_directory
    set ASYNC_STARSHIP_PROMPT_LINES $ASYNC_STARSHIP_PROMPT_LINES[..-2] (starship prompt --profile directory)
    string join \n $ASYNC_STARSHIP_PROMPT_LINES | read -z ASYNC_STARSHIP_PROMPT
end

function __async_starship_spawn_process --on-event fish_prompt
    switch "$fish_key_bindings"
        case fish_hybrid_key_bindings fish_vi_key_bindings
            set STARSHIP_KEYMAP "$fish_bind_mode"
        case '*'
            set STARSHIP_KEYMAP insert
    end
    set STARSHIP_CMD_PIPESTATUS $pipestatus
    set STARSHIP_CMD_STATUS $status
    set STARSHIP_DURATION "$CMD_DURATION$cmd_duration"
    set STARSHIP_JOBS (count (jobs -p))
    env \
        SHLVL=(math $SHLVL - 1) \
        COLUMNS=$COLUMNS \
        STARSHIP_KEYMAP=$STARSHIP_KEYMAP \
        STARSHIP_CMD_PIPESTATUS=$STARSHIP_CMD_PIPESTATUS \
        STARSHIP_CMD_STATUS=$STARSHIP_CMD_STATUS \
        STARSHIP_DURATION=$STARSHIP_DURATION \
        STARSHIP_JOBS=$STARSHIP_JOBS \
        ASYNC_STARSHIP_PROMPT_DIR=$ASYNC_STARSHIP_PROMPT_DIR \
        ASYNC_STARSHIP_LEFT_PROMPT_FILE=$ASYNC_STARSHIP_LEFT_PROMPT_FILE \
    sh -c '
        mkdir $ASYNC_STARSHIP_PROMPT_DIR 2>/dev/null
        ASYNC_STARSHIP_LEFT_RANDOM_PROMPT_FILE=$ASYNC_STARSHIP_LEFT_PROMPT_FILE.$RANDOM-tmp.prompt
        starship prompt \
            --terminal-width=$COLUMNS \
            --status=$STARSHIP_CMD_STATUS \
            --pipestatus="$STARSHIP_CMD_PIPESTATUS" \
            --keymap=$STARSHIP_KEYMAP \
            --cmd-duration=$STARSHIP_DURATION \
            --jobs=$STARSHIP_JOBS \
            > $ASYNC_STARSHIP_LEFT_RANDOM_PROMPT_FILE
        mv -f $ASYNC_STARSHIP_LEFT_RANDOM_PROMPT_FILE $ASYNC_STARSHIP_LEFT_PROMPT_FILE

        kill -s USR1 $PPID
    ' &
    disown $last_pid
end

function __async_starship_signal_handler --on-signal SIGUSR1
    __async_starship_ready_prompt_default
    commandline -f repaint
end

function __async_starship_cleanup --on-event fish_exit
    rm -f $ASYNC_STARSHIP_LEFT_PROMPT_FILE
end

__async_starship_init

function fish_prompt
    if test $PWD != $ASYNC_STARSHIP_LAST_PWD
        __async_starship_ready_prompt_new_directory
    end

    echo -n $ASYNC_STARSHIP_PROMPT

    if test $PWD != $ASYNC_STARSHIP_LAST_PWD
        set ASYNC_STARSHIP_LAST_PWD $PWD
        __async_starship_spawn_process
    end
end

function fish_right_prompt
    # TODO: Implement right prompt
end
