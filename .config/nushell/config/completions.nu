export def get-completions [] {
    let carapace_completer = {|spans: list<string>|
        carapace $spans.0 nushell $spans
        | from json
        | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
    }
    let fish_completer = {|spans|
        fish --command $'complete "--do-complete=($spans | str join " ")"'
        | $"value(char tab)description(char newline)" + $in
        | from tsv --flexible --no-infer
    }
    let external_completer = {|spans|
        let expanded_alias = (scope aliases | where name == $spans.0 | get -i 0 | get -i expansion)
        let spans = (if $expanded_alias != null  {
            $spans | skip 1 | prepend ($expanded_alias | split words)
        } else { $spans })

        {
            nu: $fish_completer
        } | get -i $spans.0 | default $carapace_completer | do $in $spans
    }

    {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: $carapace_completer # check 'carapace_completer' above as an example
        }
    }
}