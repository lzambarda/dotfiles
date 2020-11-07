# etcd section
if [ -z "$(which etcd)" ]; then
	echo "dotfiles: etcd not installed, see https://github.com/etcd-io/etcd/releases"
	echo "dotfiles: brew install etcd?"
fi
