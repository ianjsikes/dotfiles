# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

if (sys).host.name == "Windows" {
    ssh-agent
} else {
    ssh-agent -c | lines | first 2 | parse "setenv {name} {value};" | transpose -i -r -d | load-env
}

let-env ANDROID_HOME = '/Users/ian/Library/Android/sdk'
let-env ANDROID_SDK = '/Users/ian/Library/Android/sdk'
let-env JAVA_HOME = '/Applications/Android Studio Preview.app/Contents/jbr/Contents/Home'
let-env VOLTA_HOME = '/Users/ian/.volta'

let-env OSPATH = if (sys).host.name == "Windows" { $env.Path } else { $env.PATH }

let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '/usr/local/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '~/.local/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '~/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '~/.cargo/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend $'($env.VOLTA_HOME)/bin')

let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend $'($env.ANDROID_HOME)/emulator')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend $'($env.ANDROID_HOME)/tools')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend $'($env.ANDROID_HOME)/platform-tools')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend $'($env.JAVA_HOME)/../../../jre/jdk/Contents/Home/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '/nix/var/nix/profiles/default/bin')
let-env OSPATH = ($env.OSPATH | split row (char esep) | prepend '~/.nix-profile/bin')

if (sys).host.name == "Windows" {
  let-env Path = $env.OSPATH
} else {
  let-env PATH = $env.OSPATH
}

let-env EDITOR = hx

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

