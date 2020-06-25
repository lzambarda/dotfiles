# etcd section
if [ -d /tmp/etcd-download-test ]; then
    export PATH="/tmp/etcd-download-test/:$PATH"
else
    echo "dotfiles: etcd not installed, see https://github.com/etcd-io/etcd/releases"
fi
