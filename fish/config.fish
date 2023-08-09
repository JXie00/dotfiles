set fish_key_bindings fish_user_key_bindings

function fh
    set cmd (history | fzf --preview "echo {} | awk '{\$1=\"\"; print \$0}'")
    if test -n "$cmd"
        eval $cmd
    end
end

function fk
   set pid (ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if test -n "$pid"
        set signal
        if test -n "$argv[1]"
            set signal "-$argv[1]"
        else
            set signal -9
        end
        echo $pid | xargs kill $signal
    end
end

function fcd --description "Fuzzy change directory"
    if set -q argv[1]
        set searchdir $argv[1]
    else
        set searchdir $HOME
    end

    # https://github.com/fish-shell/fish-shell/issues/1362
    set -l tmpfile (mktemp)
    fdfind . $searchdir -H -t d | fzf > $tmpfile
    set -l destdir (cat $tmpfile)
    rm -f $tmpfile

    if test -z "$destdir"
        return 1
    end

    cd $destdir
end



starship init fish | source
direnv hook fish | source
