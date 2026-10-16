# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/

[Environment]::SetEnvironmentVariable(
    "XDG_CONFIG_HOME",
    "${env:HOMEDRIVE}${env:HOMEPATH}\.config",
    [System.EnvironmentVariableTarget]::User)
