alias k=kubectl

function k_dirty() {
	watch 'kubectl get po --all-namespaces | grep -v -e "1\/1\|2\/2\|3\/3\|4\/4\|5\/5" | grep -v Completed'
}
alias kdirty=k_dirty

function k_pod_node() {
	kubectl get pod -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,NODE:.spec.nodeName --all-namespaces
}

function k_job_from_cron() {
	kubectl create job --from="$1" "$2"
}

function k_breakdown() {
    kubectl get po --all-namespaces -o=jsonpath="{range .items[*]}{.metadata.namespace}:{.metadata.name}{'\n'}{range .spec.containers[*]}  cpu req:{.resources.requests.cpu}{'\t'}  mem req:{.resources.requests.memory}{'\n'}{end}{end}"
}

# A better alternative is k rollout -n hendrix-staging-1 restart deployment.apps/orchestrator-queue
function k_wipe_pods() {
    if [ $# -ne "1" ]; then
        echo "Error, usage is: k_wipe_pods <namespace>"
        return 1
    fi
    for pod in $(kubectl get -n $1 pod | grep -oE "^[a-z0-9\-]+"); do
        kubectl -n $1 delete --wait=false pod $pod
    done
}

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

