# Kubernetes Master Nodes (Dell OptiPlex 3050 Micro)

## Hardware Specifications (3 Nodes)

* **Model:** Dell OptiPlex 3050 Micro
* **CPU:** Intel Core i5-6500T (4 cores, 4 threads, 2.5GHz base, 3.1GHz turbo, 35W TDP)
  * **Features:** Supports [[llnotes/AES-NI.md|AES-NI]].
  * **Justification:** Cost-effective, low power consumption, quiet, sufficient for [[llnotes/Kubernetes-Control-Plane.md|Kubernetes control plane]] tasks. See [[02-decisions/hardware_selection.md|Hardware Selection Justification]].
* **RAM:** 16GB DDR4 (2x8GB configuration at 2400MHz or 2666MHz)
  * **Justification:** Optimal for [[llnotes/etcd.md|etcd]] and core [[llnotes/Kubernetes-Control-Plane.md|Kubernetes control plane]] components for [[04-platform/high_availability_design.md|HA]]. Upgraded from original 8GB (2x4GB).
* **Storage:** 256GB M.2 NVMe [[llnotes/SSD.md|SSD]]
  * **Justification:** Fast OS/K8s boot, optimal performance for [[llnotes/etcd.md|etcd]] (which is [[llnotes/Disk-I-O-Latency.md|latency-sensitive]]).
  * **Note:** **NOT** used for [[07-storage/ceph_cluster_design.md|Ceph OSDs]] to ensure maximum control plane stability.
* **Network:** 1x 1GbE RJ-45 (onboard NIC)
* **Power Supply Unit (PSU):** [e.g., 65W or 90W external brick, typical for Micro]

## Software

* **Operating System:** [[llnotes/Operating-System-(Nodes).md|Talos Linux]]
* **Kubernetes:** [[04-platform/kubernetes_distro.md#Talos Kubernetes|Talos Kubernetes]] (as control-plane nodes).

## Role in Architecture

These three nodes form the highly available (HA) [[llnotes/Kubernetes-Control-Plane.md|Kubernetes control plane]]. They are responsible for:

* Running the [[llnotes/etcd.md|etcd]] distributed key-value store.
* Hosting the [[llnotes/Kubernetes-API.md|Kubernetes API Server]], `kube-scheduler`, and `kube-controller-manager`.
* Orchestrating the entire [[llnotes/Kubernetes-cluster.md|Kubernetes cluster]].
* Managed via [[llnotes/Talos-API.md|Talos API]] (using `talosctl`) due to [[llnotes/Immutable-infrastructure.md|immutable OS]] design.
