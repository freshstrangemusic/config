# `$file` is the path to this file, which will be a symlink to a file in the
# freshstrangemusic/config repository. We can then determine the absolute path
# to the root of the checkout.
set -x _FSM_CONFIG_CHECKOUT (realpath (dirname (realpath $file))/../../../../../..)
