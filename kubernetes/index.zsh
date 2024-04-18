alias k=kubectl

function k_dirty() {
	watch 'kubectl get po --all-namespaces | grep -v -e "1\/1\|2\/2\|3\/3\|4\/4\|5\/5\|6\/6" | grep -v Completed'
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

function k_popn() {
    kubectl get pods --all-namespaces | awk '{print $1}' | sort | uniq -c | sort -k1 -n -r
}

function k_pod_count() {
    kubectl get pods -A -o json | jq -r '.items[].spec.nodeName' | awk '{a[$1]++} END{for (node in a) {print node" "a[node]}}'
    kubectl get nodes -o json | jq '.items[] | {node: .metadata.name, type: .metadata.labels."node.kubernetes.io/instance-type", max:.status.allocatable.pods}'
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

