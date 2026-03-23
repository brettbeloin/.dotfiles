source /usr/share/cachyos-fish-config/cachyos-config.fish

if test -f ~/.fishTmux.sh
    bash .fishTmux.sh

    if not set -q TMUX
        tmux a -t Cachy-fish
    end
end

# my custom aliases
alias sysEdit='vim ~/.config/fish/config.fish && source ~/.config/fish/config.fish'
alias sysRead='cat ~/.config/fish/config.fish'
alias sysOff='sudo systemctl hibernate'
alias vim='nvim'
alias gEmacs='emacsclient -c -a "nvim"'
alias tEmacs='emacsclient -t -a "nvim"'
#alias mux='tmux a'
alias google='google-chrome-stable'
alias zen='zen-browser'
alias df="df -h"
# alias gotop="gotop --averagecpu --fahrenheit --rate 1s --mbps"
alias lsblk="lsblk -lf"
alias mount="udisksctl mount -b"
alias pkgSearch="yay -Ss"
alias search="pacman -Qi"
alias trm="trash -v"
alias mkgErr="argv[1] 2&>> ~/.errors/coding/Error_(date +%D).log"

zoxide init fish | source
fzf --fish | source

set -gx XDG_SCREENSHOTS_DIR ~/Pictures/Screenshots/
fish_add_path ~/.cargo/bin/
fish_add_path ~/.config/emacs/bin/
fish_add_path ~/.local/bin
set -gx NODE_PATH $HOME/.local/lib/node_modules $NODE_PATH
set -gx npm_config_prefix $HOME/.local
set -gx PATH $PATH $HOME/go/bin

# systemctl --user start tmux-setup.service

function git-change
    set current_branch (git branch --show-current)

    if test "$current_branch" = main
        git switch dev
    else if test "$current_branch" = dev
        git switch main
    end
end

set -gx PNPM_HOME "/home/john/.local/share/pnpm"
if not contains $PNPM_HOME $PATH
    fish_add_path $PNPM_HOME
end

eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
op completion fish | source

function javaFX
    set -l proj_name $argv[1]
    set -l group_id $argv[2]
    if test -z "$group_id"
        set group_id "com.csc180.brettbeloin"
    end

    mvn archetype:generate \
        -DarchetypeGroupId=org.openjfx \
        -DarchetypeArtifactId=javafx-archetype-simple \
        -DarchetypeVersion=0.0.6 \
        -DgroupId="$group_id" \
        -DartifactId="$proj_name" \
        -Djavafx-version=21 \
        -DinteractiveMode=false

    sed -i 's/<maven.compiler.source>.*<\/maven.compiler.source>/<maven.compiler.source>21<\/maven.compiler.source>/g' "$proj_name/pom.xml"
    sed -i 's/<maven.compiler.target>.*<\/maven.compiler.target>/<maven.compiler.target>21<\/maven.compiler.target>/g' "$proj_name/pom.xml"

    sed -i '/<properties>/a \        <javafx.version>21.0.1</javafx.version>' "$proj_name/pom.xml"

    sed -i 's/<version>21<\/version>/<version>${javafx.version}<\/version>/g' "$proj_name/pom.xml"

    cd "$proj_name"

    set -l path "src/main/java/"(string replace -a . / "$group_id")
    mv "$path/App.java" "$path/Main.java"
    sed -i 's/class App/class Main/g' "$path/Main.java"

    sed -i "s/<mainClass>.*App<\/mainClass>/<mainClass>$group_id.Main<\/mainClass>/g" pom.xml

    nvim "$path/Main.java"
end

function mav
    set -l proj_name $argv[1]
    set -l group_id $argv[2]
    if test -z "$group_id"
        set group_id "com.mycompany.app"
    end

    mvn archetype:generate \
        -DgroupId="$group_id" \
        -DartifactId="$proj_name" \
        -DarchetypeArtifactId=maven-archetype-quickstart \
        -DarchetypeVersion=1.4 \
        -DinteractiveMode=false

    sed -i 's/<maven.compiler.source>1.7<\/maven.compiler.source>/<maven.compiler.source>21<\/maven.compiler.source>/g' "$proj_name/pom.xml"
    sed -i 's/<maven.compiler.target>1.7<\/maven.compiler.target>/<maven.compiler.target>21<\/maven.compiler.target>/g' "$proj_name/pom.xml"

    sed -i '/<pluginManagement>/i \
    <plugins>\
      <plugin>\
        <groupId>org.codehaus.mojo</groupId>\
        <artifactId>exec-maven-plugin</artifactId>\
        <version>3.1.0</version>\
        <configuration>\
          <mainClass>'"$group_id"'.Main</mainClass>\
        </configuration>\
      </plugin>\
      <plugin>\
        <groupId>org.apache.maven.plugins</groupId>\
        <artifactId>maven-shade-plugin</artifactId>\
        <version>3.5.1</version>\
        <executions>\
          <execution>\
            <phase>package</phase>\
            <goals><goal>shade</goal></goals>\
            <configuration>\
              <transformers>\
                <transformer implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">\
                  <mainClass>'"$group_id"'.Main</mainClass>\
                </transformer>\
              </transformers>\
            </configuration>\
          </execution>\
        </executions>\
      </plugin>\
    </plugins>' "$proj_name/pom.xml"

    cd "$proj_name"

    set -l path "src/main/java/"(string replace -a . / "$group_id")
    mv "$path/App.java" "$path/Main.java"
    sed -i 's/class App/class Main/g' "$path/Main.java"

    nvim "$path/Main.java"
end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
set -gx PATH /home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/john/.local/share/pnpm:/home/john/.local/bin:/home/john/.config/emacs/bin:/home/john/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/lib/rustup/bin:/home/john/.local/share/JetBrains/Toolbox/scripts:/home/john/.local/share/JetBrains/Toolbox/scripts /home/john/go/bin
