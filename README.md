[![Go Report Card](https://goreportcard.com/badge/github.com/archspec/archspec-feature-discovery)](https://goreportcard.com/report/github.com/archspec/archspec-feature-discovery)

# ArchSpec-feature-discovery

[ArchSpec](https://github.com/archspec/archspec) is a sideCard DaemonSet to enable target-arch node feature discovery for Kubernetes
by leveraging [Node-Feature-Discovery](https://github.com/kubernetes-sigs/node-feature-discovery)

## Building the 

Clone this repo

```bash
git clone git@github.com:archspec/archspec-feature-discovery.git
```
Then 

```bash
buildah bud -t quay.io/<user-name>/archspec-feature-discovery:latest -f Dockerfile .
```


#### Quick-start – the short-short version

[Deploy](https://kubernetes-sigs.github.io/node-feature-discovery/v0.7/get-started/deployment-and-usage.html) the Node-feature-Discovery with the [extra option](https://kubernetes-sigs.github.io/node-feature-discovery/v0.7/advanced/master-commandline-reference.html#extra-label-ns) `--extra-label-ns=archspec.io`, then:

``` bash
$ kubectl apply -f manifests/
namespace/archspec-feature-discovery created
serviceaccount/archspec-feature-discovery created
role.rbac.authorization.k8s.io/archspec-feature-discovery created
rolebinding.rbac.authorization.k8s.io/archspec-feature-discovery created
daemonset.apps/archspec-feature-discovery created

$ kubectl get all -n archspec-feature-discovery
NAME                                   READY   STATUS    RESTARTS   AGE
pod/archspec-feature-discovery-ddhnq   1/1     Running   0          7m21s
pod/archspec-feature-discovery-rr9ts   1/1     Running   0          7m21s

NAME                                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                     AGE
daemonset.apps/archspec-feature-discovery   2         2         2       2            2           node-role.kubernetes.io/worker=   7m22

$kubectl get no -o json | jq .items[].metadata.labels |grep archspec
  "archspec.io/cpu.family": "6",
  "archspec.io/cpu.model": "79",
  "archspec.io/cpu.target": "haswell",
  "archspec.io/cpu.vendor": "GenuineIntel",
  "archspec.io/cpu.family": "6",
  "archspec.io/cpu.model": "79",
  "archspec.io/cpu.target": "haswell",
  "archspec.io/cpu.vendor": "GenuineIntel",

```
