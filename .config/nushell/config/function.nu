def "cargo search" [ query: string, --limit=10] {
    ^cargo search $query --limit $limit
    | lines
    | each {
        |line| if ($line | str contains "#") {
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)" +# (?P<description>.+)'
        } else {
            $line | parse --regex '(?P<name>.+) = "(?P<version>.+)"'
        }
    }
    | flatten
}

# Function querying free online English dictionary API for definition of given word(s)
def dictionary [...word #word(s) to query the dictionary API but they have to make sense together like "martial law", not "cats dogs"
] {
	let query = ($word | str join %20)
    let link = ('https://api.dictionaryapi.dev/api/v2/entries/en/' + ($query|str replace ' ' '%20'))
    let output = (http get $link | rename word)
    let w = ($output.word | first)

    if $w == "No Definitions Found" {
        echo $output.word
    } else {
  	    echo $output
        | get meanings
        | flatten
        | select partOfSpeech definitions
        | flatten
        | flatten
        | reject "synonyms"
        | reject "antonyms"
    }
}

def get-package-size [] {
    pacman -Qi
    | lines
    | chunk-by {|it| $it != "" }
    | filter {|table| ($table | length) > 1 }
    | each { |table| $table | str join "\n" | detect columns --no-headers --guess | reject "column1" | transpose --header-row | select Name "Installed Size"  }
    | reduce { |it, acc| $it ++ $acc }
    | update 'Installed Size' { |size| $size.'Installed Size' | into filesize  }
    | sort-by 'Installed Size'
}
