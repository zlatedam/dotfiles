# Remove startup message 
$env.config.show_banner = false

# Set PATH
$env.PATH = (
    $env.PATH 
    | split row (char esep)
    | prepend '/opt/homebrew/bin'
    | prepend '/opt/homebrew/sbin'
    | prepend $'($env.HOME)/.local/bin'
)

# Set default editor
$env.EDITOR = 'vim'
$env.VISUAL = 'vim'

# xQuartz compatability to set display 0 permanently 

