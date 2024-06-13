Command line tool (kubectl)
Kubernetes provides a command line tool for communicating with a Kubernetes cluster's control plane, using the Kubernetes API.

This tool is named kubectl.

For configuration, kubectl looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the --kubeconfig flag.

This overview covers kubectl syntax, describes the command operations, and provides common examples. For details about each command, including all the supported flags and subcommands, see the kubectl reference documentation.

For installation instructions, see Installing kubectl; for a quick guide, see the cheat sheet. If you're used to using the docker command-line tool, kubectl for Docker Users explains some equivalent commands for Kubernetes.

Syntax
Use the following syntax to run kubectl commands from your terminal window:

kubectl [command] [TYPE] [NAME] [flags]
where command, TYPE, NAME, and flags are:

command: Specifies the operation that you want to perform on one or more resources, for example create, get, describe, delete.

TYPE: Specifies the resource type. Resource types are case-insensitive and you can specify the singular, plural, or abbreviated forms. For example, the following commands produce the same output:

kubectl get pod pod1
kubectl get pods pod1
kubectl get po pod1
NAME: Specifies the name of the resource. Names are case-sensitive. If the name is omitted, details for all resources are displayed, for example kubectl get pods.

When performing an operation on multiple resources, you can specify each resource by type and name or specify one or more files:

To specify resources by type and name:

To group resources if they are all the same type: TYPE1 name1 name2 name<#>.
Example: kubectl get pod example-pod1 example-pod2

To specify multiple resource types individually: TYPE1/name1 TYPE1/name2 TYPE2/name3 TYPE<#>/name<#>.
Example: kubectl get pod/example-pod1 replicationcontroller/example-rc1

To specify resources with one or more files: -f file1 -f file2 -f file<#>

Use YAML rather than JSON since YAML tends to be more user-friendly, especially for configuration files.
Example: kubectl get -f ./pod.yaml
flags: Specifies optional flags. For example, you can use the -s or --server flags to specify the address and port of the Kubernetes API server.

Caution:
Flags that you specify from the command line override default values and any corresponding environment variables.
If you need help, run kubectl help from the terminal window.

In-cluster authentication and namespace overrides
By default kubectl will first determine if it is running within a pod, and thus in a cluster. It starts by checking for the KUBERNETES_SERVICE_HOST and KUBERNETES_SERVICE_PORT environment variables and the existence of a service account token file at /var/run/secrets/kubernetes.io/serviceaccount/token. If all three are found in-cluster authentication is assumed.

To maintain backwards compatibility, if the POD_NAMESPACE environment variable is set during in-cluster authentication it will override the default namespace from the service account token. Any manifests or tools relying on namespace defaulting will be affected by this.

POD_NAMESPACE environment variable

If the POD_NAMESPACE environment variable is set, cli operations on namespaced resources will default to the variable value. For example, if the variable is set to seattle, kubectl get pods would return pods in the seattle namespace. This is because pods are a namespaced resource, and no namespace was provided in the command. Review the output of kubectl api-resources to determine if a resource is namespaced.

Explicit use of --namespace <value> overrides this behavior.

How kubectl handles ServiceAccount tokens

If:

there is Kubernetes service account token file mounted at /var/run/secrets/kubernetes.io/serviceaccount/token, and
the KUBERNETES_SERVICE_HOST environment variable is set, and
the KUBERNETES_SERVICE_PORT environment variable is set, and
you don't explicitly specify a namespace on the kubectl command line
then kubectl assumes it is running in your cluster. The kubectl tool looks up the namespace of that ServiceAccount (this is the same as the namespace of the Pod) and acts against that namespace. This is different from what happens outside of a cluster; when kubectl runs outside a cluster and you don't specify a namespace, the kubectl command acts against the namespace set for the current context in your client configuration. To change the default namespace for your kubectl you can use the following command:

kubectl config set-context --current --namespace=<namespace-name>


https://kubernetes.io/docs/reference/kubectl/
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands
