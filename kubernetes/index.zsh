alias k=kubectl

export AWS_REGION=eu-west-1
export BUCKET_NAME=blokur-com-k8s-state-store
export KOPS_DOMAIN=blokur.com
export KOPS_CLUSTER_NAME=cluster.blokur.com
export AWS_AZ_1=${AWS_REGION}a
export AWS_AZ_2=${AWS_REGION}b
export AWS_AZ_3=${AWS_REGION}c
export AWS_MASTER_REGION=${AWS_AZ_1},${AWS_AZ_2},${AWS_AZ_3}
export KOPS_STATE_STORE=s3://${BUCKET_NAME}

function helm() {
    if ! type __start_helm >/dev/null 2>&1; then
        source <(command helm completion zsh)
    fi
    command helm "$@"
}

function kubectl() {
    if ! type __start_kubectl >/dev/null 2>&1; then
        source <(command kubectl completion zsh)
    fi

    command kubectl "$@"
}
