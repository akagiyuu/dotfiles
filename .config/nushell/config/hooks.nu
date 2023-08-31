export def get-hooks [] {
    {
        pre_prompt: [{ null }] # run before the prompt is shown
        pre_execution: [{ null }] # run before the repl input is run
        env_change: {
            PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
        }
        display_output: { table } # run before the output of a command is drawn, example: `{ if (term size).columns >= 100 { table -e } else { table } }`
        command_not_found: { null } # return an error message when a command is not found
    }
}